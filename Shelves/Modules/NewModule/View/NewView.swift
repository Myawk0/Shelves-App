//
//  NewViewController.swift
//  Shelves
//
//  Created by Мявкo on 15.09.23.
//

import UIKit

class NewView: UIView {
    
    // MARK: - StackView
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    // MARK: - Labels
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method to apply a text for "Login"
    
    func setupLogin(with text: String) {
        loginLabel.text = "Login: \(text)"
    }
    
    // MARK: - Method to apply a text for "Password"
    
    func setupPassword(with text: String) {
        passwordLabel.text = "Password: \(text)"
    }
    
    // MARK: - Subviews
    
    private func addSubviews() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(loginLabel)
        verticalStackView.addArrangedSubview(passwordLabel)
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
