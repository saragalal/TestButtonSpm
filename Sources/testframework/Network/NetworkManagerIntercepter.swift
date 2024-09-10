//
//  NetworkManager+RequestInterceptor.swift
//  Almtaar
//
//  Created by Waleed Saad on 01/12/2023.
//  Copyright © 2023 almatar. All rights reserved.
//

import Alamofire
import Foundation

class NetworkManagerIntercepter: RequestInterceptor {
    
    // MARK: - Properties
    
    static var defaultHeaders: HTTPHeaders {
        var headers =  HTTPHeaders()
//        headers.add(.contentType("application/json"))
//        headers.add(.init(name: "Platform", value: "ios"))
////        if let token = UserDefaultsWrapper.getToken() {
////            headers.add(.authorization(bearerToken: token))
//        }
        return headers
    }
    
//    var signOutCallBack: (() -> Void)?
//    var saveToken: ((String) -> Void)?
//    var saveRefreshToken: ((String) -> Void)?
    
    private let maximumRetries = 2

 //   private let refreshTokenManager = RefreshTokenManager()
    
//    private func setUpRefreshTokenManager() {
//        refreshTokenManager.signOutCallBack = signOutCallBack
//        refreshTokenManager.saveToken = saveToken
//        refreshTokenManager.saveRefreshToken = saveRefreshToken
//    }
    // MARK: - APIs
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        var requestHeaders = Self.defaultHeaders
        request.headers.forEach { requestHeaders.add($0) }
        request.headers = requestHeaders
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount <= maximumRetries,
              let statusCode = request.response?.statusCode,
              statusCode.isAuthenticationErrorCode else {
            completion(.doNotRetry)
            return
        }
        
//        refreshTokenManager.refreshToken(requestId: request.id, closure: completion) { success, retainedClosures in
//            if success {
//                retainedClosures.values.forEach { $0(.retry) }
//            } else {
//                retainedClosures.values.forEach { $0(.doNotRetry) }
//            }
//        }
    }
}

extension Int {
    
    var isAuthenticationErrorCode: Bool {
        (401...403).contains(self)
    }
    
    var isSuccessCode: Bool {
        (200..<300).contains(self)
    }
}
