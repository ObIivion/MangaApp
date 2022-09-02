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
    let authService = UserDataProvider()
 
    func addPhotoButtonPressed() {
        router!.showImagePickerController()
    }
    
    func continueButtonPressed(pickedImage: UIImage, name: String, slug: String, location: String, waifuOrHusbando: String) {
        
        guard let dataImage = pickedImage.jpegData(compressionQuality: 0.8) else { print("не удалось передать картинку в запрос"); return }
        authService.updateProfile(imageData: dataImage, name: name, slug: slug, location: location, waifuOrHusbando: waifuOrHusbando)
    }
    
    func avatarImagePicked(image: UIImage) {
        view?.setAvatarImage(image: image)
    }
}
