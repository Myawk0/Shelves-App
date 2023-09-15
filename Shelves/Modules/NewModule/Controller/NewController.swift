//
//  NewController.swift
//  Shelves
//
//  Created by Мявкo on 15.09.23.
//

import UIKit

class NewController: UIViewController {
    
    private let newView: NewView
    
    init(email: String, password: String) {
        self.newView = NewView()

        newView.setupLogin(with: email)
        newView.setupPassword(with: password)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Appoint newView as view
    
    override func loadView() {
        super.loadView()
        self.view = newView
    }
    
    
}
