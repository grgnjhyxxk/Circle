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
        
        errorTextLabel.isHidden = true
    }
    
    override func uiViewSetting() {
        mainTextField.isSecureTextEntry = true
        checkTextField.isHidden = false
        
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
            if let profileData = profileNameInput, let userNameData = userNameInput, let passwordData = mainTextField.text {
                let userData = UserData(profileName: profileData, userName: userNameData, password: passwordData, myCircleDigits: 0, inTheCircleDigits: 0, feedDigits: 0, followerDigits: 0, followingDigits: 0, socialValidation: false)
                signUpDataUploadServer(userData: userData) { success, error in
                    if success {
                        print("데이터 추가 성공")
                        self.navigationController?.popToRootViewController(animated: true)
                    } else if let error = error {
                        print("데이터 추가 실패: \(error.localizedDescription)")
                    }
                }
            } else {
                
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_!@#$%^&*()-+=[]{}|;:',.<>?")
        let characterSet = CharacterSet(charactersIn: string)
        
        if allowedCharacters.isSuperset(of: characterSet) {
            if textField == mainTextField {
                self.mainTextField.layer.borderWidth = 0.5
                self.mainTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor

            } else {
                self.checkTextField.layer.borderWidth = 0.5
                self.checkTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
            }
        } else {
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
            let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""

            self.checkTextField.layer.borderWidth = 0.5
            self.checkTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
            
            self.errorTextLabel.isHidden = true
            
            nextButton.isEnabled = updatedText.count >= 6

        } else if textField == checkTextField, let mainTextField = self.mainTextField.text, let checkTextField = (checkTextField.text as NSString?)?.replacingCharacters(in: range, with: string), mainTextField != checkTextField  {
            
            self.checkTextField.layer.borderWidth = 1.0
            self.checkTextField.layer.borderColor = UIColor.red.cgColor
            
            self.errorTextLabel.isHidden = false
        }
        
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
