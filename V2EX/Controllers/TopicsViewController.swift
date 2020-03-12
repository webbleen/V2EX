//
//  TopicsViewController.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/11/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import UIKit
import AMScrollingNavbar

class TopicsViewController: UITableViewController {
    fileprivate let kCellReuseIdentifier = "TOPIC_CELL"
    fileprivate var isLoading = false
    fileprivate var errorView: ErrorView? = nil
    
    let defaultLimit = 40
    var topicList: [Topic]?
    var nodeID = 0
    
    func loadTopics(offset: Int, limit: Int, callback: @escaping (APICallbackResponse, [Topic]?) -> ()) {
        fatalError("loadTopics(offset:callback:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(tableView, delay: 50.0)
            navigationController.scrollingNavbarDelegate = self
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.stopFollowingScrollView()
            scrollingNavigationController(navigationController, didChangeState: .expanded)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearsSelectionOnViewWillAppear = true
        tableView.register(TopicCell.self, forCellReuseIdentifier: kCellReuseIdentifier)
        // color: #F0F0F0
        tableView.separatorColor = UIColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        tableView.estimatedRowHeight = 56
        tableView.headerWithRefreshingBlock { [weak self] in
            guard let `self` = self else {
                return
            }
            self.errorView?.removeFromSuperview()
            self.load(offset: 0, limit: self.defaultLimit)
        }
        tableView.footerWithRefreshingBlock { [weak self] in
            guard let `self` = self else {
                return
            }
            self.load(offset: self.topicList!.count, limit: self.defaultLimit)
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicList == nil ? 0 : topicList!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellReuseIdentifier, for: indexPath) as! TopicCell
        cell.data = topicList![(indexPath as NSIndexPath).row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// TODO:
    }
}

extension TopicsViewController: ScrollingNavigationControllerDelegate {
    func scrollingNavigationController(_ controller: ScrollingNavigationController, didChangeState state: NavigationBarState) {
        switch state {
        case .collapsed:
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
        case .expanded:
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            navigationController?.navigationBar.shadowImage = nil
        case .scrolling: break
        }
    }
}


// MARK: - public
extension TopicsViewController {
    
    func load(offset: Int, limit: Int) {
        if isLoading { return }
        isLoading = true
        
        loadTopics(offset: offset, limit: limit) { [weak self] (response, result) in
            
        }
    }
    
}

// MARK: - action
@objc
extension TopicsViewController {
    
    func errorViewRetryAction() {
        tableView.mj_header?.beginRefreshing()
    }
    
}

// MARK: - private
extension TopicsViewController {
    
    fileprivate func presentError(_ error: V2Error) {
        errorView?.removeFromSuperview()
        
        errorView = Bundle.main.loadNibNamed("ErrorView", owner: self, options: nil)!.first as? ErrorView
        if errorView == nil {
            return
        }
        
        errorView!.retryButton.addTarget(self, action: #selector(errorViewRetryAction), for: .touchUpInside)
        errorView!.error = error
        view.addSubview(errorView!)
        errorView!.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
            var screenSize = UIScreen.main.bounds.size
            screenSize.height -= 64 + 49
            make.size.equalTo(screenSize)
        }
    }
    
}