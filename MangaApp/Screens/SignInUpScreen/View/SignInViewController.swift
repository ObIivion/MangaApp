//
//  ViewController.swift
//  MangaApp
//
//  Created by Павел Виноградов on 09.08.2022.
//

import UIKit
import GoogleSignIn

protocol SignInViewProtocol: AnyObject {
    
    func addAlert(title: String)
    
}

class SignInViewController: BaseViewController<SignInView>  {
    
    var presenter: SignInUpPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .white
        
        mainView.customGoogleSignInButton.addTarget(self, action: #selector(googleSignIn), for: .touchUpInside)
        
        mainView.loginField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        mainView.passwordField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        mainView.usernameField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        
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
        
        if mainView.signState == .signUp {
            if mainView.loginField.text?.isEmpty ?? true || mainView.passwordField.text?.isEmpty ?? true ||  mainView.usernameField.text?.isEmpty ?? true {
                mainView.setContinueButtonEnabled(isEnabled: false)
            } else {
                mainView.setContinueButtonEnabled(isEnabled: true)
            }
        } else {
            if mainView.loginField.text?.isEmpty ?? true || mainView.passwordField.text?.isEmpty ?? true {
                mainView.setContinueButtonEnabled(isEnabled: false)
            } else {
                mainView.setContinueButtonEnabled(isEnabled: true)
            }
        }
    }
    
    @objc func continueButtonClicked(_ sender: UIButton) {
        
        // я могу гарантировать что они не пустые, иначе не нажать кнопочку "continue"
        let username = mainView.usernameField.text!
        let email = mainView.loginField.text!
        let password = mainView.passwordField.text!
        
        let userDefaults = UserDefaults.standard
        
        switch mainView.signState {
            case .signIn:
                if presenter.checkFieldsBeforeSignIn(email: email, password: password) {
                    presenter.signIn(email: email , password: password)
                    
                } else { return }
            
            case .signUp:
                if presenter.checkFieldsBeforeSignUp(username: username, email: email, password: password) {
                    presenter.signUp(email: email, password: password, username: username)
                } else { return }
        }
    }
       
    @objc func googleSignIn(_ sender: UIButton){
        
        presenter.signInWithGoogle()
    }
}
    
extension SignInViewController: SignInViewProtocol {

    func addAlert(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertOK = UIAlertAction(title: "Ок", style: .default)
        alertController.addAction(alertOK)
        present(alertController, animated: true)
    }

}
