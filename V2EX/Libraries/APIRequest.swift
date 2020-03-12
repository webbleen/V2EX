//
//  APIRequest.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/11/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import Alamofire
import SwiftyJSON

typealias APICallbackResponse = DataResponse<Data>
typealias APICallback = (APICallbackResponse, JSON?) -> Void

class APIRequest {
    
    static fileprivate var _shared = APIRequest()
    
    static var share: APIRequest {
        return _shared
    }

    fileprivate lazy var manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 5
        
        let manager = SessionManager(configuration: configuration)
        manager.adapter = self
        return manager
    }()
    
    var accessToken: String?
    
    fileprivate func _request(_ method: HTTPMethod, path: String, parameters: [String: AnyObject]?, callback: @escaping APICallback) {
        manager.request("\(ROOT_URL)\(path)", method: method, parameters: parameters).responseData { response in
            switch response.result {
            case .success(_):
                let statusCode = response.response!.statusCode
                logger.debug([method, path, statusCode])
                if statusCode == 401 {
                    return //logout
                }
                var result: JSON? = nil
                if let data = response.data {
                    do {
                        try result = JSON(data: data)
                    } catch { }
                }
                callback(response, result)
            case .failure(let error):
                logger.error([method, path, error])
                callback(response, nil)
            }
        }
    }
    
    func get(_ path: String, parameters: [String: AnyObject]?, callback: @escaping APICallback) {
        _request(.get, path: path, parameters: parameters, callback: callback)
    }
    
    func post(_ path: String, parameters: [String: AnyObject]?, callback: @escaping APICallback) {
        _request(.post, path: path, parameters: parameters, callback: callback)
    }
    
    func delete(_ path: String, parameters: [String: AnyObject]?, callback: @escaping APICallback) {
        _request(.delete, path: path, parameters: parameters, callback: callback)
    }
}

extension APIRequest: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        if let accessToken = accessToken, let url = urlRequest.url, url.absoluteString.hasPrefix(ROOT_URL) {
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
}
