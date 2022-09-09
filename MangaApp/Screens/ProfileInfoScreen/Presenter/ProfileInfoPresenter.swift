//
//  PreferencesPresenter.swift
//  MangaApp
//
//  Created by Павел Виноградов on 31.08.2022.
//

import UIKit

protocol ProfileInfoPresenterProtocol{
    
    func continueButtonPressed(pickedImage: UIImage, name: String, slug: String, location: String, waifuOrHusbando: String)
    func avatarImagePicked(image: UIImage)
    func addPhotoButtonPressed()
}

class ProfileInfoPresenter: ProfileInfoPresenterProtocol {
    
    weak var view: ProfileInfoViewProtocol!
    var router: ProfileInfoScreenRoutesProtocol!
    let userDataProvier = UserDataProvider()
    let moyaUserDataProvider = MoyaUserDataProvider()
 
    func addPhotoButtonPressed() {
        router!.showImagePickerController()
    }
    
    func continueButtonPressed(pickedImage: UIImage, name: String, slug: String, location: String, waifuOrHusbando: String) {
        
        print("continueButtonPressed MoyaUpdateProfile")
        moyaUserDataProvider.moyaUpdateProfile(image: pickedImage, name: name, slug: slug, location: location, waifuOrHusbando: waifuOrHusbando)
        //userDataProvier.updateProfile(image: pickedImage, name: name, slug: slug, location: location, waifuOrHusbando: waifuOrHusbando)
    }
    
    func avatarImagePicked(image: UIImage) {
        view?.setAvatarImage(image: image)
    }
}
