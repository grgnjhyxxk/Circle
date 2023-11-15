//
//  ProfileNameViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/17/23.
//

import UIKit
import SnapKit

class ProfileNameViewController: BaseSignUpViewController {
    lazy var nextButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "다음", style: .done, target: self, action: #selector(nextButtonAction))
        button.isEnabled = false
        return button
    }()
    
    override func uiViewUpdate() {
        mainTitleLabel.text = mainTitleLabelList[0]
        subTitleLabel.text = subTitleLabelList[0]
        mainTextField.placeholder = mainTextFieldList[0]
        errorTextLabel.text = errorTextLabelList[0]
    }
    
    override func navigationItemSetting() {
        navigationItem.rightBarButtonItem = nextButton
    }
    
    override func errorTextLabelLayout() {
        errorTextLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTextField.snp.bottom).offset(15)
            make.leading.equalTo(mainTextField)
            make.trailing.equalToSuperview()
        }
    }
    
    override func backButtonAction() {
        mainTextField.resignFirstResponder()
        navigationController?.popViewController(animated: true)
    }
    
    override func nextButtonAction() {
        checkIfProfileNameExists(mainTextField.text!) { (exists, error) in
            if exists {
                self.mainTextField.layer.borderWidth = 2
                self.mainTextField.layer.borderColor = UIColor.red.cgColor
                
                AnimationView().shakeView(self.mainTextField)
                
                self.errorTextLabel.isHidden = false
                self.errorTextLabel.text = "이미 사용 중인 프로필 이름입니다."
                
            } else {
                let viewController = UserNameViewController()
                viewController.profileNameInput = self.mainTextField.text
                
                self.errorTextLabel.isHidden = true
                self.mainTextField.layer.borderWidth = 0.5
                self.mainTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
                
                self.show(viewController, sender: nil)
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
            
            nextButton.isEnabled = (3...21).contains(updatedText.count) && SharedProfileModel.myProfile.profileName != updatedText
            
        } else {
            self.mainTextField.layer.borderWidth = 2
            self.mainTextField.layer.borderColor = UIColor.red.cgColor
            
            AnimationView().shakeView(self.mainTextField)
            
            self.errorTextLabel.isHidden = false
        }
        
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
