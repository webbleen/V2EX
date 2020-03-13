//
//  TopicsFilterViewController.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/13/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON

class TopicsFilterViewController: UIViewController {
    
    /// list接口排序类型
    ///
    /// - hot: 最热主题
    /// - latest: 最新主题
    enum ListType: String {
        case hot
        case latest
    }
    
    enum NodeData {
        case listType(ListType)
        case node(id: Int, name: String, title: String)
        
        func getTitle() -> String {
            switch self {
            case let .listType(type):
                switch type {
                case .hot:
                    return "type hot".localized
                case .latest:
                    return "type latest".localized
                }
            case let .node(_, _, title):
                return title
            }
        }
        
        // MARK: - 重载运算符
        static func ==(v1: NodeData, v2: NodeData) -> Bool {
            switch (v1, v2) {
            case let (.listType(type1), .listType(type2)) where type1 == type2:
                return true
            case let (.node(id1, _, _), .node(id2, _, _)) where id1 == id2:
                return true
            default:
                return false
            }
        }
    }
    
    var selectedData: NodeData?
    var onChangeSelect: ((TopicsFilterViewController) -> ())?
    var onCancel: ((TopicsFilterViewController) -> ())?
    
    fileprivate struct GroupData {
        let name: String
        let nodes: [NodeData]
    }
    fileprivate var groupDatas = [GroupData]()
    fileprivate var parentWindow: UIWindow?
    
    fileprivate let cellIdentifier = "NODECELL"
    fileprivate let headerIdentifier = "cacheNodesJSONKey"
    
    fileprivate lazy var closeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let colNumber: CGFloat = 4
        let cellMargin: CGFloat = 10
        let cellWidth = (self.view.bounds.size.width - (colNumber + 1) * cellMargin) / colNumber
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: floor(cellWidth), height: 30)
        layout.minimumLineSpacing = cellMargin
        layout.minimumInteritemSpacing = cellMargin
        layout.sectionInset = UIEdgeInsets(top: cellMargin, left: cellMargin, bottom: cellMargin, right: cellMargin)
        layout.headerReferenceSize = CGSize(width: self.view.bounds.size.width, height: 30)
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor(white: 1, alpha: 0.9)
        view.register(TopicsFilterNodeCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        view.register(TopicsFilterNodeSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerIdentifier)
        
        return view
    }()
    
    fileprivate lazy var cellNormalImage: UIImage? = {
        let cellSize = (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        return UIImage.roundedCorner(imageSize: cellSize, radius: 5, backgroundColor: UIColor.clear, borderWidth: 1, borderColor: PRIMARY_COLOR)
    }()
    
    fileprivate lazy var cellSelectedImage: UIImage? = {
        let cellSize = (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        return UIImage.roundedCorner(imageSize: cellSize, radius: 5, backgroundColor: PRIMARY_COLOR, borderWidth: 0, borderColor: PRIMARY_COLOR)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(closeButton)
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            let topConstraint: ConstraintMakerEditable
            if #available(iOS 11.0, *) {
                topConstraint = make.top.equalTo(view.safeAreaLayoutGuide)
            } else {
                topConstraint = make.top.equalToSuperview()
            }
            topConstraint.offset(44)
            make.left.bottom.right.equalToSuperview()
        }
        closeButton.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.top)
        }
        
        initGroupDatas()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

// MARK: - private
extension TopicsFilterViewController {
    
    fileprivate func addGroupDatas(nodes: [Node]?, isSync: Bool) {
        guard let nodes = nodes, nodes.count > 0 else {
            return
        }
        
        let selectedData = self.selectedData
        var scrollToIndexPath: IndexPath?
        var nodeGroupDatas = [GroupData]()
        
        func sortAndCreateNodeGroupDatas() {
            let nodeDic = nodes.map { [$0.name, $0] }
            let filterNode = nodes.sorted {
                $0.parentNodeName != $1.parentNodeName ? $0.parentNodeName < $1.parentNodeName : $0.name < $1.name
            }.filter {
                $0.parentNodeName != ""
            }
            var nodeList = [NodeData]()
            var prevparentNodeName = filterNode.first!.parentNodeName
            
            for node in filterNode {
                if node.parentNodeName != prevparentNodeName {
                    let parentNode = nodes.filter { $0.name == prevparentNodeName }
                    nodeGroupDatas.append(GroupData(name: parentNode.first?.title ?? prevparentNodeName, nodes: nodeList))
                    nodeList = [NodeData]()
                    prevparentNodeName = node.parentNodeName
                    
                }
                let nodeData = NodeData.node(id: node.id, name: node.name, title: node.title)
                if scrollToIndexPath == nil && selectedData != nil && selectedData! == nodeData {
                    scrollToIndexPath = IndexPath(item: nodeList.count, section: nodeGroupDatas.count + 1)
                }
                nodeList.append(nodeData)
            }
            if nodeList.count > 0 {
                let parentNode = nodes.filter { $0.name == prevparentNodeName }
                nodeGroupDatas.append(GroupData(name: parentNode.first?.title ?? prevparentNodeName, nodes: nodeList))
            }
        }
        
        func displayNodeGroupDatas() {
            self.groupDatas = [self.groupDatas[0]] + nodeGroupDatas
            self.collectionView.reloadData()
            if let indexPath = scrollToIndexPath {
                self.collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
            }
        }
        
        if isSync == true {
            sortAndCreateNodeGroupDatas()
            displayNodeGroupDatas()
        } else {
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
                sortAndCreateNodeGroupDatas()
                DispatchQueue.main.async {
                    displayNodeGroupDatas()
                }
            }
        }
    }
    
    fileprivate func initGroupDatas() {
        let nodes = [
            NodeData.listType(.hot),
            NodeData.listType(.latest),
        ]
        groupDatas.append(GroupData(name: "all topics".localized, nodes: nodes))
        
        APIService.getAllNodes() {  [weak self] (response, result) in
            guard let `self` = self, let nodes = result else {
               return
            }
            
            self.addGroupDatas(nodes: nodes, isSync: false)
        }
    }
    
}

// MARK: - public
extension TopicsFilterViewController {
    
    static func show() -> TopicsFilterViewController {
        let vc = TopicsFilterViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        window.windowLevel = .alert
        window.makeKeyAndVisible()
        window.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            window.alpha = 1
        })
        vc.parentWindow = window
        return vc
    }
    
    @objc func close() {
        UIView.animate(withDuration: 0.3, animations: {
            self.parentWindow?.alpha = 0
        }, completion: { _ in
            self.parentWindow = nil
        })
    }
    
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension TopicsFilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return groupDatas.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupDatas[section].nodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! TopicsFilterNodeSectionHeaderView
            view.title = groupDatas[(indexPath as NSIndexPath).section].name
            return view
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let node = groupDatas[(indexPath as NSIndexPath).section].nodes[(indexPath as NSIndexPath).item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TopicsFilterNodeCell
        cell.normalImage = cellNormalImage
        cell.selectedImage = cellSelectedImage
        cell.title = node.getTitle()
        cell.isSelected = selectedData == nil ? false : node == selectedData!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let node = groupDatas[(indexPath as NSIndexPath).section].nodes[(indexPath as NSIndexPath).item]
        selectedData = node
        onChangeSelect?(self)
    }
    
    
    
    
}


