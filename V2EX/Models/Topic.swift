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
    let last_reply_by: String
    let last_touched: Int
    let url: String
    let created: Int
    let content: String
    let content_rendered: String
    let last_modified: Int
    let replies: Int
    
    init(json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        node = Node(json: json["node"])
        member = User(json: json["member"])
        last_reply_by = json["last_reply_by"].stringValue
        last_touched = json["last_touched"].intValue
        url = json["url"].stringValue
        created = json["created"].intValue
        content = json["content"].stringValue
        content_rendered = json["content_rendered"].stringValue
        last_modified = json["last_modified"].intValue
        replies = json["replies"].intValue
    }
}
