//
//  RootViewController.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/11/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import UIKit
import SideMenu

class RootViewController: UITabBarController {

    fileprivate func setupSideMenu() {
        SideMenuManager.default.menuLeftNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sideMenuController") as? UISideMenuNavigationController
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPresentMode = .viewSlideOut
        SideMenuManager.default.menuAnimationBackgroundColor = UIColor.gray
    }
    
    fileprivate func setupViewControllers() {
        let topicsController = RootTopicsViewController()
        viewControllers = [topicsController]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isHidden = true
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem.fixNavigationSpacer(),
            UIBarButtonItem.narrowButtonItem(image: UIImage(named: "menu"), target: self, action: #selector(displaySideMenu))
        ]
        delegate = self
        
        setupSideMenu()
        setupViewControllers()
        resetNavigationItem(viewControllers![selectedIndex])
    }
    
    @objc func displaySideMenu() {
        let presentSideMenuController = {
            if let sideMenuController = SideMenuManager.default.menuLeftNavigationController {
                self.present(sideMenuController, animated: true, completion: nil)
            }
        }
        
        presentSideMenuController()
    }
    
    fileprivate func resetNavigationItem(_ viewController: UIViewController) {
        navigationItem.title = viewController.navigationItem.title
        navigationItem.titleView = viewController.navigationItem.titleView
        navigationItem.rightBarButtonItems = viewController.navigationItem.rightBarButtonItems
    }
}

extension RootViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        resetNavigationItem(viewController)
    }
}
