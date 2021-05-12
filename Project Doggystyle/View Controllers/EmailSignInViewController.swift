//
//  EmailSignInViewController.swift
//  Project Doggystyle
//
//  Created by Stanley Miller on 5/11/21.
//

import UIKit

final class EmailSignInViewController: UIViewController {
    private let verticalPadding: CGFloat = 30.0
    private var rememberUser = false
    private var forgotPassword = false
    private var scrollView = UIScrollView(frame: .zero)
    private let containerView = UIView(frame: .zero)
    
    private let welcomeTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.robotoBold(size: 30)
        label.text = "Email sign in"
        label.textColor = .headerColor
        return label
    }()
    
    private let dividerView = DividerView()
    
    private let emailTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10.0
        textField.setLeftPaddingPoints(10)
        textField.backgroundColor = .textFieldBackground
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        textField.tag = 0
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10.0
        textField.setLeftPaddingPoints(10)
        textField.backgroundColor = .textFieldBackground
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.textContentType = .oneTimeCode
        textField.returnKeyType = .go
        textField.tag = 1
        return textField
    }()
    
    private let rememberTitle: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = false
        button.setTitle("Remember me", for: .normal)
        button.setTitleColor(.textColor, for: .normal)
        button.titleLabel?.font = UIFont.robotoRegular(size: 16)
        return button
    }()
    
    private let rememberUserButton: UIButton = {
        let button = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        button.tintColor = .white
        button.backgroundColor = .textFieldBackground
        button.setImage(UIImage(systemName: "checkmark", withConfiguration: imageConfig), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 3, bottom: 5, right: 4)
        button.addTarget(self, action: #selector(keepUserLoggedIn(_:)), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordTitle: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(.textColor, for: .normal)
        button.titleLabel?.font = UIFont.robotoRegular(size: 16)
        button.addTarget(self, action: #selector(didTapForgotPassword(_:)), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .bold)
        button.tintColor = .textFieldBackground
        button.setImage(UIImage(systemName: "questionmark.circle.fill", withConfiguration: imageConfig), for: .normal)
        button.addTarget(self, action: #selector(didTapForgotPassword(_:)), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordSubTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Enter the email associated with your account and we'll send you password reset instructions."
        label.numberOfLines = 2
        label.font = UIFont.robotoRegular(size: 15)
        label.tintColor = .textColor
        label.layer.opacity = 0.0
        return label
    }()
    
    private let forgotPasswordEmailTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10.0
        textField.setLeftPaddingPoints(10)
        textField.backgroundColor = .textFieldBackground
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .done
        textField.layer.opacity = 0.0
        textField.tag = 3
        return textField
    }()
    
    private let signInButton: DSButton = {
        let button = DSButton(titleText: "Sign In", backgroundColor: .dsGrey, titleColor: .white)
        button.addTarget(self, action: #selector(didTapSignIn(_:)), for: .touchUpInside)
        return button
    }()
    
    private let submitButton: DSButton = {
        let button = DSButton(text: "Submit")
        button.layer.opacity = 0.0
        button.addTarget(self, action: #selector(didTapSubmit(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureVC()
        self.observeForKeyboard()
        self.dismissKeyboardTapGesture()
        self.addWelcomeViews()
        self.addScrollView()
        self.addTextFields()
        self.addFooterViews()
        self.addForgotPasswordViews()
    }
}


//MARK: - Configure View Controller
extension EmailSignInViewController {
    private func configureVC() {
        self.view.backgroundColor = .white
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.forgotPasswordEmailTextField.delegate = self
        self.scrollView.showsVerticalScrollIndicator = false
        
        self.view.addSubview(signInButton)
        signInButton.height(44)
        signInButton.left(to: self.view, offset: verticalPadding)
        signInButton.right(to: self.view, offset: -verticalPadding)
        signInButton.bottom(to: self.view, offset: -50)
    }
}


//MARK: - Configure Welcome Message
extension EmailSignInViewController {
    private func addWelcomeViews() {
        self.view.addSubview(welcomeTitle)
        welcomeTitle.top(to: self.view, offset: 80.0)
        welcomeTitle.left(to: self.view, offset: verticalPadding)
        
        self.view.addSubview(dividerView)
        dividerView.height(0.5)
        dividerView.topToBottom(of: self.welcomeTitle, offset: 20.0)
        dividerView.left(to: self.view, offset: verticalPadding)
        dividerView.right(to: self.view, offset: -verticalPadding)
    }
}


//MARK: - Configure Scroll Views
extension EmailSignInViewController {
    private func addScrollView() {
        self.view.addSubview(scrollView)
        scrollView.topToBottom(of: dividerView)
        scrollView.left(to: self.view, offset: verticalPadding)
        scrollView.right(to: self.view, offset: -verticalPadding)
        scrollView.height(490)
        
        self.scrollView.addSubview(containerView)
        containerView.edgesToSuperview()
        containerView.width(to: self.scrollView)
        containerView.height(590)
    }
}


//MARK: - Configure Text Fields
extension EmailSignInViewController {
    private func addTextFields() {
        self.containerView.addSubview(emailTextField)
        emailTextField.top(to: self.containerView, offset: 20)
        emailTextField.height(44.0)
        emailTextField.left(to: self.containerView)
        emailTextField.right(to: self.containerView)
        
        self.containerView.addSubview(passwordTextField)
        self.passwordTextField.enablePasswordToggle()
        
        passwordTextField.topToBottom(of: self.emailTextField, offset: 20.0)
        passwordTextField.height(44.0)
        passwordTextField.left(to: self.containerView)
        passwordTextField.right(to: self.containerView)
    }
}

//MARK: - Configure Footer Views
extension EmailSignInViewController {
    private func addFooterViews() {
        self.containerView.addSubview(rememberTitle)
        rememberTitle.topToBottom(of: self.passwordTextField, offset: 20.0)
        rememberTitle.height(44.0)
        rememberTitle.left(to: self.containerView, offset: 11)
        
        self.containerView.addSubview(rememberUserButton)
        rememberUserButton.centerY(to: self.rememberTitle)
        rememberUserButton.right(to: self.passwordTextField, offset: -11)
        rememberUserButton.height(22)
        rememberUserButton.width(22)
    }
}


//MARK: - Configure Forgot Password Views
extension EmailSignInViewController {
    private func addForgotPasswordViews() {
        self.containerView.addSubview(forgotPasswordTitle)
        forgotPasswordTitle.topToBottom(of: self.rememberUserButton, offset: 20.0)
        forgotPasswordTitle.height(44.0)
        forgotPasswordTitle.left(to: self.containerView, offset: 11)
        
        self.containerView.addSubview(forgotPasswordButton)
        forgotPasswordButton.centerY(to: self.forgotPasswordTitle)
        forgotPasswordButton.right(to: self.passwordTextField, offset: -11)
        forgotPasswordButton.height(24)
        forgotPasswordButton.width(24)
        
        self.containerView.addSubview(forgotPasswordSubTitle)
        forgotPasswordSubTitle.topToBottom(of: self.forgotPasswordTitle, offset: 20.0)
        forgotPasswordSubTitle.left(to: self.containerView, offset: 8)
        forgotPasswordSubTitle.right(to: self.containerView, offset: -8)
        
        self.containerView.addSubview(forgotPasswordEmailTextField)
        forgotPasswordEmailTextField.height(44)
        forgotPasswordEmailTextField.topToBottom(of: self.forgotPasswordSubTitle, offset: 20.0)
        forgotPasswordEmailTextField.left(to: self.forgotPasswordSubTitle)
        forgotPasswordEmailTextField.right(to: self.forgotPasswordSubTitle)
        
        self.containerView.addSubview(submitButton)
        submitButton.height(44)
        submitButton.topToBottom(of: self.forgotPasswordEmailTextField, offset: 20.0)
        submitButton.left(to: self.forgotPasswordSubTitle)
        submitButton.right(to: self.forgotPasswordSubTitle)
    }
}

//MARK: - @ojbc Functions
extension EmailSignInViewController {
    @objc private func didTapSignIn(_ sender: UIButton) {
        print(#function)
    }
    
    @objc private func didTapSubmit(_ sender: UIButton) {
        print(#function)
    }
    
    @objc private func keepUserLoggedIn(_ sender: UIButton) {
        print(#function)
        //Store in User Defaults
        self.animateRememberButton(sender)
    }
    
    @objc private func didTapForgotPassword(_ sender: UIButton) {
        print(#function)
        self.animateForgotPasswordViews()
        self.forgotPasswordEmailTextField.resignFirstResponder()
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
}


//MARK: - TextField Delegate
extension EmailSignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            scrollView.setContentOffset(.zero, animated: true)
        }
        return false
    }
}


//MARK: - Tap Anywhere To Dismiss Keyboard
extension EmailSignInViewController {
    private func dismissKeyboardTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
}


//MARK: - Adjust Scrollview for Keyboard
extension EmailSignInViewController {
    private func observeForKeyboard() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
}


//MARK: - Animations
extension EmailSignInViewController {
    private func animateForgotPasswordViews() {
        UIView.animate(withDuration: 0.85) {
            if self.forgotPassword == false {
                self.forgotPasswordButton.tintColor = .dsGrey
                self.forgotPassword = true
                
                self.forgotPasswordSubTitle.layer.opacity = 1.0
                self.forgotPasswordEmailTextField.layer.opacity = 1.0
                self.submitButton.layer.opacity = 1.0
            } else if self.forgotPassword == true {
                self.forgotPasswordButton.tintColor = .textFieldBackground
                self.forgotPassword = false
                
                self.forgotPasswordSubTitle.layer.opacity = 0.0
                self.forgotPasswordEmailTextField.layer.opacity = 0.0
                self.submitButton.layer.opacity = 0.0
            }
        }
    }
    
    private func animateRememberButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.85) {
            if self.rememberUser == false {
                sender.backgroundColor = .systemGreen
                self.rememberUser = true
            } else {
                sender.backgroundColor = .textFieldBackground
                self.rememberUser = false
            }
        }
    }
}
