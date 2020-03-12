//
//  Topic.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/11/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Topic {
    let id: Int
    let title: String
    let node: Node
    let member: User
    let lastReplyBy: String
    let lastTouched: Int
    let url: String
    let created: Int
    let content: String
    let contentRendered: String
    let lastModified: Int
    let replies: Int
    
    init(json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        node = Node(json: json["node"])
        member = User(json: json["member"])
        lastReplyBy = json["last_reply_by"].stringValue
        lastTouched = json["last_touched"].intValue
        url = json["url"].stringValue
        created = json["created"].intValue
        content = json["content"].stringValue
        contentRendered = json["content_rendered"].stringValue
        lastModified = json["last_modified"].intValue
        replies = json["replies"].intValue
    }
}
