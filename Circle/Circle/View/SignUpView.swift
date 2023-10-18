//
//  SignUpView.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/16/23.
//

import UIKit

class SignUpView: UIView {
    
    func mainTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 32)
        
        return label
    }
    
    func subTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = ""
        label.textColor = UIColor.white.withAlphaComponent(0.75)
        label.font = UIFont(name: "NotoSans-ExtraLight", size: 14)
        
        return label
    }
    
    func mainTextField() -> UITextField {
        let textField = UITextField()
        
        textField.font = UIFont(name: "NotoSans-ExtraLight", size: 15)
        textField.textColor = UIColor.white
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        
        return textField
    }
    
    func errorTextLabel() -> UILabel {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 12.5)
        
        return label
    }
    
    func checkButton() -> UIButton {
        let button = UIButton()
        
        button.setTitle("인증", for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        
        return button
    }
    
    func blurView() -> UIView {
        let view = UIView()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 5

        return view
    }
}
