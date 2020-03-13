//
//  MBHUD.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/13/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import UIKit
import MBProgressHUD

class MBHUD {
    
    private static var mbHud: MBProgressHUD?
    
    static func success(_ message: String?) {
        guard let view = UIApplication.shared.keyWindow else {
            return
        }
        
        let mbHud = MBProgressHUD.showAdded(to: view, animated: true)
        mbHud.isUserInteractionEnabled = false
        mbHud.customView = UIImageView(image: UIImage(named: "hud-success"))
        mbHud.mode = .customView
        mbHud.label.text = message
        mbHud.hide(animated: true, afterDelay: 3)
    }
    
    static func error(_ message: String?) {
        guard let view = UIApplication.shared.keyWindow else {
            return
        }
        
        let mbHud = MBProgressHUD.showAdded(to: view, animated: true)
        mbHud.isUserInteractionEnabled = false
        mbHud.mode = .text
        mbHud.label.text = message
        mbHud.label.numberOfLines = 0
        mbHud.hide(animated: true, afterDelay: 3)
    }
    
    static func progress(_ message: String?) {
        guard let view = UIApplication.shared.keyWindow else {
            return
        }
        mbHud = MBProgressHUD.showAdded(to: view, animated: true)
        mbHud?.label.text = message;
    }
    
    static func progressHidden() {
        mbHud?.hide(animated: true)
    }
}
