//
//  AccountPasswordViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/17/23.
//

import UIKit
import SnapKit

class AccountPasswordViewController: BaseSignUpViewController {
    
    override func errorTextLabelLayout() {
        errorTextLabel.snp.makeConstraints { make in
            make.top.equalTo(checkTextField.snp.bottom).offset(15)
            make.leading.equalTo(checkTextField)
            make.trailing.equalToSuperview()
        }
        
        errorTextLabel.alpha = 0
    }
    
    override func uiViewSetting() {
        mainTextField.isSecureTextEntry = true
        checkTextField.alpha = 1
        
        nextButton.title = "완료"
    }
    
    override func uiViewUpdate() {
        mainTitleLabel.text = mainTitleLabelList[2]
        subTitleLabel.text = subTitleLabelList[2]
        mainTextField.placeholder = mainTextFieldList[2]
        checkTextField.placeholder = mainTextFieldList[3]
        errorTextLabel.text = errorTextLabelList[2]
    }
    
    override func nextButtonAction() {
        if let mainTextField = self.mainTextField.text, mainTextField.isEmpty {
            self.mainTextField.layer.borderWidth = 1.0
            self.mainTextField.layer.borderColor = UIColor.red.cgColor
            AnimationView().shakeView(self.mainTextField)
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_!@#$%^&*()-+=[]{}|;:',.<>?")
        let characterSet = CharacterSet(charactersIn: string)
        
        if allowedCharacters.isSuperset(of: characterSet) {
            print("올바른 문자입니다.")
            
            if textField == mainTextField {
                self.mainTextField.layer.borderWidth = 0.5
                self.mainTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor

            } else {
                self.checkTextField.layer.borderWidth = 0.5
                self.checkTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
            }
        } else {
            print("잘못된 문자입니다.")
            
            if textField == mainTextField {
                self.mainTextField.layer.borderWidth = 2
                self.mainTextField.layer.borderColor = UIColor.red.cgColor
                AnimationView().shakeView(self.mainTextField)

            } else {
                self.checkTextField.layer.borderWidth = 2
                self.checkTextField.layer.borderColor = UIColor.red.cgColor
                AnimationView().shakeView(self.checkTextField)
            }
        }
        
        if textField == checkTextField, let mainTextField = self.mainTextField.text, let checkTextField = (checkTextField.text as NSString?)?.replacingCharacters(in: range, with: string), mainTextField == checkTextField {
            print("비밀번호가 일치합니다.")
            
            self.checkTextField.layer.borderWidth = 0.5
            self.checkTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
            
            self.errorTextLabel.alpha = 0
            
            nextButton.isEnabled = true

        } else if textField == checkTextField, let mainTextField = self.mainTextField.text, let checkTextField = (checkTextField.text as NSString?)?.replacingCharacters(in: range, with: string), mainTextField != checkTextField  {
            print("비밀번호가 일치하지 않습니다.")
            
            self.checkTextField.layer.borderWidth = 1.0
            self.checkTextField.layer.borderColor = UIColor.red.cgColor
            
            self.errorTextLabel.alpha = 1
        }
        
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
