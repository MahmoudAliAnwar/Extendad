//
//  RepositoriesUseCase.swift
//  Extendad
//
//  Created by mahmoud ali on 06/01/2022.
//

import Foundation

class RepositoriesUseCase: BaseUseCase {
    
   
   
    override func process<T: Decodable>(_ outputType: (T.Type), completionHandler: @escaping (APIResult<T>) -> Void) {
        ApiClient().execute(request: ApiRequest(urlPrefix: ServiceBase.repositories.rawValue, method: .get), completionHandler: { (result: APIResult<ApiResponse<T>>) in
                  switch result {
                  case let .success(response):
                      completionHandler(.success(response.entity))
                  case let .failure(error):
                      completionHandler(.failure(error))
                  }
              })
              
          }
}
