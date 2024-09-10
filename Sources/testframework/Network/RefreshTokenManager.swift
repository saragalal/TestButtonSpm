//
//  RefreshTokenManager.swift
//  Almtaar
//
//  Created by Waleed Saad on 23/10/2023.
//  Copyright © 2023 almatar. All rights reserved.
//

import Foundation
import Alamofire

//class RefreshTokenManager {
//    
//    typealias RequestID = UUID
//    
//    typealias RequestRetriableClosure = (RetryResult) -> Void
//    
//    typealias RequestRetriableClosures = [RequestID: RequestRetriableClosure]
//
//    var signOutCallBack: (() -> Void)?
//    var saveToken: ((String) -> Void)?
//    var saveRefreshToken: ((String) -> Void)?
//    
//    private var retainedClosures: RequestRetriableClosures = [:]
//    
//    private let threadsafeQueue = DispatchQueue(label: "com.almtar.almtar-refresh-token-manager")
//
//    private var refreshToken: String?
//    private var deviceId: String?
//    
//    func refreshToken(
//        requestId: RequestID,
//        closure: @escaping RequestRetriableClosure,
//        completion: @escaping (Bool, RequestRetriableClosures) -> Void
//    ) {
//        if shouldExecuteRefreshToken() {
//            retainClosure(closure, for: requestId)
//            executeRefreshTokenRequest { [weak self] result in
//                completion(result, self?.getRetainedClosures() ?? [:])
//                self?.deleteAllRetainedClosures()
//            }
//        } else {
//            retainClosure(closure, for: requestId)
//        }
//    }
//    func setRefreshData(token: String?, deviceId: String?) {
//        self.refreshToken = token
//        self.deviceId = deviceId
//    }
//    private func shouldExecuteRefreshToken() -> Bool {
//        threadsafeQueue.sync {
//            return retainedClosures.isEmpty
//        }
//    }
//    
//    private func retainClosure(_ closure: @escaping RequestRetriableClosure, for requestId: RequestID) {
//        threadsafeQueue.sync {
//            retainedClosures[requestId] = closure
//        }
//    }
//    
//    private func getRetainedClosures() -> RequestRetriableClosures? {
//        threadsafeQueue.sync {
//            return retainedClosures
//        }
//    }
//    
//    private func deleteAllRetainedClosures() {
//        threadsafeQueue.sync {
//            retainedClosures.removeAll()
//        }
//    }
//    
//    private func executeRefreshTokenRequest(completion: @escaping (Bool) -> Void) {
//        RefreshTokenService().executeRequest(token: refreshToken, deviceId: deviceId) { [weak self] response in
//            if let accessToken = response.data {
//                self?.onSuccess(accessToken)
//                completion(true)
//            } else {
//                completion(false)
//                self?.signout()
//            }
//        }
//    }
//    
//    private func signout() {
//        signOutCallBack?()
//        //UserDefaultsWrapper.signOut(shouldRefreshApp: false)
//    }
//    
//    private func onSuccess(_ model: LoginSignupModel?) {
//        guard let token = model?.token, let refreshToken = model?.refreshToken, !token.isEmpty, !refreshToken.isEmpty else {
//            signout()
//            return
//        }
////        UserDefaultsWrapper.saveToken(token)
////        UserDefaultsWrapper.saveRefreshToken(refreshToken)
//        saveToken?(token)
//        saveRefreshToken?(refreshToken)
//    }
//}
