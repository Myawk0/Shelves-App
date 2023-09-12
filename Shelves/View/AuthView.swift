//
//  ViewController.swift
//  Shelves
//
//  Created by Мявкo on 11.09.23.
//

import UIKit
import SnapKit

protocol AuthViewDelegate: AnyObject {
    func togglePasswordVisibility() -> UIColor
}

class AuthView: UIView {
    
    weak var delegate: AuthViewDelegate?
    
    private lazy var titleLabel: UILabel = _titleLabel
    
    private lazy var emailTextField: UITextField = _emailTextField
    private lazy var emailIcon: UIImageView = _emailIcon
    
    private lazy var passwordTextField: UITextField = _passwordTextField
    private lazy var passwordIcon: UIImageView = _passwordIcon
    private lazy var showPasswordIcon: UIImageView = _showPasswordIcon
    
    private lazy var forgotPasswordButton: UIButton = _forgotPasswordButton
    private lazy var loginButton: UIButton = _loginButton
    
    private lazy var integrationStackView: UIStackView = _integrationStackView
    private lazy var leftLine: UIView = _leftLine
    private lazy var rightLine: UIView = _rightLine
    private lazy var loginUsingIntegrationLabel: UILabel = _loginUsingIntegrationLabel
    
    private lazy var loginWithGoogleButton: UIButton = _loginWithGoogleButton
    private lazy var googleIcon: UIImageView = _googleIcon
    
    private lazy var registrationStackView: UIStackView = _registrationStackView
    private lazy var notHaveAccountLabel: UILabel = _notHaveAccountLabel
    private lazy var registerButton: UIButton = _registerButton
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubviews()
        applyConstraints()
        setupShowPassword()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupShowPassword() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showPasswordIconTapped))
        showPasswordIcon.addGestureRecognizer(tapGesture)
    }
    
    @objc func showPasswordIconTapped() {
        let color = delegate?.togglePasswordVisibility()
        passwordTextField.isSecureTextEntry.toggle()
        showPasswordIcon.tintColor = color
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
        
        emailTextField.addSubview(emailIcon)
        addSubview(emailTextField)
        
        passwordTextField.addSubview(passwordIcon)
        passwordTextField.addSubview(showPasswordIcon)
        addSubview(passwordTextField)
        
        addSubview(forgotPasswordButton)
        addSubview(loginButton)
        
        integrationStackView.addArrangedSubview(leftLine)
        integrationStackView.addArrangedSubview(loginUsingIntegrationLabel)
        integrationStackView.addArrangedSubview(rightLine)
        addSubview(integrationStackView)
        
        loginWithGoogleButton.addSubview(googleIcon)
        addSubview(loginWithGoogleButton)
        
        registrationStackView.addArrangedSubview(notHaveAccountLabel)
        registrationStackView.addArrangedSubview(registerButton)
        addSubview(registrationStackView)
    }
    
    private func applyConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(250)
            make.leading.equalToSuperview().inset(23)
            make.trailing.greaterThanOrEqualToSuperview().inset(315)
        }
        
        emailIcon.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(23)
            make.height.equalTo(46)
        }
        
        passwordIcon.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
        
        showPasswordIcon.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(23)
            make.height.equalTo(46)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.trailing.equalTo(passwordTextField.snp.trailing)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(23)
            make.height.equalTo(52)
        }
        
        leftLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(121)
        }
        
        rightLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(121)
        }
        
        integrationStackView.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(23)
        }
        
        googleIcon.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
        
        loginWithGoogleButton.snp.makeConstraints { make in
            make.top.equalTo(integrationStackView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(23)
            make.height.equalTo(48)
        }
        
        registrationStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.leading.trailing.greaterThanOrEqualToSuperview().inset(50)
        }
    }
}

//extension AuthView: AuthControllerDelegate {
//    func togglePasswordVisibility(from controller: AuthController, eyeColor: UIColor) {
//        controller.delegate = self
//        passwordTextField.isSecureTextEntry.toggle()
//        showPasswordIcon.tintColor = eyeColor
//    }
//}

private extension AuthView {
    
    var _titleLabel: UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Войти"
        return label
    }
    
    // MARK: - TextFields
    
    var _emailIcon: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        return imageView
    }
    
    var _emailTextField: UITextField {
        let textField = UITextField()
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.grayColor]
        textField.attributedPlaceholder = NSAttributedString(string: "Введите электронную почту", attributes: placeholderAttributes)
        textField.layer.borderColor = UIColor.lightGrayColor.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(40)
        textField.setRightPaddingPoints(20)
        return textField
    }
    
    var _passwordIcon: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lock")
        return imageView
    }
    
    var _showPasswordIcon: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "showPassword")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
        imageView.isUserInteractionEnabled = true
        return imageView
    }
    
    var _passwordTextField: UITextField {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.grayColor
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Введите пароль", attributes: placeholderAttributes)
        textField.layer.borderColor = UIColor.lightGrayColor.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(40)
        textField.setRightPaddingPoints(20)
        return textField
    }
    
    // MARK: - Buttons "Forgot password" and "Login"
    
    var _forgotPasswordButton: UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Забыли пароль?", for: .normal)
        button.setTitleColor(.blueColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }
    
    var _loginButton: UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .blueColor
        button.layer.cornerRadius = 6
        //button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }
    
    // MARK: - Integration
    
    var _leftLine: UIView {
        let view = UIView()
        view.backgroundColor = .veryLightGrayColor
        return view
    }
    
    var _rightLine: UIView {
        let view = UIView()
        view.backgroundColor = .veryLightGrayColor
        return view
    }
    
    var _loginUsingIntegrationLabel: UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "Войти через"
        label.textColor = .grayColor
        label.textAlignment = .center
        return label
    }
    
    var _integrationStackView: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }
    
    var _googleIcon: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "google")
        return imageView
    }
    
    var _loginWithGoogleButton: UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить через google", for: .normal)
        button.setTitleColor(.blueColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .grayColorForButton
        button.layer.cornerRadius = 6
        return button
    }
    
    // MARK: - Registration panel
    
    var _registrationStackView: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        return stackView
    }
    
    var _notHaveAccountLabel: UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "Еще нет аккаунта?"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }
    
    var _registerButton: UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.blueColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }
}
