//
//  RefreshTokenService.swift
//  Almtaar
//
//  Created by Abanoub Ghaly on 06/12/2022.
//  Copyright © 2022 almatar. All rights reserved.
//

import Foundation

//protocol RefreshTokenServiceProtocol: BaseServiceProtocol {
//    
//    func executeRequest(token: String?, deviceId: String?, completion: @escaping (CoreNetworkModel<LoginSignupModel>) -> Void)
//}
//
//class RefreshTokenService: RefreshTokenServiceProtocol {
//    
//    static private var refreshTokenURL = "/api/v1/user-profile/token/refresh"
//    
//    func executeRequest(token: String?, deviceId: String?,completion: @escaping (CoreNetworkModel<LoginSignupModel>) -> Void) {
//        guard let refreshToken = token,
//              !refreshToken.isEmpty else {
//            completion(CoreNetworkModel(errors: NetworkError.getDetault()))
//            return
//        }
//        
//        let headers: [String: String] = {
//            var defaultHeaders = NetworkManagerIntercepter.defaultHeaders.dictionary
//            if let deviceId = deviceId {
//                defaultHeaders["Device-Id"] = deviceId
//            }
//            return defaultHeaders
//        }()
//        
//        let parameters = ["refresh_token": refreshToken]
//        
//        let refreshTokenRequest = SimpleNetworkRequest(url: RefreshTokenService.refreshTokenURL, method: .post, parameters: parameters, parameterEncoding: .urlEncoding, headers: headers)
//        
//
//        NetworkManager.shared().executeCoreModelDecodedRequest(refreshTokenRequest, useInterceptor: false) { (response: CoreNetworkModel<LoginSignupModel>) in
//            if response.isSuccessfullResponse {
//                // TODO: - send Event
////                TrackRefreshToken.shared.sendEvent(event: .refreshTokenSuccess, urlRequestedToken: refreshTokenRequest.url)
//            } else {
////                TrackRefreshToken.shared.sendEvent(event: .refreshTokenFailed, urlRequestedToken: refreshTokenRequest.url)
//            }
//            completion(response)
//        }
//    }
//}
