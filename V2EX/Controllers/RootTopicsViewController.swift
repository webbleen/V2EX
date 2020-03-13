//
//  RootTopicsViewController.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/11/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import UIKit

class RootTopicsViewController: TopicsViewController {
    
    
    fileprivate var filterData = TopicsFilterViewController.NodeData.listType(.latest)
    
    fileprivate lazy var badgeLabel: UILabel = {
        let view = UILabel(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        view.clipsToBounds = true
        view.layer.cornerRadius = view.bounds.height / 2.0
        view.backgroundColor = UIColor.red
        view.textColor = UIColor.white
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationsButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 44))
        notificationsButton.setImage(UIImage(named: "notifications")?.imageWithColor(PRIMARY_COLOR), for: .normal)
        notificationsButton.addTarget(self, action: #selector(notificationsAction), for: .touchUpInside)
        let notificationsView = UIView(frame: notificationsButton.frame)
        notificationsView.addSubview(notificationsButton)
        notificationsView.addSubview(badgeLabel)
        badgeLabel.center.x = notificationsButton.frame.maxX - 3
        badgeLabel.frame.origin.y = notificationsButton.center.y - badgeLabel.frame.height
        let notificationsItem = UIBarButtonItem(customView: notificationsView)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem.fixNavigationSpacer(),
            notificationsItem,
            UIBarButtonItem.narrowButtonItem(image: UIImage(named: "search"), target: self, action: #selector(searchAction)),
            UIBarButtonItem.narrowButtonItem(image: UIImage(named: "filter"), target: self, action: #selector(filterAction)),
        ]
        
        resetTitle(filterData)
        reloadTopics(filterData)
        refreshBadgeLabel()
    }
    
    override func loadTopics(offset: Int, limit: Int, callback: @escaping (APICallbackResponse, [Topic]?) -> ()) {
        APIService.getLastestTopic(callback: callback)
    }
}

// MARK: - action methods
@objc
extension RootTopicsViewController {
    
    func filterAction() {
        let vc = TopicsFilterViewController.show()
        vc.selectedData = filterData
        vc.onChangeSelect = { [weak self] (sender) in
            guard let `self` = self, let data = sender.selectedData else {
                return
            }
            self.filterData = data
            self.resetTitle(data)
            self.reloadTopics(data)
            sender.close()
        }
    }
    
    func searchAction() {
        
    }
    
    func notificationsAction() {
        
    }
    
}


// MARK: - private methods

extension RootTopicsViewController {
    
    fileprivate func resetTitle(_ filterData: TopicsFilterViewController.NodeData) {
        /// TODO:
        
        tabBarController?.title = navigationItem.title
    }
    
    fileprivate func load(nodeID: Int, offset: Int) {
        self.nodeID = nodeID
        self.tableView.mj_header?.beginRefreshing()
    }
    
    fileprivate func reloadTopics(_ filterData: TopicsFilterViewController.NodeData) {
        load(nodeID: 0, offset: 0)
    }
    
    fileprivate func refreshBadgeLabel() {
        /// TODO:
        badgeLabel.isHidden = false
        badgeLabel.text = "5"
    }
    
}
