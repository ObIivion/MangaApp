//
//  ApiProvider.swift
//  MangaApp
//
//  Created by Павел Виноградов on 25.08.2022.
//

import UIKit

class UserDataProvider: NSObject {
    
    private let clientId = "dd031b32d2f56c990b1425efe6c42ad847e7fe3ab46bf1299f05ecd856bdb7dd"
    private let clientSecret = "54d7307928f63414defd96399fc31ba847961ceaecef3a5fd93144e960c0e151"
    
    private let baseUrl = URL(string: "https://kitsu.io/api/edge")
    
    private let accept = "application/vnd.api+json"
    private let contentType = "application/vnd.api+json"
    
    private let oAuthbaseUrl = URL(string: "https://kitsu.io/api/oauth")
    private let oAuthXwwwFormUrlencoded = "application/x-www-form-urlencoded"
    
    private var accessToken: String {
        let userDefaults = UserDefaults.standard
        if let token = userDefaults.string(forKey: "access_token") {
            return token
        } else {
            print("ничего нет в User defaults по ключу access_token, верну пустую строку")
            return ""
        }
    }
    private var userId = "1341883"
    
    func obtainingAccessToken(email: String, password: String) {
        
        print("упали в получение токена")
        
        let jsonBody: [String : String] = ["grant_type": "password", "username": email, "password": password]
        let header = ["Content-Type" : contentType]
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
    
    func registerUser(email: String, password: String, username: String) {
        
        print("упали в регистрацию")
        
        let jsonBody: [String : Any] = ["data" : ["attributes" : ["email" : email, "name" : username, "password" : password], "type" : "users"]]
        let jsonDataBody = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        let header = ["Content-Type" : contentType]
        
        let url = baseUrl?.appendingPathComponent("/users")
        
        var request: URLRequest = URLRequest(url: url!)
        request.allHTTPHeaderFields = header
        request.httpBody = jsonDataBody
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
    
    func uploadImage(paramName: String, fileName: String, image: UIImage) {
        let url = baseUrl?.appendingPathComponent("/users/\(userId)")

        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString

        let session = URLSession.shared

        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "PATCH"

        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        data.append(image.jpegData(compressionQuality: 1)!)

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
                }
            }
        }).resume()
    }
    
    func updateProfile(base64ImageString: String, name: String, slug: String, location: String, waifuOrHusbando: String) {
        
        print("упали в updateProfile")
        
        let jsonBody: [String : Any] = [
            "data" : [ "id" : userId,
                       "attributes" : ["avatar" : base64ImageString, "name" : name, "slug" : slug, "location" : location, "waifuOrHusbando" : waifuOrHusbando],
//                       "relationships" : ["postPinned" : ["data" : nil]],
                      "type" : "users"]]
        let jsonDataBody = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        let header = ["Content-Type" : contentType, "authorization" : "Bearer \(accessToken)"]
        
        let url = baseUrl?.appendingPathComponent("/users/\(userId)")
        
        var request: URLRequest = URLRequest(url: url!)
        request.allHTTPHeaderFields = header
        request.httpBody = jsonDataBody
        request.httpMethod = "PATCH"
        
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
