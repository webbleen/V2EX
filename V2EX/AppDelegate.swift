//
//  AppDelegate.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/10/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import XCGLogger

let log: XCGLogger = {
    let log = XCGLogger.default
    #if DEBUG
        log.outputLevel = .debug
        log.levelDescriptions[.verbose] = "🗯"
        log.levelDescriptions[.debug] = "🔹"
        log.levelDescriptions[.info] = "ℹ️"
        log.levelDescriptions[.warning] = "⚠️"
        log.levelDescriptions[.error] = "‼️"
        log.levelDescriptions[.severe] = "💣"
    #else
        log.outputLevel = .none
    #endif
    return log
}()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    fileprivate lazy var rootViewController: RootViewController = {
        return RootViewController()
    }()
    
    fileprivate func initAppearance() {
        UINavigationBar.appearance().theme = true
        UITabBar.appearance().theme = true
        UIToolbar.appearance().theme = true

        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: BLACK_COLOR], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: PRIMARY_COLOR], for: .selected)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initAppearance()
        let navigationController = ThemeNavigationController(rootViewController: rootViewController)
        navigationController.view.backgroundColor = .white
        window?.rootViewController = navigationController
        return true
    }
}

extension UINavigationBar {
    var theme: Bool {
        get { return false }
        set {
            self.barStyle = .default
            self.isTranslucent = false
            self.tintColor = PRIMARY_COLOR
            self.barTintColor = NAVBAR_BG_COLOR

            self.backIndicatorImage = UIImage(named: "back")
            self.backIndicatorTransitionMaskImage = UIImage(named: "back")
        }
    }
}

extension UIToolbar {
    var theme: Bool {
        get { return false }
        set {
            self.barStyle = .default
            self.tintColor = PRIMARY_COLOR
            self.barTintColor = TABBAR_BG_COLOR
            
            let navBorder = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1))
            navBorder.backgroundColor = NAVBAR_BORDER_COLOR
            self.addSubview(navBorder)
        }
    }
}

extension UITabBar {
    var theme: Bool {
        get { return false }
        set {
            self.barStyle = .default
            self.isTranslucent = false

            self.tintColor = PRIMARY_COLOR
            self.barTintColor = TABBAR_BG_COLOR

            // Border top line
            let navBorder = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1))
            navBorder.backgroundColor = NAVBAR_BORDER_COLOR
            self.addSubview(navBorder)
        }
    }
}

extension UIApplication {
    /// 获取应用主UINavigationController
    static var appNavigationController: ScrollingNavigationController {
        return UIApplication.shared.keyWindow!.rootViewController as! ScrollingNavigationController
    }
}
