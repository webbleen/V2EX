//
//  SiteStatus.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/12/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SiteStatus {
    let topicMax: Int
    let memberMax: Int
    
    init(json: JSON) {
        topicMax = json["topic_max"].intValue
        memberMax = json["member_max"].intValue
    }
}
