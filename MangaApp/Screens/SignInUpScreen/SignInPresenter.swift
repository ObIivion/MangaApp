//
//  SignInPresenter.swift
//  MangaApp
//
//  Created by Павел Виноградов on 11.08.2022.
//

import GoogleSignIn

protocol SignInUpPresenterProtocol {
    
    func signIn()
    func signUp()
}

import Foundation

class SignInPresenter: SignInUpPresenterProtocol {
    
    weak var view: SignInViewProtocol?
    var router: SignInRouter!
    
    func signIn() {
        
        let signInConfig = GIDConfiguration(clientID: "164669230338-m3mupoemq5nv813u40v2m1l66d2g613s.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: view as! UIViewController)
    }
    
    func signUp() {
        
    }
    
}
