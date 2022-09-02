//
//  PreferencesRouter.swift
//  MangaApp
//
//  Created by Павел Виноградов on 31.08.2022.
//

import UIKit

protocol ProfileInfoScreenRoutesProtocol {
    func showImagePickerController()
}

class ProfileInfoRouter: BaseRouter, ProfileInfoScreenRoutesProtocol {
    
    func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = viewController as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        viewController.present(imagePickerController, animated: true, completion: nil)
    }
    
}
