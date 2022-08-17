//
//  ViewController.swift
//  MangaApp
//
//  Created by Павел Виноградов on 09.08.2022.
//

import UIKit
import GoogleSignIn

protocol SignInViewProtocol: AnyObject {
    
    
    
}

class SignInViewController: BaseViewController<SignInView>, SignInViewProtocol  {
    
    var presenter: SignInUpPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .white
        
        mainView.customGoogleSignInButton.addTarget(self, action: #selector(googleSignIn), for: .touchUpInside)
        
        mainView.loginField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        mainView.passwordField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        
        mainView.continueButton.addTarget(self, action: #selector(continueButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func textChanged(_ sender: UITextField) {
        
        if mainView.loginField.text?.isEmpty ?? true || mainView.passwordField.text?.isEmpty ?? true {
            mainView.setContinueButtonEnabled(isEnabled: false)
        } else {
            mainView.setContinueButtonEnabled(isEnabled: true)
        }
    }
    
    @objc func continueButtonClicked() {
        
        print("УПАЛИ В BUTTON CLICKED")
        
    }
    
    @objc func googleSignIn(_ sender: UIButton){
        
        presenter.signIn()
        
    }

}
