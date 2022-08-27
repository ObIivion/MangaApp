//
//  ApiProvider.swift
//  MangaApp
//
//  Created by Павел Виноградов on 25.08.2022.
//

import Foundation

class AuthService: NSObject {
    
    private let clientId = "dd031b32d2f56c990b1425efe6c42ad847e7fe3ab46bf1299f05ecd856bdb7dd"
    private let clientSecret = "54d7307928f63414defd96399fc31ba847961ceaecef3a5fd93144e960c0e151"
    
    private let baseUrl = URL(string: "https://kitsu.io/api/edge")
    
    private let accept = "application/vnd.api+json"
    private let contentType = "application/vnd.api+json"
    
    private let oAuthbaseUrl = URL(string: "https://kitsu.io/api/oauth")
    private let oAuthXwwwFormUrlencoded = "application/x-www-form-urlencoded"
    
    var accessToken: String {
        let userDefaults = UserDefaults.standard
        if let token = userDefaults.string(forKey: "access_token") {
            return token
        } else {
            print("ничего нет в User defaults по ключу access_token, верну пустую строку")
            return ""
        }
    }
    
    private var request: URLRequest? {
        let header = ["Content-Type" : "application/json"]
        var request = URLRequest(url: oAuthbaseUrl!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.allHTTPHeaderFields = header
        request.httpMethod = "post"
        return request
    }
    
    func obtainingAccessToken(email: String, password: String) {
        
        print("упали в получение токена")
        
        let jsonBody: [String : String] = ["grant_type": "password", "username": email, "password": password]
        let header = ["Content-Type" : "application/json"]
        let jsonDataBody = try? JSONSerialization.data(withJSONObject: jsonBody)
        let url = oAuthbaseUrl?.appendingPathComponent("/token")
        
        var requset: URLRequest = URLRequest(url: url!)
        requset.allHTTPHeaderFields = header
        requset.httpBody = jsonDataBody
        requset.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: requset) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            guard let responseJSON = responseJSON as? [String: Any] else {
                print(error?.localizedDescription ?? "No data responseJSON")
                return
            }

            guard let token = responseJSON["access_token"] else {
                print(error?.localizedDescription ?? "No data token")
                return
            }
            let defaults = UserDefaults.standard
            defaults.set(token, forKey: "access_token")
            print(self.accessToken)
        }
        task.resume()
    }
    
    func registerUser(email: String, password: String) {
        
        print("***** Упали в регистрацию ---")
        
        let header = ["Content-Type" : "application/vnd.api+json"]
        let url = baseUrl?.appendingPathComponent("/users")
        
        var request: URLRequest = URLRequest(url: url!)
        request.allHTTPHeaderFields = header
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            if let response = response {
                print(response)

            if let body = String(data: data, encoding: .utf8) {
                print(body)
            }
        }
    }
    task.resume()
    }
}
