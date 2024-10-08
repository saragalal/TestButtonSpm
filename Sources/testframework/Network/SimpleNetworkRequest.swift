//
//  SimpleNetworkRequest.swift
//  Almtaar
//
//  Created by khalifa on 7/9/20.
//  Copyright © 2020 almatar. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

public struct SimpleNetworkRequest: IndependentNetworkRequestProtocol {
  public let url: String
  public let method: HttpMethod
  public let parameters: [String: Any]
  public let parameterEncoding: ParametersEncoding
  public let headers: [String: String]
  public let images: [UIImage]?
    // TODO: - check using uiimage in network layer with samar
    public init(url: String, method: HttpMethod = .get,
         parameters: [String: Any] = [:], parameterEncoding: ParametersEncoding = .urlEncoding,
         headers: [String: String] = [:], images: [UIImage]? = nil) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.parameterEncoding = parameterEncoding
        self.headers = headers
        self.images = images
    }
}

public protocol IndependentNetworkRequestProtocol: BaseNetworkRequest {
    var url: String { get }
    var method: HttpMethod { get }
    var parameterEncoding: ParametersEncoding { get }
    var parameters: [String: Any] { get }
    var headers: [String: String] { get }
    var images: [UIImage]? { get }
}

public extension IndependentNetworkRequestProtocol {
    var parameterEncoding: ParametersEncoding {
        return .urlEncoding
    }
    
    var parameters: [String: Any] {
        return [:]
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var method: HttpMethod {
        return .get
    }
}

public extension IndependentNetworkRequestProtocol {
    func getHTTPMethod() -> HTTPMethod {
        return method.alamofireMethod
    }
    
    func getParameters() -> Parameters? {
        return parameters
    }
    
    func getParameterEncoding() -> ParameterEncoding {
        return parameterEncoding.alamoFireParameterEncoding
    }
    
    func getURL() -> String {
        return url
    }
    
    func getHeaders() -> [String: String] {
        return headers
    }
    
    func getImages() -> [UIImage]? {
        return images
    }
}

public enum HttpMethod {
    case options
    case get
    case head
    case post
    case put
    case patch
    case delete
    case trace
    case connect
    
    var alamofireMethod: HTTPMethod {
        switch self {
        case .options: return .options
        case .get: return .get
        case .head: return .head
        case .post: return .post
        case .put: return .put
        case .patch: return .patch
        case .delete: return .delete
        case .trace: return .trace
        case .connect: return .connect
        }
    }
    
}

public enum ParametersEncoding {
    case jsonDefault
    case urlEncoding
    case urlEncodingToQueryString
    
    var alamoFireParameterEncoding: ParameterEncoding {
        switch self {
        case .jsonDefault: return JSONEncoding.default
        case .urlEncoding: return URLEncoding(destination: .methodDependent)
        case .urlEncodingToQueryString: return URLEncoding(destination: .queryString)
        }
    }
}
