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
    func signUp()
    
    func checkFieldsBeforeRegistration()
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
        
        authService.obtainingAccessToken(email: email, password: password)
    }
    
    func signUp() {
        
        
    }
    
    func checkFieldsBeforeRegistration() {
        
        
        
    }
    
}
