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
        label.font = UIFont(name: "NotoSans-Thin", size: 24)
        
        return label
    }
    
    func subTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont(name: "NotoSans-ExtraLight", size: 12)
        
        return label
    }
    
    func mainTextField() -> UITextField {
        let textField = UITextField()
        
        textField.font = UIFont(name: "NotoSans-ExtraLight", size: 13)
        textField.textColor = UIColor.white
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textField.layer.cornerRadius = 5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        
        return textField
    }
}
