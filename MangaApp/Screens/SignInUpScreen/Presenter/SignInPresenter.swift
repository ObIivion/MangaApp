//
//  SignInPresenter.swift
//  MangaApp
//
//  Created by Павел Виноградов on 11.08.2022.
//

import GoogleSignIn

protocol SignInUpPresenterProtocol {
    
    func signInWithGoogle()
    func signUpWithGoogle()
    
    func signIn(email: String, password: String)
    func signUp(email: String, password: String, username: String)
    
    func checkFieldsBeforeSignIn(email: String, password: String) -> Bool
    func checkFieldsBeforeSignUp(username: String, email: String, password: String) -> Bool
}

import Foundation

class SignInPresenter: SignInUpPresenterProtocol {
    
    weak var view: SignInViewProtocol?
    var router: SignInRouter!
    
    let userDataProvider = UserDataProvider()
    let moyaUserDataProvider = MoyaUserDataProvider()
    
    func continueButtonFailure() {
        view?.addAlert(title: "Не удалось авторизоваться, повторите попытку позже")
    }
    
    func signInWithGoogle() {
        
        let signInConfig = GIDConfiguration(clientID: "164669230338-m3mupoemq5nv813u40v2m1l66d2g613s.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: view as! UIViewController)
    }
    
    func signUpWithGoogle() {
        
        
    }
    
    func signIn(email: String, password: String) {
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.string(forKey: "access_token") != nil {
            router.openUserPreferencesScreen()
        } else {
            print("Moya === get access token ===")
            moyaUserDataProvider.moyaGetAccessToken(email: email, password: password)
        }
    }
    
    func signUp(email: String, password: String, username: String) {
        
        print("sign up in presenter")
        moyaUserDataProvider.moyaRegisterUser(email: email, password: password, username: username)
        //userDataProvider.registerUser(email: email, password: password, username: username)
    }
    
    func checkFieldsBeforeSignIn(email: String, password: String) -> Bool {
        
        if !email.contains("@") || !email.contains(".") {
            view?.addAlert(title: "Email должен содержать @ и .")
            return false
        } else if password.count < 9 {
            view?.addAlert(title: "Пароль слишком короткий")
            return false
        } else { return true }
    }
    
    func checkFieldsBeforeSignUp(username: String, email: String, password: String) -> Bool {
        
        if !email.contains("@") || !email.contains(".") {
            view?.addAlert(title: "Email должен содержать @ и .")
            return false
        } else if password.count < 9 {
            view?.addAlert(title: "Пароль слишком короткий")
            return false
        } else if username.contains("@"), username.contains("!"), username.contains("."), username.contains("@") {
            view?.addAlert(title: "Некорректное имя пользователя")
            return false
        } else { return true }
    }
}
