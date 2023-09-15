//
//  NewViewController.swift
//  Shelves
//
//  Created by Мявкo on 15.09.23.
//

import UIKit

class NewView: UIView {
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLogin(with text: String) {
        loginLabel.text = "Login: \(text)"
    }
    
    func setupPassword(with text: String) {
        passwordLabel.text = "Password: \(text)"
    }
    
    private func addSubviews() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(loginLabel)
        verticalStackView.addArrangedSubview(passwordLabel)
    }
    
    private func applyConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
