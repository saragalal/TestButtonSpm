//
//  NetworkError.swift
//  Almtaar
//
//  Created by Moustafa Mohamed on 5/15/18.
//  Copyright © 2018 Moustafa Mohamed. All rights reserved.
//

import Foundation


protocol RemoteError {
    var code: Int? { get }
    var message: String? { get }
    var field: String? { get }
}

// General Mappable NetworkError
class NetworkError: Codable, RemoteError {
    var code: Int?
    var field: String?
    var message: String?
    var messages: [String]?
    
    init(message: String? = nil) {
        self.message = message
    }
   
    static func getDetault() -> [NetworkError] {
        let error  = NetworkError()
        error.code = 500
        error.message = "ErrorMessages.defaultErrorMessage.localized"
        return [error]
    }

    enum CodingKeys: String, CodingKey {
        case code
        case field
        case message
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decodeIfPresent(Int.self, forKey: .code)
        self.field = try container.decodeIfPresent(String.self, forKey: .field)
        if let errorMsg = try? container.decodeIfPresent(String.self, forKey: .message) {
            message = errorMsg
        } else {
            if let errorMsgs = try? container.decodeIfPresent([String].self, forKey: .message) {
                messages = errorMsgs
            }
        }
    }
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? { self.message }
}
