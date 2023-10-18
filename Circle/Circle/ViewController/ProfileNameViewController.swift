//
//  ProfileNameViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/17/23.
//

import UIKit
import SnapKit

class ProfileNameViewController: BaseSignUpViewController {
    
    override func uiViewUpdate() {
        mainTitleLabel.text = mainTitleLabelList[0]
        subTitleLabel.text = subTitleLabelList[0]
        mainTextField.placeholder = mainTextFieldList[0]
        errorTextLabel.text = errorTextLabelList[0]
    }
    
    override func nextButtonAction() {
        if let mainTextField = self.mainTextField.text, mainTextField.isEmpty {
            self.mainTextField.layer.borderWidth = 1.0
            self.mainTextField.layer.borderColor = UIColor.red.cgColor
            AnimationView().shakeView(self.mainTextField)
            
        } else {
            let viewController = UserNameViewController()
            
            if let navigationController = self.view.window?.rootViewController as? UINavigationController {
                errorTextLabel.alpha = 0
                mainTextField.layer.borderWidth = 0.5
                mainTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
                
                navigationController.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.")
        let characterSet = CharacterSet(charactersIn: string)
        
        if allowedCharacters.isSuperset(of: characterSet) {
            print("옳바른 문자입니다.")
            
            self.mainTextField.layer.borderWidth = 0.5
            self.mainTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
            
            self.errorTextLabel.alpha = 0
            
            nextButton.isEnabled = !updatedText.isEmpty
        } else {
            print("잘못된 문자입니다.")
            
            self.mainTextField.layer.borderWidth = 2
            self.mainTextField.layer.borderColor = UIColor.red.cgColor
            
            AnimationView().shakeView(self.mainTextField)
            
            self.errorTextLabel.alpha = 1
        }
        
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
