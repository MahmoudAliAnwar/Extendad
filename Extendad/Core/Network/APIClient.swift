//
//  APIClient.swift
//  Extendad
//
//  Created by mahmoud ali on 06/01/2022.
//

import Foundation

protocol ApiClientProtocol{
    func execute<T>(request: ApiRequest, completionHandler: @escaping (_ result: APIResult<ApiResponse<T>>) -> Void)
    
}
final class ApiClient: ApiClientProtocol {
    
    func execute<T>(request: ApiRequest, completionHandler: @escaping (APIResult<ApiResponse<T>>) -> Void) {
        var urlRequest = URLRequest(url: URL(string: ServiceBase.base.rawValue + request.urlPrefix)!)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body?.toJsonData()
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
      
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                guard let httpUrlResponse = response as? HTTPURLResponse else {
                    completionHandler(.failure(NetworkRequestError(error: error! as NSError)))
                    return
                }
                
                let successRange = 200...299
                if successRange.contains(httpUrlResponse.statusCode) {
                    do {
                        let response = try ApiResponse<T>(data: data, httpUrlResponse: httpUrlResponse)
                        completionHandler(.success(response))
                    } catch { // Parsing Error
                        completionHandler(.failure(error))
                    }
                } else if httpUrlResponse.statusCode == 401 { // Not Auth
                    

                } else { // Network Error
                    completionHandler(.failure(ApiError(data: data, httpUrlResponse: httpUrlResponse)))
                }
            }
        }
        dataTask.resume()
    }
}
