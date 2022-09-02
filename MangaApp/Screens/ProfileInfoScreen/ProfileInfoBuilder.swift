//
//  PreferenceBuilder.swift
//  MangaApp
//
//  Created by Павел Виноградов on 31.08.2022.
//

import UIKit

class ProfileInfoScreen {
    
    let view: ProfileInfoViewController
    let presenter: ProfileInfoPresenter
    let router: ProfileInfoRouter
    
    private init(view: ProfileInfoViewController, presenter: ProfileInfoPresenter, router: ProfileInfoRouter) {
        
        self.view = view
        self.presenter = presenter
        self.router = router
    }
    
    static func build() -> ProfileInfoScreen {
        
        let view = ProfileInfoViewController()
        let presenter = ProfileInfoPresenter()
        let router = ProfileInfoRouter()
        
        presenter.view = view
        presenter.router = router
        router.viewController = view
        view.presenter = presenter
        
        return ProfileInfoScreen(view: view, presenter: presenter, router: router)
    }
}
