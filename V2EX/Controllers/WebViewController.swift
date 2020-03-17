//
//  WebViewController.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/17/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import UIKit
import Turbolinks
import Router

class WebViewController: VisitableViewController {
    
    var currentPath = "" {
        didSet {
            visitableURL = urlWithPath(currentPath)
        }
    }
    
    convenience init(path: String) {
        self.init()
        currentPath = path
    }
}

// MARK: - action
@objc
extension TopicDetailsViewController {
    
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - private

extension WebViewController {
    
    fileprivate func urlWithPath(_ path: String) -> URL {
        let newPath = path.replacingOccurrences(of: "%23", with: "#")
        var urlComponents = URLComponents(string: newPath)!
        
        let rootURLComponents = URLComponents(string: ROOT_URL)!
        urlComponents.scheme = rootURLComponents.scheme
        urlComponents.host = rootURLComponents.host
        urlComponents.port = rootURLComponents.port
        
        return urlComponents.url!
    }
    
}
