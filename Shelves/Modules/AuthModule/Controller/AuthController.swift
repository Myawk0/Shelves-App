//
//  AuthController.swift
//  Shelves
//
//  Created by Мявкo on 11.09.23.
//

import UIKit
import GoogleSignIn
import Firebase

class AuthController: UIViewController {
    
    private let authView: AuthView
    private var user: User?
    
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
    
    func signInAuth(completion: @escaping (Bool) -> Void) {
        guard let email = user?.email, let password = user?.password else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let _ = error {
                completion(false)
                return
            }
            
            guard let user = result?.user else {
                completion(false)
                return
            }
            
            completion(true)
            let controller = NewController(email: user.email!, password: password)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    private func setupGoogleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }
    
    func googleSignIn() {
        setupGoogleSignIn()
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            if let _ = error {
                print("Ошибка аутентификации через Google: \\(error.localizedDescription)")
                return
            }
            
            let email = result?.user.profile?.email
            let password = result?.user.userID
            
            let controller = NewController(email: email ?? "", password: password ?? "")
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

// MARK: - AuthViewDelegate

extension AuthController: AuthViewDelegate {
    func signInAuthentication(completion: @escaping (Bool) -> Void) {
        signInAuth { result in
            completion(result)
        }
    }
    
    func signInGoogleAuthentication() {
        googleSignIn()
    }
    
    func checkValidation(email: String, password: String) -> Bool {
        user = User(email: email, password: password)
        return isValidEmail(email) && isValidPassword(password)
    }
    
    func togglePasswordVisibility() -> UIColor {
        return toggleEyeColor()
    }
}
