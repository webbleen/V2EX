//
//  Constants.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/11/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import UIKit

let ROOT_URL = "https://www.v2ex.com/"
let API_PATH = "api/"

/// 取网站信息
/// @GET
/// {
///   "title" : "V2EX",
///   "slogan" : "way to explore",
///   "description" : "创意工作者们的社区",
///   "domain" : "www.v2ex.com"
/// }
let API_SITE_INFO = API_PATH + "site/info.json"

/// 取网站状态
/// @GET
/// {
///   "topic_max" : 126172,
///   "member_max" : 71033
/// }
let API_SITE_STATUS = API_PATH + "site/stats.json"

/// 取最新主题
/// @GET
let API_TOPICS_LATEST = API_PATH + "topics/latest.json"

/// 取热议主题
/// @GET
let API_TOPICS_HOT = API_PATH + "topics/hot.json"

/// 主题详细信息
/// @GET
/// @param [id 话题id]/[node_id 节点id]/[node_name 节点名称]/[username 用户名]
let API_TOPIC_DETAILS = API_PATH + "topics/show.json"

/// 取主题回复
/// @GET
/// @param topic_id
/// @param page
/// @param page_size
let API_TOPIC_REPLY = API_PATH + "replies/show.json"

/// 取用户信息
/// @GET
/// @param username/id
let API_MEMBER = API_PATH + "members/show.json"

/// 取节点信息
/// @GET
/// @param name/id
let API_NODE = API_PATH + "nodes/show.json"

/// 取所有节点列表
/// @GET
/// @param name
let API_ALL_NODES = API_PATH + "nodes/all.json"

// 获取今日诗词token
// {
//   "status": "success",
//   "data": "VakPhQ3cah7irqRRQiWISvs4irBvhurL"
// }
let API_JINRISHICI_TOKEN = "https://v2.jinrishici.com/token"

// 您需要在 HTTP 的 Headers 头中指定 Token
// X-User-Token： VakPhQ3cah7irqRRQiWISvs4irBvhurL
let API_JINRISHICI_ONE = "https://v2.jinrishici.com/one.json"


let COPYRIGHT_URL = "https://github.com/webbleen/V2EX/blob/master/README.md"
let APP_VERSION = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String


// Red Theme
let BLACK_COLOR = UIColor(red: 0.04, green: 0.02, blue: 0.02, alpha: 1.0)
let PRIMARY_COLOR = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
let SIDEMENU_NAVBAR_BG_COLOR = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
let SIDEMENU_BG_COLOR = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)

let NAVBAR_BG_COLOR = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
let NAVBAR_BORDER_COLOR = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
let NAVBAR_TINT_COLOR = UIColor(red: 1.00, green: 1.00, blue: 0.98, alpha: 1.0)
let TABBAR_BG_COLOR = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
