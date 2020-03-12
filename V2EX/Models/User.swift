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
    let avatarNormal: String
    let bio: String?
    let url: String
    let tagline: String?
    let twitter: String?
    let created: Int
    let avatarLarge: String
    let avatarMini: String
    let location: String?
    let btc: String?
    
    init(json: JSON) {
        id = json["id"].intValue
        username = json["username"].stringValue
        website = json["website"].stringValue
        github = json["github"].stringValue
        psn = json["psn"].stringValue
        avatarNormal = json["avatar_normal"].stringValue
        bio = json["bio"].stringValue
        url = json["url"].stringValue
        tagline = json["tagline"].stringValue
        twitter = json["twitter"].stringValue
        created = json["created"].intValue
        avatarLarge = json["avatar_large"].stringValue
        avatarMini = json["avatar_mini"].stringValue
        location = json["location"].stringValue
        btc = json["btc"].stringValue
    }
}
