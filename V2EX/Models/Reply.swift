//
//  Reply.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/12/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import Foundation
import SwiftyJSON

class Reply {
    let id: Int
    let memberId: Int
    let created: Int
    let topicId: Int
    let content: String
    let contentRendered: String
    let lastModified: Int
    let member: User
    
    init(json: JSON) {
        id = json["id"].intValue
        memberId = json["member_id"].intValue
        created = json["created"].intValue
        topicId = json["topic_id"].intValue
        content = json["content"].stringValue
        contentRendered = json["content_rendered"].stringValue
        lastModified = json["last_modified"].intValue
        member = User(json: json["member"])
    }
}
