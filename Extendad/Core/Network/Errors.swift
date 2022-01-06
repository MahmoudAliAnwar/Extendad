//
//  Errors.swift
//  Extendad
//
//  Created by mahmoud ali on 06/01/2022.
//

import Foundation


// Can be thrown when we can't even reach the API
class NetworkRequestError: NSError {
    var error: NSError?
    
    override var localizedDescription: String {
        return error?.localizedDescription ?? "Network request error - no other information"
    }
    
    init(error: NSError?) {
        super.init(domain: "UnExpected Error", code: 1, userInfo: nil)
        self.error = error
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct ErrorResponse: Decodable {
    var errorMessage: String
}

// Can be thrown when we reach the API but the it returns a 4xx or a 5xx
class ApiError: NSError {
    var data: Data?
    var httpUrlResponse: HTTPURLResponse?
    var message: String?
    
    override var localizedDescription: String {
        return self.message ?? ""
    }
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse) {
        super.init(domain: "UnExpected Error", code: 1, userInfo: nil)
        self.httpUrlResponse = httpUrlResponse
        self.data = data
        do {
            message = (try JSONDecoder().decode(ErrorResponse.self, from: data ?? Data())).errorMessage
        } catch {
            message = "UnExpected Error"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Can be thrown by InitializableWithData.init(data: Data?) implementations when parsing the data
class ApiParseError: NSError {
    static let code = 999
    
    var error: NSError?
    var httpUrlResponse: HTTPURLResponse?
    var data: Data?
    
    override var localizedDescription: String {
        return error?.localizedDescription ?? ""
    }
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse, error: NSError?) {
        super.init(domain: "UnExpected Error", code: 1, userInfo: nil)
        self.httpUrlResponse = httpUrlResponse
        self.data = data
        self.error = error
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Can be thrown when anyone validations failed
class ValidationError: NSError {
    var message: String? = ""
    
    init(message: String) {
        super.init(domain: "UnExpected Error", code: 1, userInfo: nil)
        self.message = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var localizedDescription: String {
        return self.message ?? "Validation Error"
    }

}
