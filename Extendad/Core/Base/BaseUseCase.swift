//
//  BaseUseCase.swift
//  Extendad
//
//  Created by mahmoud ali on 06/01/2022.
//

import Foundation


class BaseUseCase {
    var body: [String: Any]?
    
    func extract() {}
    func validate() throws {}
    func process<T: Decodable>(_ outputType: T.Type, completionHandler: @escaping (APIResult<T>) -> Void) {
        completionHandler(APIResult<T>.failure(NSError()))
    }
    
    final func execute<T: Decodable>(_ outputType: T.Type, completionHandler: @escaping (APIResult<T>) -> Void) {
        do {
            extract()
            try validate()
            process(outputType, completionHandler: completionHandler)
        } catch let error {
            completionHandler(APIResult<T>.failure(error))
        }
    }
    
}
