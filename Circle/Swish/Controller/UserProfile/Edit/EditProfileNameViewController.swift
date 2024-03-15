//
//  EditProfileNameViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/26/23.
//

import UIKit
import SnapKit

class EditProfileNameViewController: BasicEditViewController {
    lazy var nextButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(nextButtonAction))
        button.isEnabled = false
        return button
    }()
    
    override func uiViewUpdate() {
        mainTextField.text = SharedProfileModel.myProfile.profileName
        errorTextLabel.text = errorTextLabelList[0]
    }
    
    override func errorTextLabelLayout() {
        errorTextLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTextField.snp.bottom).offset(15)
            make.leading.equalTo(mainTextField)
            make.trailing.equalToSuperview()
        }
    }

    override func navigationItemSetting() {
        navigationItem.rightBarButtonItem = nextButton
        navigationItem.title = "프로필 이름"
    }
    
    override func nextButtonAction() {
        checkIfProfileNameExists(mainTextField.text!) { (exists, error) in
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicator)
            self.activityIndicator.startAnimating()
            
            if exists {
                self.mainTextField.layer.borderWidth = 2
                self.mainTextField.layer.borderColor = UIColor.red.cgColor
                
                AnimationView().shakeView(self.mainTextField)
                
                self.errorTextLabel.isHidden = false
                self.errorTextLabel.text = "이미 사용 중인 프로필 이름입니다."
            } else {
                self.errorTextLabel.isHidden = true
                self.mainTextField.layer.borderWidth = 0.5
                self.mainTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
                
                if let userID = SharedProfileModel.myProfile.userID, let newProfileName = self.mainTextField.text {
                    updateProfile(field: "profileName", userID: userID, updateData: newProfileName) { error in
                        if error != nil {
                            print("error")
                        } else {
                            fetchUserData(profileName: "\(newProfileName)") { (error) in
                                if let error = error {
                                    print("Error: \(error.localizedDescription)")
                                }
                                DispatchQueue.main.async {
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ProfileUpdated"), object: nil)
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }
                        }
                    }
                }
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
