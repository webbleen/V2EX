//
//  TopicDetailsViewController.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/17/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import UIKit

class TopicDetailsViewController: WebViewController {
    
    private(set) var topicId: Int!
    fileprivate var likeButton: UIButton!
    fileprivate var followButton: UIButton!
    
    convenience init(topicId: Int) {
        self.init(path: "\(topicId)")
        self.topicId = topicId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setToolbars()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.setToolbarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    func setToolbars() {
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor.white
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        
        let (backItem, _) = UIBarButtonItem.narrowButtonItem2(image: UIImage(named: "back"), target: self, action: #selector(backAction))
        
        let (likeItem, likeBtn) = UIBarButtonItem.narrowButtonItem2(image: UIImage(named: "like"), target: self, action: #selector(likeAction(_:)))
        likeBtn.frame.size.width = 50
        likeBtn.titleLabel?.font = .systemFont(ofSize: 13)
        likeBtn.setTitleColor(PRIMARY_COLOR, for: .normal)
        likeButton = likeBtn
        
        let (followItem, followBtn) = UIBarButtonItem.narrowButtonItem2(image: UIImage(named: "subscription"), target: self, action: #selector(followAction(_:)))
        followButton = followBtn
        
        let (moreItem, _) = UIBarButtonItem.narrowButtonItem2(image: UIImage(named: "dropdown"), target: self, action: #selector(moreAction))
        
        let flexibleBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [backItem, flexibleBar, likeItem, flexibleBar, followItem, moreItem]
    }
}

// MARK: - action
@objc
extension TopicDetailsViewController {
    
    func likeAction(_ button: UIButton) {
        
    }
    
    func followAction(_ button: UIButton) {
        
    }
    
    func moreAction() {
        
    }
}
