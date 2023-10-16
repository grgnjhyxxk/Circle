//
//  IntroView.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/11/23.
//

import UIKit

class IntroView: UIView {
    
    func startButton() -> UIButton {
        let button = UIButton()
        
        let image = UIImage(systemName: "chevron.left.2")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 25, weight: .ultraLight))
        
//        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 1, bottom: 4, right: 0)

        button.setImage(image, for: .normal)
        button.tintColor = UIColor.white.withAlphaComponent(0.75)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        button.layer.cornerRadius = 25
        
        return button
    }

    
    func introMainTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "Circle"
        label.textColor = UIColor.white
//        label.font = UIFont(name: "NotoSans-ExtraLight", size: 24)
        label.font = UIFont(name: "NotoSans-Thin", size: 24)

        return label
    }
    
    func introSubTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "Tranquility in abundance."
        label.textColor = UIColor.white
        label.font = UIFont(name: "NotoSans-ExtraLight", size: 14)
//        label.font = UIFont(name: "NotoSans-Thin", size: 14.5)
        
        return label
    }
    
    func idTextField() -> UITextField {
        let textField = UITextField()
        
        textField.font = UIFont(name: "NotoSans-ExtraLight", size: 13)
        textField.textColor = UIColor.white
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textField.layer.cornerRadius = 5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        
        return textField
    }

    func passwordTextField() -> UITextField {
        let textField = UITextField()
        
        textField.font = UIFont(name: "NotoSans-ExtraLight", size: 14)
        textField.textColor = UIColor.white
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textField.layer.cornerRadius = 5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        
        return textField
    }
    
    func separator() -> UIView {
        let separatorView = UIView()
        
        separatorView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        
        return separatorView
    }
    
    func registerButton() -> UIButton {
        let button = UIButton()
        
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSans-ExtraLight", size: 12)
        
        return button
    }
    
    func recoverCredentialsButton() -> UIButton {
        let button = UIButton()
        
        button.setTitle("Forgot your password?", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSans-ExtraLight", size: 12)
        
        return button
    }
}
