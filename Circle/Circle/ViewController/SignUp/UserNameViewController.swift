//
//  UserNameViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/17/23.
//

import UIKit
import SnapKit

class UserNameViewController: BaseSignUpViewController {
    
    override func uiViewUpdate() {
        mainTitleLabel.text = mainTitleLabelList[1]
        subTitleLabel.text = subTitleLabelList[1]
        mainTextField.placeholder = mainTextFieldList[1]
        errorTextLabel.text = errorTextLabelList[1]
    }
    
    override func navigationItemSetting() {
        nextButton.isEnabled = true
    }
    
    override func nextButtonAction() {
        let viewController = AccountPasswordViewController()
        viewController.profileNameInput = self.profileNameInput
        viewController.userNameInput = mainTextField.text
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
