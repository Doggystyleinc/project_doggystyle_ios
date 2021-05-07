//
//  SignUpViewController.swift
//  Project Doggystyle
//
//  Created by Stanley Miller on 5/3/21.
//

import UIKit

class SignUpViewController: UIViewController {
    private let verticalPadding: CGFloat = 30.0
    
    private let welcomeTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.robotoBold(size: 30)
        label.text = "Welcome!"
        label.textColor = .headerColor
        return label
    }()
    
    private let welcomeSubTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.robotoRegular(size: 18)
        label.text = "Please sign up with:"
        label.textColor = .textColor
        return label
    }()
    
    private let footerText: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.robotoRegular(size: 18)
        label.text = "Already have an account?"
        label.textColor = .textColor
        return label
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        let attributes: [NSAttributedString.Key : Any] = [
            .font : UIFont.robotoRegular(size: 20.0),
            .foregroundColor : UIColor.textColor,
            .underlineStyle : NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(string: "SIGN IN", attributes: attributes)
        button.setAttributedTitle(attributeString, for: .normal)
        button.addTarget(self, action: #selector(presentSignIn(_:)), for: .touchUpInside)
        return button
    }()
    
    private let dividerView = DividerView()
    
    private let emailButton = DSButton(titleText: "email", backgroundColor: .dsGrey, titleColor: .white)
    private let googleButton = DSButton(text: "google")
    private let facebookButton = DSButton(text: "facebook")
    private let appleButton = DSButton(text: "apple")
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addWelcomeViews()
        self.addSignUpButtons()
        self.addTargets()
    }
}

//MARK: - Configure Welcome Message
extension SignUpViewController {
    private func addWelcomeViews() {
        self.view.addSubview(welcomeTitle)
        welcomeTitle.top(to: self.view, offset: 80.0)
        welcomeTitle.left(to: self.view, offset: verticalPadding)
        
        self.view.addSubview(welcomeSubTitle)
        welcomeSubTitle.topToBottom(of: self.welcomeTitle, offset: 20.0)
        welcomeSubTitle.left(to: self.view, offset: verticalPadding)
        welcomeSubTitle.right(to: self.view, offset: -verticalPadding)
        
        self.view.addSubview(dividerView)
        dividerView.height(0.5)
        dividerView.topToBottom(of: self.welcomeSubTitle, offset: 20.0)
        dividerView.left(to: self.view, offset: verticalPadding)
        dividerView.right(to: self.view, offset: -verticalPadding)
    }
}

//MARK: - Configure Sign Up/In Buttons
extension SignUpViewController {
    private func addSignUpButtons() {
        self.view.addSubview(emailButton)
        emailButton.topToBottom(of: self.dividerView, offset: verticalPadding)
        emailButton.height(44)
        emailButton.left(to: self.view, offset: verticalPadding)
        emailButton.right(to: self.view, offset: -verticalPadding)
        
        self.view.addSubview(googleButton)
        googleButton.topToBottom(of: self.emailButton, offset: 10.0)
        googleButton.height(44)
        googleButton.left(to: self.view, offset: verticalPadding)
        googleButton.right(to: self.view, offset: -verticalPadding)
        
        self.view.addSubview(facebookButton)
        facebookButton.topToBottom(of: self.googleButton, offset: 10.0)
        facebookButton.height(44)
        facebookButton.left(to: self.view, offset: verticalPadding)
        facebookButton.right(to: self.view, offset: -verticalPadding)
        
        self.view.addSubview(appleButton)
        appleButton.topToBottom(of: self.facebookButton, offset: 10.0)
        appleButton.height(44)
        appleButton.left(to: self.view, offset: verticalPadding)
        appleButton.right(to: self.view, offset: -verticalPadding)
        
        self.view.addSubview(footerText)
        footerText.topToBottom(of: self.appleButton, offset: verticalPadding)
        footerText.centerX(to: self.view)
        
        self.view.addSubview(signInButton)
        signInButton.topToBottom(of: footerText, offset: 24)
        signInButton.centerX(to: self.view)
        signInButton.height(24)
    }
}

//MARK: - Add Button Targets
extension SignUpViewController {
    private func addTargets() {
        self.emailButton.addTarget(self, action: #selector(presentEmailSignUp(_:)), for: .touchUpInside)
        self.googleButton.addTarget(self, action: #selector(didTapGoogleButton(_:)), for: .touchUpInside)
        self.facebookButton.addTarget(self, action: #selector(didTapFacebookButton(_:)), for: .touchUpInside)
        self.appleButton.addTarget(self, action: #selector(didTapAppleButton(_:)), for: .touchUpInside)
    }
}

//MARK: - @objc Functions
extension SignUpViewController {
    @objc private func presentEmailSignUp(_ sender: UIButton) {
        self.present(EmailSignUpViewController(), animated: true)
    }
    
    @objc private func presentSignIn(_ sender: UIButton) {
        self.present(SignInViewController(), animated: true)
    }
    
    @objc private func didTapGoogleButton(_ sender: UIButton) {
        print(#function)
    }
    
    @objc private func didTapFacebookButton(_ sender: UIButton) {
        print(#function)
    }
    
    @objc private func didTapAppleButton(_ sender: UIButton) {
        print(#function)
    }
}
