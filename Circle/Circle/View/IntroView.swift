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
        
        let image = UIImage(systemName: "chevron.left.2")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .thin))
        
//        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 1, bottom: 4, right: 0)

        button.setImage(image, for: .normal)
        button.tintColor = UIColor.white.withAlphaComponent(1)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        button.layer.cornerRadius = 30
        
        return button
    }

    
    func introMainTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "Circle"
        label.textColor = UIColor.white
        label.font = UIFont(name: "PetitFormalScript-Regular", size: 52)

        return label
    }
    
    func introSubTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "너와 나, 연결의 시작. 여기 서클에서"
        label.textColor = UIColor.white.withAlphaComponent(0.75)
        label.font = UIFont(name: "NotoSans-ExtraLight", size: 15)
        
        return label
    }
    
    func idTextField() -> UITextField {
        let textField = UITextField()
        
        textField.placeholder = "사용자 이름 또는 이메일"
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

    func passwordTextField() -> UITextField {
        let textField = UITextField()
        
        textField.placeholder = "비밀번호"
        textField.font = UIFont(name: "NotoSans-ExtraLight", size: 15)
        textField.textColor = UIColor.white
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        
        return textField
    }
    
    func separator() -> UIView {
        let separatorView = UIView()
        
        separatorView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        
        return separatorView
    }
    
    func separatorTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "또는"
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        label.font = UIFont(name: "NotoSans-ExtraLight", size: 13.5)
        
        return label
    }
    
    func registerButton() -> UIButton {
        let button = UIButton()
        
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.85), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        if let image = UIImage(systemName: "chevron.right")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 14, weight: .light)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.white.withAlphaComponent(0.85)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4.5, bottom: 0, right: 0)
        button.semanticContentAttribute = .forceRightToLeft
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .leading

        return button
    }
    
    func recoverCredentialsButton() -> UIButton {
        let button = UIButton()
        
        button.setTitle("로그인 문제 해결", for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.85), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)

        if let image = UIImage(systemName: "chevron.right")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 14, weight: .light)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.white.withAlphaComponent(0.85)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4.5, bottom: 0, right: 0)
        button.semanticContentAttribute = .forceRightToLeft
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .leading
        
        return button
    }
}
