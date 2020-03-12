//
//  SiteInfo.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/12/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SiteInfo {
    let title: String
    let slogan: String
    let description: String
    let domain: String
    
    init(json: JSON) {
        title = json["title"].stringValue
        slogan = json["slogan"].stringValue
        description = json["description"].stringValue
        domain = json["domain"].stringValue
    }
}
