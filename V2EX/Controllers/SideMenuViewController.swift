//
//  SideMenuViewController.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/11/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import UIKit
import Router

class SideMenuViewController: UITableViewController {
    
    struct ItemData {
        let name: String
        let image: UIImage
        let imageColor: UIColor
        let actionURL: URL?
    }
    
    private lazy var datas = [[ItemData]]()
    
    fileprivate lazy var router: Router = {
        let router = Router()
        router.bind("/logout") { (req) in
            /// TODO: logout
        }
        return router
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "V2EX"
        
        refreshDatas()
        
        tableView.backgroundColor = SIDEMENU_BG_COLOR
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let itemData = datas[indexPath.section][indexPath.row]
        cell.textLabel?.text = itemData.name
        cell.imageView?.image = itemData.image
        cell.imageView?.tintColor = itemData.imageColor
        cell.selectionStyle = itemData.actionURL == nil ? .none : .blue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemData = datas[indexPath.section][indexPath.row]
        if let url = itemData.actionURL {
            action(forURL: url)
        }
    }
}

// MARK: - action
@objc
extension SideMenuViewController {
    func refreshDatas() {
        datas.removeAll()
        
        datas.append([
            ItemData(
                name: "sign in".localized,
                image: UIImage(named: "login")!.withRenderingMode(.alwaysTemplate),
                imageColor: PRIMARY_COLOR,
                actionURL: URL(string: "\(ROOT_URL)/account/sign_in")!
            ),
            ItemData(
                name: "sign up".localized,
                image: UIImage(named: "profile")!.withRenderingMode(.alwaysTemplate),
                imageColor: PRIMARY_COLOR,
                actionURL: URL(string: "\(ROOT_URL)/account/sign_up")!
            )
        ])
        
        datas.append([
            ItemData(
                name: "wiki".localized,
                image: UIImage(named: "wiki")!.withRenderingMode(.alwaysTemplate),
                imageColor: PRIMARY_COLOR,
                actionURL: URL(string: "\(ROOT_URL)/wiki")!
            )
        ])
        
        let build = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
        datas.append([
            ItemData(
                name: "copyright".localized,
                image: UIImage(named: "copyright")!.withRenderingMode(.alwaysTemplate),
                imageColor: PRIMARY_COLOR,
                actionURL: URL(string: COPYRIGHT_URL)!
            ),
            ItemData(
                name: "v\(APP_VERSION) (build \(build))",
                image: UIImage(named: "versions")!.withRenderingMode(.alwaysTemplate),
                imageColor: PRIMARY_COLOR,
                actionURL: nil
            )
        ])
        
        self.tableView.reloadData()
    }
}

// MARK: - private
@objc
extension SideMenuViewController {
    
    fileprivate func action(forURL url: URL) {
        guard let host = url.host else {
            return
        }
        if host != URL(string: ROOT_URL)!.host! {
            UIApplication.shared.openURL(url)
        } else if router.match(URL(string: url.path)!) == nil {
            dismiss(animated: true, completion: {
                if let host = url.host, host != URL(string: ROOT_URL)!.host! {
                    //TurbolinksSessionLib.shared.safariOpen(url)
                } else {
                    //TurbolinksSessionLib.shared.action(.Advance, path: url.path)
                }
            })
        }
    }
}
