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
            viewController.profileNameInput = mainTextField.text
            
            if let navigationController = self.view.window?.rootViewController as? UINavigationController {
                errorTextLabel.isHidden = true
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
            self.mainTextField.layer.borderWidth = 0.5
            self.mainTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
            
            self.errorTextLabel.isHidden = true
            
            nextButton.isEnabled = (3...21).contains(updatedText.count)
            
        } else {
            self.mainTextField.layer.borderWidth = 2
            self.mainTextField.layer.borderColor = UIColor.red.cgColor
            
            AnimationView().shakeView(self.mainTextField)
            
            self.errorTextLabel.isHidden = false
        }
        
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
