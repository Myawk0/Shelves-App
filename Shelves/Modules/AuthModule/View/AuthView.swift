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
    func checkValidation(email: String, password: String) -> Bool
    func signInAuthentication(completion: @escaping (Bool) -> Void)
    func signInGoogleAuthentication()
}

class AuthView: UIView {
    
    weak var delegate: AuthViewDelegate?
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 13
        stackView.distribution = .fill
        stackView.alignment = .lastBaseline
        return stackView
    }()
    
    // MARK: - Title
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Войти"
        return label
    }()
    
    // MARK: - TextField "Email"
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.grayColor]
        textField.attributedPlaceholder = NSAttributedString(string: "Введите электронную почту", attributes: placeholderAttributes)
        textField.spellCheckingType = .no
        textField.layer.borderColor = UIColor.lightGrayColor.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        let emailIcon = UIImage(named: "profile")
        textField.setLeftPaddingIcon(emailIcon, padding: 37)
        textField.setRightPaddingPoints(15)
        textField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        return textField
    }()
    
    // MARK: - TextField "Password"
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.grayColor
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Введите пароль", attributes: placeholderAttributes)
        textField.layer.borderColor = UIColor.lightGrayColor.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        let passwordIcon = UIImage(named: "lock")
        textField.setLeftPaddingIcon(passwordIcon, padding: 37)
        textField.setRightPaddingIcon(for: eyeIcon, padding: 37, with: eyeView)
        textField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var eyeView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var eyeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "showPassword")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
        imageView.contentMode = .center
        return imageView
    }()
    
    // MARK: - Buttons "Forgot password" and "Login"
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Забыли пароль?", for: .normal)
        button.setTitleColor(.blueColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .blueColor.withAlphaComponent(0.6)
        button.layer.cornerRadius = 6
        button.isEnabled = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var errorAlertLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "Неправильный логин или пароль"
        label.textColor = .systemRed
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    // MARK: - Integration Label with lines
    
    private lazy var integrationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var leftLine: UIView = {
        let view = UIView()
        view.backgroundColor = .ultraLightGrayColor
        return view
    }()
    
    private lazy var rightLine: UIView = {
        let view = UIView()
        view.backgroundColor = .ultraLightGrayColor
        return view
    }()
    
    private lazy var loginThroughLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "Войти через"
        label.textColor = .grayColor
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Integration Button
    
    private lazy var loginWithGoogleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить через google", for: .normal)
        button.setTitleColor(.blueColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .grayColorForButton
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(googleSignIn), for: .touchUpInside)
        return button
    }()
    
    private lazy var googleIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "google")
        return imageView
    }()
    
    // MARK: - Registration panel
    
    private lazy var registrationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var notHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "Еще нет аккаунта?"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.blueColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()
    
    // MARK: - Property to control validate data in textFields
    
    private lazy var isTextFieldCorrect: Bool = true {
        didSet {
            changeTextFieldAppearance(with: emailTextField)
            changeTextFieldAppearance(with: passwordTextField)
            errorAlertLabel.isHidden = isTextFieldCorrect
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupDelegates()
        addSubviews()
        applyConstraints()
        setupShowPassword()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Delegates
    
    private func setupDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: - Method when textField are edited
    
    @objc func textFieldsDidChange() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        isTextFieldCorrect = true
        
        if let isCorrect = delegate?.checkValidation(email: email, password: password) {
            loginButton.isEnabled = isCorrect
            loginButton.backgroundColor = isCorrect ? .blueColor : .blueColor.withAlphaComponent(0.6)
        }
    }
    
    // MARK: - Method of "Login with Google" button
    
    @objc func googleSignIn() {
        delegate?.signInGoogleAuthentication()
    }
    
    // MARK: - Method UITapGestureRecognizer
    // setup UITapGestureRecognizer for eye image
    
    private func setupShowPassword() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showPasswordIconTapped))
        eyeView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Method for "Eye" icon
    // change visibility of password and "eye" color
    
    @objc private func showPasswordIconTapped() {
        let color = delegate?.togglePasswordVisibility()
        passwordTextField.isSecureTextEntry.toggle()
        eyeIcon.tintColor = color
    }
    
    // MARK: - Method for changing apperance of textFields
    
    func changeTextFieldAppearance(with textField: UITextField) {
        textField.textColor = isTextFieldCorrect ? .black : .systemRed
        textField.layer.borderColor = isTextFieldCorrect ? UIColor.lightGrayColor.cgColor : UIColor.systemRed.cgColor
    }
    
    // MARK: - Method of "Login" button
    
    @objc private func loginButtonTapped() {
        delegate?.signInAuthentication { result in
            self.isTextFieldCorrect = result
        }
    }
    
    // MARK: - Subviews
    private func addSubviews() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        
        verticalStackView.addArrangedSubview(emailTextField)
        verticalStackView.addArrangedSubview(passwordTextField)
        
        verticalStackView.addArrangedSubview(forgotPasswordButton)
        verticalStackView.addArrangedSubview(loginButton)
        verticalStackView.addArrangedSubview(errorAlertLabel)
        
        integrationStackView.addArrangedSubview(leftLine)
        integrationStackView.addArrangedSubview(loginThroughLabel)
        integrationStackView.addArrangedSubview(rightLine)
        verticalStackView.addArrangedSubview(integrationStackView)
        
        loginWithGoogleButton.addSubview(googleIcon)
        verticalStackView.addArrangedSubview(loginWithGoogleButton)
        
        registrationStackView.addArrangedSubview(notHaveAccountLabel)
        registrationStackView.addArrangedSubview(registerButton)
        addSubview(registrationStackView)
    }
    
    // MARK: - Constraints
    private func applyConstraints() {
        
        verticalStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-40)
            make.leading.trailing.equalToSuperview().inset(23)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(46)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(46)
        }
        
        verticalStackView.setCustomSpacing(2, after: passwordTextField)
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(52)
        }
        
        verticalStackView.setCustomSpacing(8, after: loginButton)
        
        errorAlertLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        verticalStackView.setCustomSpacing(2, after: errorAlertLabel)
        
        leftLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            let width = UIScreen.main.bounds.width * 0.319
            make.width.equalTo(width)
        }
        
        rightLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            let width = UIScreen.main.bounds.width * 0.319
            make.width.equalTo(width)
        }
        
        integrationStackView.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        googleIcon.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
        
        loginWithGoogleButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        registrationStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(35)
            make.leading.trailing.greaterThanOrEqualToSuperview().inset(50)
        }
    }
}

extension AuthView: UITextFieldDelegate {
    
    // MARK: - Close keyboard when tap a button "Return"
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Close keyboard when tap on any place except textfield
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
}
