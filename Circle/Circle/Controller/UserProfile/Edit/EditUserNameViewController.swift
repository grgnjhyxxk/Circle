//
//  EditUserNameViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/26/23.
//

import UIKit
import SnapKit

class EditUserNameViewController: BasicEditViewController {
    lazy var nextButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(nextButtonAction))
        button.isEnabled = false
        return button
    }()
    
    override func uiViewUpdate() {
        mainTextField.text = SharedProfileModel.myProfile.userName
    }
    
    override func navigationItemSetting() {
        navigationItem.rightBarButtonItem = nextButton
        navigationItem.title = "사용자 이름"
    }
    
    override func nextButtonAction() {
        if let userID = SharedProfileModel.myProfile.userID, let newUserName = mainTextField.text, let profileName = SharedProfileModel.myProfile.profileName {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicator)
            self.activityIndicator.startAnimating()
            updateProfile(field: "userName", userID: userID, updateData: newUserName) { error in
                if error != nil {
                    print("error")
                } else {
                    fetchUserData(profileName: "\(profileName)") { (error) in
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        nextButton.isEnabled = (0...21).contains(updatedText.count) && SharedProfileModel.myProfile.userName != updatedText
        
        return true
    }
}
