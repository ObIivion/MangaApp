//
//  Rotuer.swift
//  MangaApp
//
//  Created by Павел Виноградов on 17.08.2022.
//

import UIKit

protocol SignInScreenRoutes {
    
    func openUserPreferencesScreen()
    func openTrendingScreen()
    
}

class SignInRouter: BaseRouter, SignInScreenRoutes {
    
    func openUserPreferencesScreen() {
        
        let profileInfoScreen = ProfileInfoScreen.build().view
        
        profileInfoScreen.modalPresentationStyle = .fullScreen
        profileInfoScreen.modalTransitionStyle = .coverVertical
        viewController.present(profileInfoScreen, animated: true, completion: nil)

    }
    
    func openTrendingScreen() {
        // open trends
    }
    
}
