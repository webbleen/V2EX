//
//  Error.swift
//  V2EX
//
//  Created by WENBIN.LI on 3/11/20.
//  Copyright © 2020 webbleen. All rights reserved.
//

import Foundation

struct V2Error: Error {
    static let HttpNotFoundError = V2Error(title: "内容不存在", message: "抱歉，遇到错误，无法打开这个内容。")
    static let NetworkError = V2Error(title: "暂时无法连接", message: "暂时无法连接到服务器，请检查你的网络状况是否正常，或 V2EX 网站是不是暂时出问题了，然后重试。")
    static let UnknownError = V2Error(title: "Unknown Error", message: "An unknown error occurred.")
    
    
    let title: String
    let message: String
    
    init(title: String, message: String) {
        self.title = title
        self.message = message
    }
    
    init(HTTPStatusCode: Int) {
        self.title = "Server Error"
        self.message = "The server returned an HTTP \(HTTPStatusCode) response."
    }
}
