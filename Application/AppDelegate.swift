//
//  AppDelegate.swift
//  MangaApp
//
//  Created by Павел Виноградов on 09.08.2022.
//

import UIKit
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SignInViewController()
        window?.makeKeyAndVisible()
        
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
              // Show the app's signed-out state.
            } else {
              // Show the app's signed-in state.
            }
          }
          return true
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        var handled: Bool

        handled = GIDSignIn.sharedInstance.handle(url)
          if handled {
            return true
          }

          // Handle other custom URL types.

          // If not handled by this app, return false.
          return false

    }
    
}
