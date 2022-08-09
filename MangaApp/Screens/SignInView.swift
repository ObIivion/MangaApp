//
//  SignInView.swift
//  MangaApp
//
//  Created by Павел Виноградов on 09.08.2022.
//

import UIKit

class SignInView: BaseView {
    
    private let welcomeTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Welcome"
        view.textColor = UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1)
        view.font = R.font.ubuntuMedium(size: 36)
        view.textAlignment = .center
        return view
    }()
    
    private let subTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Sign in to start"
        view.font = R.font.ubuntuRegular(size: 16)
        view.textColor = UIColor(red: 0.617, green: 0.617, blue: 0.617, alpha: 1)
        view.textAlignment = .center
        return view
    }()
    
    let customGoogleSignInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Continue with google", for: .normal)
        button.titleLabel?.font = R.font.ubuntuRegular(size: 16)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1), for: .normal)
        button.setImage(R.image.google(), for: .normal)
        button.imageEdgeInsets.right = 40
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.cornerRadius = 25
        return button
    }()
    
    
    override func initSetup() {
        
        addSubview(welcomeTitleLabel)
        addSubview(subTitleLabel)
        addSubview(customGoogleSignInButton)
        
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        
        welcomeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            welcomeTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 56),
            welcomeTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            subTitleLabel.topAnchor.constraint(equalTo: welcomeTitleLabel.bottomAnchor, constant: 5),
            subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        customGoogleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            customGoogleSignInButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 60),
            customGoogleSignInButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            customGoogleSignInButton.widthAnchor.constraint(equalToConstant: 280),
            customGoogleSignInButton.heightAnchor.constraint(equalToConstant: 43)
        ])
        
    }

}

