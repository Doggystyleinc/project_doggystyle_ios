//
//  EmailSignUpViewController.swift
//  Project Doggystyle
//
//  Created by Stanley Miller on 5/4/21.
//

import UIKit

final class EmailSignUpViewController: UIViewController {
    private var didAgreeToTerms = false
    private let verticalPadding: CGFloat = 30.0
    private var scrollView = UIScrollView(frame: .zero)
    private let containerView = UIView(frame: .zero)
    
    private let signUpTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.robotoBold(size: 24)
        label.text = "Email Sign up"
        label.textColor = .headerColor
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .headerColor
        button.addTarget(self, action: #selector(dismissVC(_:)), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .textFieldBackground
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private let mobileTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .textFieldBackground
        textField.placeholder = "Mobile Number"
        textField.keyboardType = .phonePad
        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .textFieldBackground
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.textContentType = .oneTimeCode
        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private let confirmPWTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .textFieldBackground
        textField.placeholder = "Confirm Password"
        textField.isSecureTextEntry = true
        textField.textContentType = .oneTimeCode
        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private let referralTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .textFieldBackground
        textField.placeholder = "Referral Code"
        return textField
    }()
    
    private let emailErrorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .errorColor
        label.font = UIFont.robotoRegular(size: 14)
        return label
    }()
    
    private let mobileErrorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .errorColor
        label.font = UIFont.robotoRegular(size: 14)
        return label
    }()
    
    private let confirmPWErrorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .errorColor
        label.font = UIFont.robotoRegular(size: 14)
        return label
    }()
    
    private let termsTitle: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = false
        button.setTitle("Agree with", for: .normal)
        button.setTitleColor(.textColor, for: .normal)
        button.titleLabel?.font = UIFont.robotoRegular(size: 16)
        return button
    }()
    
    private let termsLink: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Terms and Conditions", for: .normal)
        button.addTarget(self, action: #selector(didTapTerms(_:)), for: .touchUpInside)
        return button
    }()
    
    private let agreeToTermsButton: UIButton = {
        let button = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        button.tintColor = .white
        button.backgroundColor = .textFieldBackground
        button.setImage(UIImage(systemName: "checkmark", withConfiguration: imageConfig), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 3, bottom: 5, right: 4)
        button.addTarget(self, action: #selector(agreeToTerms(_:)), for: .touchUpInside)
        return button
    }()
    
    private let dividerView = DividerView()
    private let signUpButton: DSButton = {
       let button = DSButton(titleText: "sign up", backgroundColor: .dsGrey, titleColor: .white)
        button.addTarget(self, action: #selector(didTapSignUp(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        observeForKeyboard()
        dismissKeyboardTapGesture()
        addTitleViews()
        addScrollView()
        addTextFields()
        addTermsViews()
        addSignUpButton()
    }
}

//MARK: - Configure Title Message
extension EmailSignUpViewController {
    private func addTitleViews() {
        self.view.addSubview(signUpTitle)
        signUpTitle.top(to: self.view, offset: 80.0)
        signUpTitle.left(to: self.view, offset: verticalPadding)
        
        self.view.addSubview(dividerView)
        dividerView.height(0.5)
        dividerView.topToBottom(of: self.signUpTitle, offset: 20.0)
        dividerView.left(to: self.view, offset: verticalPadding)
        dividerView.right(to: self.view, offset: -verticalPadding)
        
        self.view.addSubview(closeButton)
        closeButton.height(60)
        closeButton.width(60)
        closeButton.top(to: self.view, offset: 5.0)
        closeButton.right(to: self.view, offset: -5.0)
    }
}

//MARK: - Configure Scroll Views
extension EmailSignUpViewController {
    private func addScrollView() {
        self.view.addSubview(scrollView)
        scrollView.topToBottom(of: dividerView)
        scrollView.left(to: self.view, offset: verticalPadding)
        scrollView.right(to: self.view, offset: -verticalPadding)
        scrollView.height(350)
        
        self.scrollView.addSubview(containerView)
        containerView.edgesToSuperview()
        containerView.width(to: self.scrollView)
        containerView.height(420)
    }
}

//MARK: - Configure Text Fields
extension EmailSignUpViewController {
    private func addTextFields() {
        self.passwordTextField.enablePasswordToggle()
        self.confirmPWTextField.enablePasswordToggle()
        
        self.containerView.addSubview(emailTextField)
        emailTextField.top(to: self.containerView, offset: 30.0)
        emailTextField.height(44.0)
        emailTextField.left(to: self.containerView)
        emailTextField.right(to: self.containerView)
        
        self.containerView.addSubview(emailErrorLabel)
        emailErrorLabel.topToBottom(of: emailTextField, offset: 5)
        emailErrorLabel.left(to: self.containerView, offset: 5)
        
        self.containerView.addSubview(mobileTextField)
        mobileTextField.topToBottom(of: self.emailErrorLabel, offset: 20.0)
        mobileTextField.height(44.0)
        mobileTextField.left(to: self.containerView)
        mobileTextField.right(to: self.containerView)
        
        self.containerView.addSubview(mobileErrorLabel)
        mobileErrorLabel.topToBottom(of: mobileTextField, offset: 5)
        mobileErrorLabel.left(to: self.containerView, offset: 5)
        
        self.containerView.addSubview(passwordTextField)
        passwordTextField.topToBottom(of: self.mobileErrorLabel, offset: 20.0)
        passwordTextField.height(44.0)
        passwordTextField.left(to: self.containerView)
        passwordTextField.right(to: self.containerView)
        
        self.containerView.addSubview(confirmPWTextField)
        confirmPWTextField.topToBottom(of: self.passwordTextField, offset: 20.0)
        confirmPWTextField.height(44.0)
        confirmPWTextField.left(to: self.containerView)
        confirmPWTextField.right(to: self.containerView)
        
        self.containerView.addSubview(confirmPWErrorLabel)
        confirmPWErrorLabel.topToBottom(of: confirmPWTextField, offset: 5)
        confirmPWErrorLabel.left(to: self.containerView, offset: 5)
        
        self.containerView.addSubview(referralTextField)
        referralTextField.topToBottom(of: self.confirmPWErrorLabel, offset: 20.0)
        referralTextField.height(44.0)
        referralTextField.left(to: self.containerView)
        referralTextField.right(to: self.containerView)
    }
}

//MARK: - Configure Terms and Conditions
extension EmailSignUpViewController {
    private func addTermsViews() {
        self.view.addSubview(termsTitle)
        termsTitle.topToBottom(of: self.scrollView)
        termsTitle.left(to: self.scrollView)
        
        self.view.addSubview(termsLink)
        termsLink.top(to: termsTitle)
        termsLink.leftToRight(of: termsTitle, offset: 5.0)
        
        self.view.addSubview(agreeToTermsButton)
        agreeToTermsButton.centerY(to: termsLink)
        agreeToTermsButton.right(to: self.scrollView, offset: -11)
        agreeToTermsButton.height(22)
        agreeToTermsButton.width(22)
    }
}

//MARK: - Configure Sign Up Button
extension EmailSignUpViewController {
    private func addSignUpButton() {
        self.view.addSubview(signUpButton)
        signUpButton.topToBottom(of: termsTitle, offset: 80)
        signUpButton.height(44)
        signUpButton.left(to: self.view, offset: verticalPadding)
        signUpButton.right(to: self.view, offset: -verticalPadding)
    }
}

//MARK: - Adjust Scrollview for Keyboard
extension EmailSignUpViewController {
    private func observeForKeyboard() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
}

//MARK: - @objc Functions
extension EmailSignUpViewController {
    @objc private func dismissVC(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc private func agreeToTerms(_ sender: UIButton) {
        print(#function)
        
        if didAgreeToTerms == false {
            sender.backgroundColor = .systemGreen
            didAgreeToTerms = true
        } else {
            sender.backgroundColor = .textFieldBackground
            didAgreeToTerms = false
        }
    }
    
    @objc private func didTapTerms(_ sender: UIButton) {
        print(#function)
    }
    
    @objc private func didTapSignUp(_ sender: UIButton) {
        print(#function)
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

//MARK: - TextField
extension EmailSignUpViewController: UITextFieldDelegate {
    @objc private func textDidChange(_ sender: UITextField) {
        
        guard let emailText = emailTextField.text else { return }
        emailErrorLabel.text = emailText.isValidEmail ? "" : "Invalid Email"
        emailErrorLabel.isHidden = emailText.isValidEmail ? true : false
        
        guard let mobileNumber = mobileTextField.text else { return }
        mobileErrorLabel.text = mobileNumber.isValidPhoneNumber ? "" : "Required Field"
        mobileErrorLabel.isHidden = mobileNumber.isValidPhoneNumber ? true : false
        
        guard let passwordText = passwordTextField.text else { return }
        
        if passwordText != confirmPWTextField.text {
            confirmPWErrorLabel.text = "Passwords Do Not Match"
            confirmPWErrorLabel.isHidden = false
        } else {
            confirmPWErrorLabel.isHidden = true
            confirmPWErrorLabel.text = ""
        }
    }
}

//MARK: - Tap Anywhere To Dismiss Keyboard
extension EmailSignUpViewController {
    private func dismissKeyboardTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
}
