//
//  ViewController.swift
//  MangaApp
//
//  Created by Павел Виноградов on 09.08.2022.
//

import UIKit
import GoogleSignIn

class SignInViewController: BaseViewController<SignInView>  {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = .white
        
        mainView.customGoogleSignInButton.addTarget(self, action: #selector(googleSignIn), for: .touchUpInside)
        
    }
    
    @objc func googleSignIn(_ sender: UIButton){
        
        let signInConfig = GIDConfiguration(clientID: "164669230338-m3mupoemq5nv813u40v2m1l66d2g613s.apps.googleusercontent.com")

        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self)
        print(GIDSignIn.sharedInstance.currentUser?.profile?.email)
        print(GIDSignIn.sharedInstance.currentUser?.profile?.name)
        print(GIDSignIn.sharedInstance.currentUser?.profile?.familyName)
        
    }

}
