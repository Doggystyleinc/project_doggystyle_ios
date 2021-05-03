//
//  SignUpViewController.swift
//  Project Doggystyle
//
//  Created by Stanley Miller on 5/3/21.
//

import UIKit

class SignUpViewController: UIViewController {
    private let verticalPadding: CGFloat = 30.0
    
    //TODO: - refactor to resuable view
    private let welcomeTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.robotoBold(size: 30)
        label.text = "Welcome!"
        label.textColor = .black
        return label
    }()
    
    //TODO: - refactor to resuable view
    private let welcomeSubTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.robotoRegular(size: 18)
        label.text = "Please sign up with:"
        label.textColor = .black
        return label
    }()
    
    //TODO: - refactor to resuable view
    private let dividerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.divider
        return view
    }()
    
    //TODO: - refactor to resuable view
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.robotoBold(size: 18)
        button.setTitle("EMAIL", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.buttonBackground
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addWelcomeViews()
        self.configureSignUpButtons()
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

//MARK: - Configure Sign Up Buttons
extension SignUpViewController {
    private func configureSignUpButtons() {
        self.view.addSubview(signUpButton)
        
        signUpButton.topToBottom(of: self.dividerView, offset: 30.0)
        signUpButton.height(44)
        signUpButton.left(to: self.view, offset: verticalPadding)
        signUpButton.right(to: self.view, offset: -verticalPadding)
    }
}
