//
//  AuthController.swift
//  Shelves
//
//  Created by Мявкo on 11.09.23.
//

import UIKit

class AuthController: UIViewController {
    
    private let model = AuthModel(email: "", password: "")
    private let authView = AuthView()
    
    private var passwordIsVisible = false
    
    override func loadView() {
        super.loadView()
        self.view = authView
        authView.delegate = self
    }
    
    func toggleEyeColor() -> UIColor {
        passwordIsVisible.toggle()
        return passwordIsVisible ? .systemBlue : .black
    }
}

extension AuthController: AuthViewDelegate {
    func togglePasswordVisibility() -> UIColor {
        return toggleEyeColor()
    }
}
