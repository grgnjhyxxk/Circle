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
    
    override func nextButtonAction() {
        if let mainTextField = self.mainTextField.text, mainTextField.isEmpty {
            self.mainTextField.layer.borderWidth = 1.0
            self.mainTextField.layer.borderColor = UIColor.red.cgColor
            AnimationView().shakeView(self.mainTextField)
            
        } else {
            let viewController = AccountPasswordViewController()
            
            errorTextLabel.alpha = 0

            if let navigationController = self.view.window?.rootViewController as? UINavigationController {
                navigationController.pushViewController(viewController, animated: true)
            }
        }
    }
}
