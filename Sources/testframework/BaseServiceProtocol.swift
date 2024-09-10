//
//  BaseServiceProtocol.swift
//  Almtaar
//
//  Created by khalifa on 7/9/20.
//  Copyright © 2020 almatar. All rights reserved.
//

import Foundation


protocol BaseServiceProtocol {
    func executeRequest<C: Codable>(_ request: IndependentNetworkRequestProtocol, completion: @escaping (CoreNetworkModel<C>) -> Void)
    func executeRequest<C: Codable>(_ request: IndependentNetworkRequestProtocol, completion: @escaping (C?, String?) -> Void)
}

extension BaseServiceProtocol {
    
    static var deviceIdKey: String {
        return "Device-Id"
    }
    
//    func makeRequest<T: Mappable>(request: IndependentNetworkRequestProtocol, completion: @escaping (BaseNetworkModel<T>) -> Void) {
//        NetworkManager.shared().makeRequest(request, handler: completion)
//    }
//    
    func executeRequest<C: Codable>(_ request: IndependentNetworkRequestProtocol, completion: @escaping (C?, String?) -> Void) {
        NetworkManager.shared().makeRequest(request, handler: completion)
    }

    func executeRequest<C: Codable>(_ request: IndependentNetworkRequestProtocol, completion: @escaping (CoreNetworkModel<C>) -> Void) {
        NetworkManager.shared().makeRequest(request, handler: completion)
    }
    
//    func makeRequest<T: Mappable>(request: IndependentNetworkRequestProtocol, completion: @escaping (T?, String?) -> Void) {
//        makeRequest(request: request) { (response: BaseNetworkModel<T>)  in
//            let errorMessage = response.data == nil ? response.errors?.first?.message ?? ErrorMessages.defaultErrorMessage.localized : nil
//            completion(response.data, errorMessage)
//        }
//    }
//    
//    func makeRequest<T: Mappable>(request: IndependentNetworkRequestProtocol, completion: @escaping ([T]?, String?) -> Void) {
//        makeRequest(request: request) { (response: BaseNetworkModel<T>)  in
//            let errorMessage = response.dataAsArray == nil ? response.errors?.first?.message ?? ErrorMessages.defaultErrorMessage.localized : nil
//            completion(response.dataAsArray, errorMessage)
//        }
//    }
}
