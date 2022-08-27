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
    func signUp(email: String, password: String)
    
    func checkFieldsBeforeSignIn(email: String, password: String) -> Bool
    func checkFieldsBeforeSignUp(email: String, password: String, completePassword: String) -> Bool
}

import Foundation

class SignInPresenter: SignInUpPresenterProtocol {
    
    weak var view: SignInViewProtocol?
    var router: SignInRouter!
    
    let authService = AuthService()
    
    func signInWithGoogle() {
        
        let signInConfig = GIDConfiguration(clientID: "164669230338-m3mupoemq5nv813u40v2m1l66d2g613s.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: view as! UIViewController)
    }
    
    func signUpWithGoogle() {
        
        
        
    }
    
    func signIn(email: String, password: String) {
        checkFieldsBeforeSignIn(email: email, password: password)
        authService.obtainingAccessToken(email: email, password: password)
    }
    
    func signUp(email: String, password: String) {
        
        authService.registerUser(email: email, password: password)
        
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
    
    func checkFieldsBeforeSignUp(email: String, password: String, completePassword: String) -> Bool {
        
        if !email.contains("@") || !email.contains(".") {
            view?.addAlert(title: "Email должен содержать @ и .")
            return false
        } else if password.count < 9 {
            view?.addAlert(title: "Пароль слишком короткий")
            return false
        } else if password != completePassword {
            view?.addAlert(title: "Пароли не совпадают")
            return false
        } else { return true }
    }
}
