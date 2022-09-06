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
        print("упали в continue button pressed")
        guard let dataImage = pickedImage.jpegData(compressionQuality: 0.1) else { print("не удалось передать картинку в запрос"); return }
        let base64ImageString = dataImage.base64EncodedString()
        let imageStringForRequset = "data:image/jpeg;base64,\(base64ImageString)"
        print("BASE 64 String: \(imageStringForRequset)")
        authService.updateProfile(base64ImageString: base64ImageString, name: name, slug: slug, location: location, waifuOrHusbando: waifuOrHusbando)
    }
    
    func avatarImagePicked(image: UIImage) {
        view?.setAvatarImage(image: image)
    }
}
