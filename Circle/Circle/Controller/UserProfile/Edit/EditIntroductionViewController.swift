//
//  EditIntroductionViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/27/23.
//

import UIKit
import SnapKit

class EditIntroductionViewController: BasicEditViewController {
    lazy var nextButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(nextButtonAction))
        button.isEnabled = false
        return button
    }()
    
    override func uiViewUpdate() {
        mainTextView.text = SharedProfileModel.myProfile.introduction
        mainTextField.isHidden = true
        mainTextView.isHidden = false
        updateMainTextViewHeight()
    }
    
    override func navigationItemSetting() {
        navigationItem.rightBarButtonItem = nextButton
        navigationItem.title = "자기소개"
    }
    
    override func nextButtonAction() {
        if let userID = SharedProfileModel.myProfile.userID, let newIntroduction = mainTextView.text, let profileName = SharedProfileModel.myProfile.profileName {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicator)
            self.activityIndicator.startAnimating()
            updateProfile(field: "introduction", userID: userID, updateData: newIntroduction) { error in
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
    
    override func updateMainTextViewHeight() {
        super.updateMainTextViewHeight()
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let updatedText = (textView.text as NSString?)?.replacingCharacters(in: range, with: text) ?? ""
        
        nextButton.isEnabled = (0...150).contains(updatedText.count) && SharedProfileModel.myProfile.introduction != updatedText
        
        return true
    }
}
