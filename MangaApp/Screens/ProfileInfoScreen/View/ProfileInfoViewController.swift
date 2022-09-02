//
//  PreferencesViewController.swift
//  MangaApp
//
//  Created by Павел Виноградов on 31.08.2022.
//

import UIKit

protocol ProfileInfoViewProtocol: AnyObject {
    
    func setAvatarImage(image: UIImage)
}

class ProfileInfoViewController: BaseViewController<ProfileInfoView> {
    
    var presenter: ProfileInfoPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.gradientCircleButton.addTarget(self, action: #selector(addPhotoButtonClicked), for: .touchUpInside)
        mainView.continueButton.addTarget(self, action: #selector(continueButtonClicked), for: .touchUpInside)
    }
    
    @objc func addPhotoButtonClicked(_ sender: UIButton) {
        presenter.addPhotoButtonPressed()
    }
    
    @objc func continueButtonClicked(_ sender: UIButton) {
        let nameText = mainView.nameField.text ?? ""
        let slugText = mainView.slugField.text ?? ""
        let locationText = mainView.locationField.text ?? ""
        let waifuOrHusbandoText = mainView.waifuOrHusbandoField.text ?? ""
        if let avatarImage = mainView.avatarImageView.image {
            presenter.continueButtonPressed(pickedImage: avatarImage, name: nameText, slug: slugText, location: locationText, waifuOrHusbando: waifuOrHusbandoText)
        } else {
            return
        }
    }
}

extension ProfileInfoViewController: ProfileInfoViewProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePickerController() {
        presenter.addPhotoButtonPressed()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            presenter.avatarImagePicked(image: editedImage)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            presenter.avatarImagePicked(image: originalImage)
        }
        dismiss(animated: true)
    }
    
    func setAvatarImage(image: UIImage) {
        mainView.setAvatarImage(image: image)
    }
    
}
