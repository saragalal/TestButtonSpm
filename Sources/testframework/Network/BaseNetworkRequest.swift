//
//  BaseNetworkRequest.swift
//  Almtaar
//
//  Created by Moustafa Mohamed on 5/13/18.
//  Copyright © 2018 Moustafa Mohamed. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
/// protocol of the base network request used in the network layer
protocol BaseNetworkRequest {
    
    /// - Returns: Should return the method used in the request ( post, get, ... )
    func getHTTPMethod() -> Alamofire.HTTPMethod
    
    /// - Returns: return the paramters which is a dictionary contains the data sent
    ///            this could be query string or body in case of Post method for example
    func getParameters() -> Parameters?
    func getImages() -> [UIImage]? 
    /// - Returns: the type of encoding used in the request
    ///            for exmaple JSONEncoding.default in case of Post request or URLEncoding in case of query string
    func getParameterEncoding() -> ParameterEncoding
    
    /// - Returns: the relative url route for the request
    func getURL() -> String
    func getHeaders() -> [String: String]
}
extension BaseNetworkRequest {
    func getParameters() -> Parameters? {
        return nil
    }

    func getImages() -> [UIImage]? {
         return nil
     }
    
    func getHeaders() -> [String: String] {
        return [:]
    }
}
