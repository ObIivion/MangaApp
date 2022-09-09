//
//  MoyaUserDataProvider.swift
//  MangaApp
//
//  Created by Павел Виноградов on 08.09.2022.
//

import Foundation
import Moya
import SwiftyJSON

//checking using Moya

class MoyaUserDataProvider: NSObject {
    
    private let clientId = "dd031b32d2f56c990b1425efe6c42ad847e7fe3ab46bf1299f05ecd856bdb7dd"
    private let clientSecret = "54d7307928f63414defd96399fc31ba847961ceaecef3a5fd93144e960c0e151"
    
    static var accessToken: String {
        let userDefaults = UserDefaults.standard
        if let token = userDefaults.string(forKey: "access_token") {
            return token
        } else {
            print("ничего нет в User defaults по ключу access_token, верну пустую строку")
            return ""
        }
    }
    static var userId = "1341883"
    
    let moyaProvider = MoyaProvider<MoyaUserTarget>()
    
    func moyaGetAccessToken(email: String, password: String) {
        
        print("упали в получение токена")
        
        moyaProvider.request(.authUser(email: email, password: password)) { [weak self] result in
            
            switch result {
            
            case let .success(response):
                do {
                    print("----- SUCCESS REQUEST -----")
                    let responseJSON = try? JSONSerialization.jsonObject(with: response.data, options: [])
                    guard let respJSON = responseJSON as? [String: Any] else {
                        print("No data responseJSON")
                        return
                    }
                    
                    if let token = respJSON["access_token"] {
                        let defaults = UserDefaults.standard
                        defaults.set(token, forKey: "access_token")
                        print(MoyaUserDataProvider.accessToken)
                    }
                } catch {
                    print("ERROR CATCHED")
                    print(error.localizedDescription)
                }
                
            case let .failure(error):
                print("Case let error")
                print(error.localizedDescription)
            }
        }
    }
    
    func moyaRegisterUser(email: String, password: String, username: String) {
        
        print("упали в moyaRegisterUser")
        
        moyaProvider.request(.registerUser(email: email, password: password, userName: username)) { result in
            switch result {
            case let .success(response):
                do {
                    print("----- SUCCESS REQUEST -----")
                    let responseJSON = try? JSONSerialization.jsonObject(with: response.data, options: [])
                    guard let respJSON = responseJSON as? [String: Any] else {
                        print("No data responseJSON")
                        return
                    }
                    print("REGISTER JSON")
                    if let userId = respJSON["id"] {
                        let defaults = UserDefaults.standard
                        defaults.set(userId, forKey: "userId")
                        print("MoyaUserDataProvider.userId")
                        print(MoyaUserDataProvider.userId)
                    }
                    print(respJSON)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            case let .failure(error):
                print("Case let error")
                print(error.localizedDescription)
            }
        }
    }
    
    func moyaUpdateProfile(image: UIImage, name: String, slug: String, location: String, waifuOrHusbando: String) {
        
        print("упали в moya update profile")
        
        if let dataImage = image.jpegData(compressionQuality: 0.7) {
            
            let base64ImageString = dataImage.base64EncodedString()
            let imageStringForRequset = "data:image/jpeg;base64," + base64ImageString
            moyaProvider.request(.updateUserData(base64ImageString: imageStringForRequset, name: name, slug: slug, location: location, waifuOrHusbando: waifuOrHusbando)) { result in
                switch result {
                case let .success(response):
                    do {
                        print("----- SUCCESS REQUEST -----")
                        let responseJSON = try? JSONSerialization.jsonObject(with: response.data, options: [])
                        guard let respJSON = responseJSON as? [String: Any] else {
                            print("No data responseJSON")
                            return
                        }
                        print(respJSON)
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                case let .failure(error):
                    print("Case let error")
                    print(error.localizedDescription)
                }
            }
        }
    }
}
