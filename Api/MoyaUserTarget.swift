//
//  MoyaUserDataProvider.swift
//  MangaApp
//
//  Created by Павел Виноградов on 05.09.2022.
//

import Foundation
import Moya

public enum MoyaUserTarget {
    
    case registerUser(email: String, password: String, userName: String)
    case authUser(email: String, password: String)
    case updateUserData(base64ImageString: String?, name: String, slug: String, location: String, waifuOrHusbando: String)
}

extension MoyaUserTarget: TargetType {
    public var baseURL: URL {
        switch self {
        case .registerUser, .updateUserData:
            return URL(string: "https://kitsu.io/api/edge")!
        case .authUser:
            return URL(string: "https://kitsu.io/api/oauth")!
        }
    }
    
    public var path: String {
        switch self {
        case .authUser:
            return "/token"
        case .registerUser:
            return "/users"
        case .updateUserData:
            return "/users/\(UserDataProvider.userId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .registerUser, .authUser:
            return .post
        case .updateUserData:
            return .patch
        }
    }
    
    public var task: Task {
        switch self {
        case let .registerUser(email, password, userName):
            return .requestParameters(parameters: ["data" : ["attributes" : ["email" : email, "name" : userName, "password" : password], "type" : "users"]], encoding: JSONEncoding.default)
        case let .authUser(email, password):
            return .requestParameters(parameters: ["grant_type": "password", "username": email, "password": password], encoding: JSONEncoding.default)
        case let .updateUserData(base64ImageString, name, slug, location, waifuOrHusbando):
            return .requestParameters(parameters: [
                "data" : [ "id" : UserDataProvider.userId,
                           "attributes" : ["avatar" : base64ImageString, "name" : name, "slug" : slug, "location" : location, "waifuOrHusbando" : waifuOrHusbando],
                           "type" : "users"]], encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case let .registerUser(email, password, userName):
            return ["Content-Type" : "application/vnd.api+json"]
        case let .authUser(email, password):
            return ["Content-Type" : "application/vnd.api+json"]
        case let .updateUserData(base64ImageString, name, slug, location, waifuOrHusbando):
            return ["Content-Type" : "application/vnd.api+json", "authorization" : "Bearer \(UserDataProvider.accessToken)"]
        }
        
    }
    
}
