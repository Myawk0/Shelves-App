//
//  AuthController.swift
//  Shelves
//
//  Created by Мявкo on 11.09.23.
//

import UIKit

class AuthController: UIViewController {
    
    private let authView: AuthView
    private let model = AuthModel.loginData
    
    private var passwordIsVisible: Bool
    
    // MARK: - Init
    
    init(passwordIsVisible: Bool = false) {
        self.authView = AuthView()
        self.passwordIsVisible = passwordIsVisible
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Appoint authView as view
    
    override func loadView() {
        super.loadView()
        self.view = authView
        authView.delegate = self
    }
    
    // MARK: - Change "eye" color, when password change visibility
    
    private func toggleEyeColor() -> UIColor {
        passwordIsVisible.toggle()
        return passwordIsVisible ? .systemBlue : .black
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Za-z0-9]+@+[A-Za-z]+\\.[A-Za-z]+"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@#&?!])[A-Za-z\\d@#&?!]{8,20}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
}

// MARK: - AuthViewDelegate

extension AuthController: AuthViewDelegate {
    func checkValidation(email: String, password: String) -> Bool {
        return isValidEmail(email) && isValidPassword(password)
    }
    
    func togglePasswordVisibility() -> UIColor {
        return toggleEyeColor()
    }
}
