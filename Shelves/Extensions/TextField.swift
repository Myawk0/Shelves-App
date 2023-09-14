//
//  TextField.swift
//  Shelves
//
//  Created by Мявкo on 11.09.23.
//

import UIKit

extension UITextField {
    
    func setRightPaddingPoints(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.size.height))
        rightViewMode = .always
        rightView = paddingView
    }
    
    func setRightPaddingIcon(for imageView: UIImageView, padding: CGFloat, with outerView: UIView) {
        let frame = CGRect(x: 0, y: 0, width: padding, height: imageView.frame.height)
        
        imageView.frame = frame
        outerView.frame = frame
        outerView.addSubview(imageView)
        
        rightViewMode = .always
        rightView = outerView
    }
    
    func setLeftPaddingIcon(_ image: UIImage?, padding: CGFloat) {
        let frame = CGRect(x: 0, y: 0, width: padding, height: image!.size.height)
        
        let imageView = UIImageView(frame: frame)
        imageView.image = image
        imageView.contentMode = .center
        
        let outerView = UIView(frame: frame)
        outerView.addSubview(imageView)
        
        leftViewMode = .always
        leftView = outerView
    }
}
