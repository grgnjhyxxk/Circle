//
//  AccountEmailViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/17/23.
//

import UIKit
import SnapKit

class AccountEmailViewController: BaseSignUpViewController {
    
    override func uiViewUpdate() {
        mainTitleLabel.text = mainTitleLabelList[3]
        subTitleLabel.text = subTitleLabelList[3]
        mainTextField.placeholder = mainTextFieldList[4]
        errorTextLabel.text = errorTextLabelList[3]
    }
    
    override func nextButtonAction() {
        if let mainTextField = self.mainTextField.text, mainTextField.isEmpty {
            self.mainTextField.layer.borderWidth = 1.0
            self.mainTextField.layer.borderColor = UIColor.red.cgColor
            AnimationView().shakeView(self.mainTextField)
            
        } else {
            
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == mainTextField, let mainTextField = self.mainTextField.text {
            
            let currentText = (mainTextField) as NSString
            let updatedText = currentText.replacingCharacters(in: range, with: string)
            
            if validateEmail(email: updatedText) {
                print("유효한 이메일 주소입니다.")
                
                self.mainTextField.layer.borderWidth = 0.5
                self.mainTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
                errorTextLabel.alpha = 0
                
            } else {
                print("유효하지 않은 이메일 주소입니다.")
                
                self.mainTextField.layer.borderWidth = 1.0
                self.mainTextField.layer.borderColor = UIColor.red.cgColor
                
                errorTextLabel.alpha = 1
            }
        }
        
        return true
    }
}
