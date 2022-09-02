//
//  PreferencesView.swift
//  MangaApp
//
//  Created by Павел Виноградов on 31.08.2022.
//

import UIKit
import SnapKit
import Rswift

// check using SnapKit

class ProfileInfoView: BaseView {
    
    private let avatarImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(red: 0.617, green: 0.617, blue: 0.617, alpha: 1)
        view.clipsToBounds = true
        return view
    }()
    private let gradientCircleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        return view
    }()
    private let gradientLayer = CAGradientLayer()
    private let pluslabel: UILabel = {
        let label = UILabel()
        label.text = "+"
        label.font = R.font.ubuntuMedium(size: 30)
        label.textColor = .white
        return label
    }()
    
    private let nameField = UITextField()
    private let nameWhiteLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.617, green: 0.617, blue: 0.617, alpha: 1)
        return view
    }()
    
    private let slugField = UITextField()
    private let slugWhiteLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.617, green: 0.617, blue: 0.617, alpha: 1)
        return view
    }()
    
    private let locationField = UITextField()
    private let locationWhiteLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.617, green: 0.617, blue: 0.617, alpha: 1)
        return view
    }()
    
    private let waifuOrHusbandoField = UITextField()
    private let waifuOrHusbandoFieldWhiteLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.617, green: 0.617, blue: 0.617, alpha: 1)
        return view
    }()
    
    let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = R.font.ubuntuRegular(size: 16)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor(red: 0.617, green: 0.617, blue: 0.617, alpha: 1)
        button.layer.cornerRadius = 25
        button.isEnabled = false
        return button
    }()
    
    override func initSetup() {
        
        setupField(field: nameField, withText: "Enter your name")
        setupField(field: slugField, withText: "Enter your nickname (slug)")
        setupField(field: locationField, withText: "Write your location")
        setupField(field: waifuOrHusbandoField, withText: "Waifu or husbando?")
        
        addSubview(avatarImage)
        addSubview(gradientCircleView)
        addSubview(pluslabel)
        addSubview(nameField)
        addSubview(nameWhiteLine)
        addSubview(slugField)
        addSubview(slugWhiteLine)
        addSubview(locationField)
        addSubview(locationWhiteLine)
        addSubview(waifuOrHusbandoField)
        addSubview(waifuOrHusbandoFieldWhiteLine)
        addSubview(continueButton)
        
        createGradient()
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImage.layer.cornerRadius = avatarImage.bounds.width / 2
        gradientLayer.frame = gradientCircleView.bounds
    }
    
    private func setupField(field: UITextField, withText: String) {
        
        backgroundColor = .white
        
        field.textColor = .white
        field.textAlignment = .left
        field.attributedPlaceholder = NSAttributedString(string: withText,
                                                         attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 0.617, green: 0.617, blue: 0.617, alpha: 1)])
        field.font = R.font.ubuntuRegular(size: 16)
        field.backgroundColor = .clear
        field.textColor = UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1)
        field.tintColor = UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1)
    }
    
    private func createGradient() {
        
        gradientLayer.colors = [
            UIColor(red: 0.635, green: 0.698, blue: 0.988, alpha: 1).cgColor,
            UIColor(red: 1, green: 0.944, blue: 0.744, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.25, 1.3]
        
        gradientLayer.startPoint = CGPoint(x: 1, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)

        gradientLayer.position = gradientCircleView.center
        gradientLayer.cornerRadius = 15
        gradientCircleView.layer.addSublayer(gradientLayer)
        
    }
    
    private func setupConstraints() {
        
        avatarImage.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(29)
            make.width.equalTo(77)
            make.height.equalTo(77)
        }
        
        gradientCircleView.snp.makeConstraints { make in
            make.bottom.equalTo(avatarImage.snp.bottom)
            make.trailing.equalTo(avatarImage.snp.trailing)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        pluslabel.snp.makeConstraints { make in
            make.center.equalTo(gradientCircleView.snp.center)
        }
        
        nameField.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(avatarImage.snp.bottom).offset(67)
            make.width.equalTo(280)
        }
        
        nameWhiteLine.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(nameField.snp.bottom).offset(5)
            make.width.equalTo(nameField.snp.width)
            make.height.equalTo(1)
        }
        
        slugField.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(nameWhiteLine.snp.bottom).offset(48)
            make.width.equalTo(nameField.snp.width)
        }
        
        slugWhiteLine.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(slugField.snp.bottom).offset(5)
            make.width.equalTo(nameField.snp.width)
            make.height.equalTo(1)
        }
        
        locationField.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(slugWhiteLine.snp.bottom).offset(48)
            make.width.equalTo(nameField.snp.width)
        }
        
        locationWhiteLine.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(locationField.snp.bottom).offset(5)
            make.width.equalTo(nameField.snp.width)
            make.height.equalTo(1)
        }
        
        waifuOrHusbandoField.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(locationWhiteLine.snp.bottom).offset(48)
            make.width.equalTo(nameField.snp.width)
        }
        
        waifuOrHusbandoFieldWhiteLine.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(waifuOrHusbandoField.snp.bottom).offset(5)
            make.width.equalTo(nameField.snp.width)
            make.height.equalTo(1)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(-92)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(280)
            make.height.equalTo(43)
        }
        
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -92),
            continueButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 280),
            continueButton.heightAnchor.constraint(equalToConstant: 43)
        ])
        
    }
    
}
