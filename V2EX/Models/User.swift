//
//  User.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/11/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    let id: Int
    let username: String
    let website: String?
    let github: String?
    let psn: String?
    let avatarLarge: URL
    let avatarNormal: URL
    let avatarMini: URL
    let bio: String?
    let url: String
    let tagline: String?
    let twitter: String?
    let created: Int
    let location: String?
    let btc: String?
    
    init(json: JSON) {
        id = json["id"].intValue
        username = json["username"].stringValue
        website = json["website"].string
        github = json["github"].string
        psn = json["psn"].string
        avatarLarge = NSURL(string: "https:\(json["avatar_large"].stringValue)")! as URL
        avatarNormal = NSURL(string: "https:\(json["avatar_normal"].stringValue)")! as URL
        avatarMini = NSURL(string: "https:\(json["avatar_mini"].stringValue)")! as URL
        bio = json["bio"].string
        url = json["url"].stringValue
        tagline = json["tagline"].string
        twitter = json["twitter"].string
        created = json["created"].intValue
        location = json["location"].string
        btc = json["btc"].string
    }
}
