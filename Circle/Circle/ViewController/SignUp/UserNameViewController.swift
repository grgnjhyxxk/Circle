//
//  UserNameViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/17/23.
//

import UIKit
import SnapKit

class UserNameViewController: BaseSignUpViewController {
    lazy var nextButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "다음", style: .done, target: self, action: #selector(nextButtonAction))
        button.isEnabled = true
        return button
    }()
    
    override func uiViewUpdate() {
        mainTitleLabel.text = mainTitleLabelList[1]
        subTitleLabel.text = subTitleLabelList[1]
        mainTextField.placeholder = mainTextFieldList[1]
        errorTextLabel.text = errorTextLabelList[1]
    }
    
    override func navigationItemSetting() {
        navigationItem.rightBarButtonItem = nextButton
    }
    
    override func nextButtonAction() {
        let viewController = AccountPasswordViewController()
        viewController.profileNameInput = self.profileNameInput
        viewController.userNameInput = mainTextField.text
        
        show(viewController, sender: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        nextButton.isEnabled = (0...21).contains(updatedText.count) && SharedProfileModel.shared.userName != updatedText
        
        return true
    }
}
