//
//  MoyaUserDataProvider.swift
//  MangaApp
//
//  Created by Павел Виноградов on 05.09.2022.
//

import Foundation
import Moya

public enum MoyaUserDataService {
    
    private static var accessToken: String {
        let userDefaults = UserDefaults.standard
        if let token = userDefaults.string(forKey: "access_token") {
            return token
        } else {
            print("ничего нет в User defaults по ключу access_token, верну пустую строку")
            return ""
        }
    }
    private static let userId = "1341883"
    
    case registerUser(email: String, password: String, userName: String)
    case authUser(email: String, password: String)
    case updateUserData(id: String, imageData: Data, name: String, slug: String, location: String, waifuOrHusbando: String)
}

extension MoyaUserDataService: TargetType {
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
            return "/users/\(MoyaUserDataService.userId)"
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
        case let .updateUserData(id, imageData, name, slug, location, waifuOrHusbando):
            
            let imageMultipartData = MultipartFormData(provider: .data(imageData), name: "avatar_meme")
            let jsonBody: [String : Any] = [
                "data" : [ "id" : id,
                           "attributes" : ["name" : name, "slug" : slug, "location" : location, "waifuOrHusbando" : waifuOrHusbando],
    //                       "relationships" : ["postPinned" : ["data" : nil]],
                          "type" : "users"]]
            let jsonDataBody = try? JSONSerialization.data(withJSONObject: jsonBody)
            let jsonMultipartData = MultipartFormData(provider: .data(jsonDataBody!), name: "profileData")
            
            return .uploadMultipart([jsonMultipartData, imageMultipartData])
            
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type" : "application/vnd.api+json", "authorization" : "Bearer \(MoyaUserDataService.accessToken)"]
    }
    
}
