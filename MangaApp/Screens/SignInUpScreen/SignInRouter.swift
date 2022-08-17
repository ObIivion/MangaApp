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

class SignInRouter: SignInScreenRoutes {
    
    weak var viewController: UIViewController!
    
    func openUserPreferencesScreen() {
        
//        let secondScreen = SecondModule.build(with: text).view
        
//        secondScreen.modalPresentationStyle = .popover
//        secondScreen.modalTransitionStyle = .coverVertical
//        viewController.present(secondScreen, animated: true, completion: nil)
//        open user preferences
    }
    
    func openTrendingScreen() {
        // open trends
    }
    
}
