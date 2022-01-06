//
//  APIResult.swift
//  Extendad
//
//  Created by mahmoud ali on 06/01/2022.
//

import Foundation
enum APIResult<T> {
    case success(T)
    case failure(Error)
    
    public func dematerialize() throws -> T{
        switch self {
        case let .success(value):
            return value
        case let .failure(erorr):
            throw erorr
        }
    }
}
