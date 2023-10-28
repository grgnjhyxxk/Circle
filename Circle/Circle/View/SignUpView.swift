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
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)

        return label
    }
    
    func subTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = ""
        label.textColor = UIColor.white.withAlphaComponent(0.75)
        label.font = UIFont.systemFont(ofSize: 14, weight: .ultraLight)
        
        return label
    }
    
    func mainTextField() -> UITextField {
        let textField = UITextField()
        
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = UIColor.white
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .whileEditing

        return textField
    }
    
    func mainTextView() -> UITextView {
        let textView = UITextView()
        
        textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        return textView
    }
    
    func checkButton() -> UIButton {
        let button = UIButton()
        
        button.setTitle("인증", for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
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
