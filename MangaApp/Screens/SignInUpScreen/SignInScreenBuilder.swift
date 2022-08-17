//
//  SignInScreenBuilder.swift
//  MangaApp
//
//  Created by Павел Виноградов on 17.08.2022.
//

import UIKit

class SignInUpScreen {
    
    let presenter: SignInPresenter
    let router: SignInRouter
    let view: SignInViewController
    
    private init(presenter: SignInPresenter, router: SignInRouter, view: SignInViewController) {
        self.presenter = presenter
        self.router = router
        self.view = view
    }
    
    static func build() -> SignInUpScreen {
        let presenter = SignInPresenter()
        let router = SignInRouter()
        let view = SignInViewController()
        
        presenter.view = view
        presenter.router = router
        router.viewController = view
        view.presenter = presenter
        
        return SignInUpScreen(presenter: presenter, router: router, view: view)
    }
    
}
