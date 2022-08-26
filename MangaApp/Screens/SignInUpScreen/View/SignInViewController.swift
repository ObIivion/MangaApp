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
     
        mainView.haveAccount.addTarget(self, action: #selector(haveAccountPressed), for: .touchUpInside)
        mainView.signUpTextButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
    }
    
    @objc func haveAccountPressed(_ sender: UIButton){
        
        mainView.setSignInState()
    }
    
    @objc func signUpPressed(_ sender: UIButton){
        
        mainView.setSignUpState()
    }
    
    @objc func textChanged(_ sender: UITextField) {
        
        if mainView.loginField.text?.isEmpty ?? true || mainView.passwordField.text?.isEmpty ?? true {
            mainView.setContinueButtonEnabled(isEnabled: false)
        } else {
            mainView.setContinueButtonEnabled(isEnabled: true)
        }
    }
    
    @objc func continueButtonClicked() {
        
        presenter.signIn(email: "mercy.obiivion@gmail.com", password: "Dinler2015")
    }
    
    @objc func googleSignIn(_ sender: UIButton){
        
        presenter.signInWithGoogle()
    }

}
