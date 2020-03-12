//
//  Node.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/11/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Node {
    let id: Int
    let name: String
    let avatarLarge: URL
    let avatarNormal: URL
    let avatarMini: URL
    let title: String
    let url: String
    let topics: Int
    let footer: String
    let header: String
    let titleAlternative: String
    let stars: Int
    //let aliases: [AnyObject]
    let root: Bool
    let parentNodeName: String
    
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        avatarLarge = NSURL(string: "https:\(json["avatar_large"].stringValue)")! as URL
        avatarNormal = NSURL(string: "https:\(json["avatar_normal"].stringValue)")! as URL
        avatarMini = NSURL(string: "https:\(json["avatar_mini"].stringValue)")! as URL
        title = json["title"].stringValue
        url = json["url"].stringValue
        topics = json["topics"].intValue
        footer = json["footer"].stringValue
        header = json["header"].stringValue
        titleAlternative = json["title_alternative"].stringValue
        stars = json["stars"].intValue
        //aliases = json["aliases"] as! [AnyObject]
        root = json["root"].boolValue
        parentNodeName = json["parent_node_name"].stringValue
    }
}
