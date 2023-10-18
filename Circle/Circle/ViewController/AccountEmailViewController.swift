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

        checkTextField.alpha = 1
        
        mainTextField.isEnabled = true
        checkTextField.isEnabled = false
        
        mainTextFieldBlurView.isHidden = true
        checkTextFieldBlurView.isHidden = false
        
        sendEmailVerificationButton.isEnabled = false
        verifyCodeButton.isEnabled = false
        
        sendEmailVerificationButtonActiveDisable()
        verifyCodeButtonActiveDisable()
        
        nextButton.title = "완료"
    }
    
    override func nextButtonAction() {
        print("ㅇㅇ")
        if mainTextFieldBlurView.isHidden == false && checkTextFieldBlurView.isHidden == false {
            if let navigationController = self.view.window?.rootViewController as? UINavigationController {
                errorTextLabel.alpha = 0
                mainTextField.layer.borderWidth = 0.5
                mainTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
                
                navigationController.popToRootViewController(animated: true)
            }
        }
    }
    
    override func viewLayout() {
        view.backgroundColor = UIColor.black
        
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(10)
        }
        
        mainTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 260, height: 40))
        }
        
        sendEmailVerificationButton.snp.makeConstraints { make in
            make.leading.equalTo(mainTextField.snp.trailing).offset(10)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 60, height: 40))
        }
        
        checkTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.top.equalTo(mainTextField.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 260, height: 40))
        }
        
        verifyCodeButton.snp.makeConstraints { make in
            make.leading.equalTo(checkTextField.snp.trailing).offset(10)
            make.top.equalTo(sendEmailVerificationButton.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 60, height: 40))
        }
        
        mainTextFieldBlurView.snp.makeConstraints { make in
            make.leading.top.width.height.equalTo(mainTextField)
        }
        
        checkTextFieldBlurView.snp.makeConstraints { make in
            make.leading.top.width.height.equalTo(checkTextField)
        }
        
        verifyCodeButton.setTitle("확인", for: .normal)
    }
    
    override func errorTextLabelLayout() {
        errorTextLabel.snp.makeConstraints { make in
            make.top.equalTo(checkTextField.snp.bottom).offset(15)
            make.leading.equalTo(mainTextField)
            make.trailing.equalToSuperview()
        }
        
        errorTextLabel.alpha = 0
    }
    
    private func sendEmailVerificationButtonActiveEnable() {
        sendEmailVerificationButton.setTitleColor(UIColor.white.withAlphaComponent(1), for: .normal)
        sendEmailVerificationButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(1)
    }
    
    private func sendEmailVerificationButtonActiveDisable() {
        sendEmailVerificationButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
        sendEmailVerificationButton.backgroundColor = UIColor.white.withAlphaComponent(0.08)
    }
    
    private func verifyCodeButtonActiveEnable() {
        verifyCodeButton.setTitleColor(UIColor.white.withAlphaComponent(1), for: .normal)
        verifyCodeButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(1)
    }
    
    private func verifyCodeButtonActiveDisable() {
        verifyCodeButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
        verifyCodeButton.backgroundColor = UIColor.white.withAlphaComponent(0.08)
    }
    
    override func addTargets() {
        sendEmailVerificationButton.addTarget(self, action: #selector(sendEmailVerificationButtonAction), for: .touchUpInside)
        verifyCodeButton.addTarget(self, action: #selector(verifyCodeButtonAction), for: .touchUpInside)
    }
    
    @objc private func sendEmailVerificationButtonAction() {
        print("checkButtonAction")
        
        mainTextField.isEnabled = false
        checkTextField.isEnabled = true
        
        mainTextFieldBlurView.isHidden = false
        checkTextFieldBlurView.isHidden = true
        
        sendEmailVerificationButton.isEnabled = false
        
        sendEmailVerificationButtonActiveDisable()
    }
    
    @objc private func verifyCodeButtonAction() {
        print("verifyCodeButton")
        
        checkTextField.isEnabled = false
        checkTextFieldBlurView.isHidden = false
        
        verifyCodeButton.isEnabled = false
        
        verifyCodeButtonActiveDisable()
        
        nextButton.isEnabled = true
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
                
                sendEmailVerificationButton.isEnabled = true
                sendEmailVerificationButtonActiveEnable()
                
            } else {
                print("유효하지 않은 이메일 주소입니다.")
                
                self.mainTextField.layer.borderWidth = 1.0
                self.mainTextField.layer.borderColor = UIColor.red.cgColor
                
                errorTextLabel.alpha = 1
                
                sendEmailVerificationButton.isEnabled = false
                sendEmailVerificationButtonActiveDisable()
            }
        }
        
        if textField == checkTextField, let checkTextField = (checkTextField.text as NSString?)?.replacingCharacters(in: range, with: string), !checkTextField.isEmpty {
            
            verifyCodeButton.isEnabled = true
            verifyCodeButtonActiveEnable()
            
        } else {
            verifyCodeButton.isEnabled = false
            verifyCodeButtonActiveDisable()
        }
        
        return true
    }
}
