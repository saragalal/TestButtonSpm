//
//  File.swift
//  
//
//  Created by Sara Galal on 10/09/2024.
//

import Foundation

public struct NetworkModel {
    var token: String?
    var refreshToken: String?
    var baseUrl: String
    var language: String
    var deviceID: String
    var appVersion: String
    
    public init(token: String? = nil, refreshToken: String? = nil, baseUrl: String, language: String, deviceID: String, appVersion: String) {
        self.token = token
        self.refreshToken = refreshToken
        self.baseUrl = baseUrl
        self.language = language
        self.deviceID = deviceID
        self.appVersion = appVersion
    }
}
