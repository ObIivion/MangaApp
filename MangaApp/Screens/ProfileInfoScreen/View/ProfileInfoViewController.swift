//
//  PreferencesViewController.swift
//  MangaApp
//
//  Created by Павел Виноградов on 31.08.2022.
//

import UIKit

protocol ProfileInfoViewProtocol: AnyObject {
    
    
}

class ProfileInfoViewController: BaseViewController<ProfileInfoView> {
    
    var presenter: ProfileInfoPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}

extension ProfileInfoViewController: ProfileInfoViewProtocol {
    
    
    
}
