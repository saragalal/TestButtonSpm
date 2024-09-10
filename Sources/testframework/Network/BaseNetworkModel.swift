//
//  BaseNetworkModel.swift
//  Almtaar
//
//  Created by Moustafa Mohamed on 5/15/18.
//  Copyright © 2018 Moustafa Mohamed. All rights reserved.
//

import Foundation

class CoreNetworkModel<T: Decodable>: Decodable {
    var status: Int?
    private (set) var data: T?
    var isSuccess: Bool?
    var message: String?
    private var errorKey: [NetworkError]?
    private var errorsKey: [NetworkError]?
    
    var isSuccessfullResponse: Bool {
        (status?.isSuccessCode ?? false) ||
        (isSuccess ?? false) ||
        (data != nil && errors?.isEmpty ?? true)
    }
    
    var errors: [NetworkError]? {
        errorsKey ?? errorKey
    }
    
    var errorMessage: String? {
        //TODO: - ErrorMessages.defaultErrorMessage.localized
        data == nil ? (errors?.first?.message ?? (message ?? "ErrorMessages.defaultErrorMessage.localized)")) : nil
    }
    
    init(errors: [NetworkError]) {
        isSuccess = false
        self.errorsKey = errors
    }
    
    enum CodingKeys: String, CodingKey {
        case status, data, message
        case errorKey = "error"
        case errorsKey = "errors"
    }
}
