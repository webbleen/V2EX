//
//  APIService.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/12/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import Foundation

/// 网络接口
class APIService {
    
    /// list接口排序类型
    ///
    /// - hot: 最热主题
    /// - latest: 最新主题
    enum TopicType: String {
        case hot
        case latest
    }
    
    static func getTopicList(_ type: TopicType, nodeId: Int = 0, offset: Int = 0, limit: Int = 20, callback: @escaping (APICallbackResponse, [Topic]?) -> ()) {
        if nodeId == 0 {
            switch type {
            case .latest:
                getLastestTopic(callback: callback)
            case .hot:
                getHotTopic(callback: callback)
            }
        } else {
            var parameters = [String: AnyObject]()
            parameters["node_id"] = nodeId as AnyObject?
            APIRequest.share.get(API_TOPIC_DETAILS, parameters: parameters) { (response, result) in
                guard let _ = result, let topicList = result!.array, topicList.count > 0 else {
                    callback(response, nil)
                    return
                }
                
                let topics = topicList.map { Topic(json: $0) }
                callback(response, topics)
            }
        }
    }
    
    /// 最新主题
    /// - Parameter callback: 完成时回调
    static func getLastestTopic(callback: @escaping (APICallbackResponse, [Topic]?) -> ()) {
        APIRequest.share.get(API_TOPICS_LATEST, parameters: nil) { (response, result) in
            guard let _ = result, let topicList = result!.array, topicList.count > 0 else {
                callback(response, nil)
                return
            }
            
            let topics = topicList.map { Topic(json: $0) }
            callback(response, topics)
        }
    }
    
    /// 最热主题
    /// - Parameter callback: 完成时回调
    static func getHotTopic(callback: @escaping (APICallbackResponse, [Topic]?) -> ()) {
        APIRequest.share.get(API_TOPICS_HOT, parameters: nil) { (response, result) in
            guard let _ = result, let topicList = result!.array, topicList.count > 0 else {
                callback(response, nil)
                return
            }
            
            let topics = topicList.map { Topic(json: $0) }
            callback(response, topics)
        }
    }
    
    /// 主题详细信息
    /// - Parameter id: 主题id
    /// - Parameter callback: 完成时回调
    static func getTopicDetails(id: Int, callback: @escaping (APICallbackResponse, [Topic]?) -> ()) {
        var parameters = [String: AnyObject]()
        parameters["id"] = id as AnyObject?
        APIRequest.share.get(API_TOPIC_DETAILS, parameters: parameters) { (response, result) in
            guard let _ = result, let topicList = result!.array, topicList.count > 0 else {
                callback(response, nil)
                return
            }
            
            let topics = topicList.map { Topic(json: $0) }
            callback(response, topics)
        }
    }
    
    /// 主题回复
    /// - Parameter topicId: 主题id
    /// - Parameter callback: 完成时回调
    static func getReplies(topicId: Int, callback: @escaping (APICallbackResponse, [Reply]?) -> ()) {
        var parameters = [String: AnyObject]()
        parameters["topic_id"] = topicId as AnyObject?
        APIRequest.share.get(API_TOPIC_REPLY, parameters: parameters) { (response, result) in
            guard let _ = result, let replyList = result!.array, replyList.count > 0 else {
                callback(response, nil)
                return
            }
            
            let replies = replyList.map { Reply(json: $0) }
            callback(response, replies)
        }
    }
    
    /// 网站信息
    /// - Parameter callback: 完成时回调
    static func getSiteInfo(callback: @escaping (APICallbackResponse, SiteInfo?) -> ()) {
        APIRequest.share.get(API_TOPIC_REPLY, parameters: nil) { (response, result) in
            guard let siteinfo = result else {
                callback(response, nil)
                return
            }
            
            callback(response, SiteInfo(json: siteinfo))
        }
    }
    
    /// 节点信息
    /// - Parameter nodeName: 节点名称
    /// - Parameter callback: 完成时回调
    static func getNodeInfo(nodeName: String, callback: @escaping (APICallbackResponse, Node?) -> ()) {
        var parameters = [String: AnyObject]()
        parameters["name"] = nodeName as AnyObject?
        APIRequest.share.get(API_NODE, parameters: parameters) { (response, result) in
            guard let node = result else {
                callback(response, nil)
                return
            }
            
            callback(response, Node(json: node))
        }
    }
    
    /// 所有节点
    /// - Parameter callback: 完成时回调
    static func getAllNodes(callback: @escaping (APICallbackResponse, [Node]?) -> ()) {
        APIRequest.share.get(API_ALL_NODES, parameters: nil) { (response, result) in
            guard let _ = result, let nodeList = result!.array, nodeList.count > 0 else {
                callback(response, nil)
                return
            }
            
            let nodes = nodeList.map { Node(json: $0) }
            callback(response, nodes)
        }
    }
    
    /// 会员信息
    /// - Parameter userName: 会员名称
    /// - Parameter callback: 完成时回调
    static func getUserInfo(userName: String, callback: @escaping (APICallbackResponse, User?) -> ()) {
        var parameters = [String: AnyObject]()
        parameters["username"] = userName as AnyObject?
        APIRequest.share.get(API_MEMBER, parameters: parameters) { (response, result) in
            guard let member = result else {
                callback(response, nil)
                return
            }
            
            callback(response, User(json: member))
        }
    }
}
