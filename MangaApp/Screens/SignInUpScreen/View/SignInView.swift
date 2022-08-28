//
//  SignInView.swift
//  MangaApp
//
//  Created by Павел Виноградов on 09.08.2022.
//

import UIKit

class SignInView: BaseView {
    
    enum SignState {
        case signIn
        case signUp
    }
    
    var signState: SignState = .signIn
    
    private var gradientMenuTopConstraint = NSLayoutConstraint()
    
    private let gradientLayer = CAGradientLayer()
    
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
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.setImage(R.image.google(), for: .normal)
        button.setImage(R.image.google(), for: .highlighted)
        button.imageEdgeInsets.right = 40
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.cornerRadius = 25
        return button
    }()
    
    private let stackWithSignUp: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalCentering
        view.spacing = 3
        return view
    }()
    
    private let haventAccountLabel: UILabel = {
        let view = UILabel()
        view.font = R.font.ubuntuRegular(size: 16)
        view.textAlignment = .center
        view.text = "Haven't account?"
        view.textColor = .black
        return view
    }()
    
    let signUpTextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up!", for: .normal)
        button.setTitleColor(UIColor(red: 32/255, green: 121/255, blue: 1, alpha: 1), for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.titleLabel?.font = R.font.ubuntuRegular(size: 16)
        return button
    }()
    
    private let gradientView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        return view
    }()
    
    let loginField: UITextField = {
        let field = UITextField()
        field.textColor = .white
        field.textAlignment = .left
        field.attributedPlaceholder = NSAttributedString(string: "Login",
                                                         attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        field.font = R.font.ubuntuRegular(size: 16)
        field.backgroundColor = .clear
        field.tintColor = .white
        return field
    }()
    
    private let loginWhiteLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.textColor = .white
        field.textAlignment = .left
        field.attributedPlaceholder = NSAttributedString(string: "Password",
                                                         attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        field.font = R.font.ubuntuRegular(size: 16)
        field.backgroundColor = .clear
        field.tintColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private let passwordWhiteLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("forgot password?", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor(red: 0.617, green: 0.617, blue: 0.617, alpha: 1), for: .highlighted)
        button.titleLabel?.font = R.font.ubuntuRegular(size: 14)
        return button
    }()
    
    let usernameField: UITextField = {
        let field = UITextField()
        field.textColor = .white
        field.textAlignment = .left
        field.attributedPlaceholder = NSAttributedString(string: "Username",
                                                         attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        field.font = R.font.ubuntuRegular(size: 16)
        field.backgroundColor = .clear
        field.tintColor = .white
        field.isHidden = true
        return field
    }()
    
    private let usernameWhiteLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    let haveAccount: UIButton = {
        let button = UIButton()
        button.setTitle("Have account? Sign in!", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor(red: 0.617, green: 0.617, blue: 0.617, alpha: 1), for: .highlighted)
        button.titleLabel?.font = R.font.ubuntuRegular(size: 16)
        button.isHidden = true
        return button
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
        
        gradientMenuTopConstraint = gradientView.topAnchor.constraint(equalTo: stackWithSignUp.bottomAnchor, constant: 150)
        
        createGradient()
        
        addSubview(welcomeTitleLabel)
        addSubview(subTitleLabel)
        addSubview(customGoogleSignInButton)
        addSubview(stackWithSignUp)
        configureStackView()
        addSubview(gradientView)
        addSubview(loginField)
        addSubview(loginWhiteLine)
        addSubview(passwordField)
        addSubview(passwordWhiteLine)
        addSubview(usernameField)
        addSubview(usernameWhiteLine)
        addSubview(haveAccount)
        addSubview(forgotPasswordButton)
        addSubview(continueButton)
        
        setupConstraints()
    }
    
    func setSignInState() {
        UIView.animate(withDuration: 1) {
            self.gradientMenuTopConstraint.constant = 150
            self.layoutIfNeeded()
            self.haveAccount.isHidden = true
            self.usernameField.isHidden = true
            self.usernameWhiteLine.isHidden = true
            self.forgotPasswordButton.isHidden = false
            self.stackWithSignUp.isHidden = false
            self.subTitleLabel.text = "Sign in to start"
        }
        self.signState = .signIn
    }
    
    func setSignUpState() {
        UIView.animate(withDuration: 1) {
            self.gradientMenuTopConstraint.constant = 90
            self.layoutIfNeeded()
            self.haveAccount.isHidden = false
            self.usernameField.isHidden = false
            self.usernameWhiteLine.isHidden = false
            self.forgotPasswordButton.isHidden = true
            self.stackWithSignUp.isHidden = true
            self.haveAccount.isHidden = false
            self.subTitleLabel.text = "Sign up to start"
        }
        self.signState = .signUp
    }
    
    func setContinueButtonEnabled(isEnabled: Bool) {
        
        if isEnabled {
            continueButton.isEnabled = true
            continueButton.backgroundColor = UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1)
        } else {
            continueButton.isEnabled = false
            continueButton.backgroundColor = UIColor(red: 0.617, green: 0.617, blue: 0.617, alpha: 1)
        }
    }
    
    private func configureStackView() {
        
        stackWithSignUp.addArrangedSubview(haventAccountLabel)
        stackWithSignUp.addArrangedSubview(signUpTextButton)
    }
    
    private func createGradient() {
        
        gradientLayer.colors = [
            UIColor(red: 0.635, green: 0.698, blue: 0.988, alpha: 1).cgColor,
            UIColor(red: 1, green: 0.944, blue: 0.744, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.25, 1.3]
        
        gradientLayer.startPoint = CGPoint(x: 1, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)

        gradientLayer.position = gradientView.center
        gradientLayer.cornerRadius = 20
        gradientView.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = gradientView.bounds
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
        
        stackWithSignUp.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            stackWithSignUp.topAnchor.constraint(equalTo: customGoogleSignInButton.bottomAnchor, constant: 20),
            stackWithSignUp.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        gradientView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            gradientMenuTopConstraint,
            gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        loginField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            loginField.topAnchor.constraint(equalTo: gradientView.topAnchor, constant: 60),
            loginField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 57),
            loginField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48),
        ])

        loginWhiteLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            loginWhiteLine.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 5),
            loginWhiteLine.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginWhiteLine.widthAnchor.constraint(equalToConstant: 320),
            loginWhiteLine.heightAnchor.constraint(equalToConstant: 1)
        ])

        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            passwordField.topAnchor.constraint(equalTo: loginWhiteLine.bottomAnchor, constant: 40),
            passwordField.leadingAnchor.constraint(equalTo: loginField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48),
        ])

        passwordWhiteLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            passwordWhiteLine.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 5),
            passwordWhiteLine.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordWhiteLine.widthAnchor.constraint(equalToConstant: 320),
            passwordWhiteLine.heightAnchor.constraint(equalToConstant: 1)
        ])

        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            forgotPasswordButton.topAnchor.constraint(equalTo: passwordWhiteLine.bottomAnchor, constant: 10),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordWhiteLine.trailingAnchor, constant: -11)
        ])

        usernameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            usernameField.topAnchor.constraint(equalTo: passwordWhiteLine.bottomAnchor, constant: 40),
            usernameField.leadingAnchor.constraint(equalTo: loginField.leadingAnchor),
            usernameField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48),
        ])

        usernameWhiteLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            usernameWhiteLine.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 5),
            usernameWhiteLine.centerXAnchor.constraint(equalTo: centerXAnchor),
            usernameWhiteLine.widthAnchor.constraint(equalToConstant: 320),
            usernameWhiteLine.heightAnchor.constraint(equalToConstant: 1)
        ])

        haveAccount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            haveAccount.topAnchor.constraint(equalTo: usernameWhiteLine.bottomAnchor, constant: 30),
            haveAccount.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -92),
            continueButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 280),
            continueButton.heightAnchor.constraint(equalToConstant: 43)
        ])
        
    }
    
}

