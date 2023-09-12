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
}

// MARK: - AuthViewDelegate

extension AuthController: AuthViewDelegate {
    func togglePasswordVisibility() -> UIColor {
        return toggleEyeColor()
    }
}
