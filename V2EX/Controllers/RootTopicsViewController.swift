//
//  RootTopicsViewController.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/11/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import UIKit

class RootTopicsViewController: TopicsViewController {
    
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
    }
    
    override func loadTopics(offset: Int, limit: Int, callback: @escaping (APICallbackResponse, [Topic]?) -> ()) {
        
    }
}

// MARK: - action methods
@objc
extension RootTopicsViewController {
    
    func filterAction() {
        
    }
    
    func searchAction() {
        
    }
    
    func notificationsAction() {
        
    }
    
}
