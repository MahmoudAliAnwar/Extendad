//
//  APIResponse.swift
//  Extendad
//
//  Created by mahmoud ali on 06/01/2022.
//

import Foundation


struct ApiResponse<T: Decodable> {
    
    let entity: T
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse) throws{
        
        do{
            self.entity = try JSONDecoder().decode(T.self, from: data ?? Data())
            
        self.data = data
        self.httpUrlResponse = httpUrlResponse
        }catch{
            throw ApiParseError(data: data, httpUrlResponse: httpUrlResponse, error: error as NSError)
        }
    }
    
}
