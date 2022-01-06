//
//  APIRequest.swift
//  Extendad
//
//  Created by mahmoud ali on 06/01/2022.
//

import Foundation


enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

struct ApiRequest {
    var urlPrefix: String
    var method: HTTPMethod
    var body: [String: Any]?
}
