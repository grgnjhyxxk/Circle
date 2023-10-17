//
//  SignUpViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/16/23.
//

import UIKit
import SnapKit

class BaseSignUpViewController: UIViewController, UITextFieldDelegate {
    
    fileprivate var viewList: [UIView] = []
    fileprivate var mainTitleLabelList: [String] = ["프로필 이름", "사용자 이름", "계정 비밀번호", "계정 이메일"]
    fileprivate var subTitleLabelList: [String] = ["서클에서 대표로 보이게될 프로필 활동명입니다.\n추후에도 변경이 가능합니다.",
                                                   "서클에서 자신이 누군지 명확하게 보여줄 이름입니다.\n추후에 제한적으로 변경이 가능합니다.",
                                                   "로그인과 몇가지 설정과 인증을 위해 사용하는\n사용자 계정 비밀번호입니다.",
                                                   "사용자 계정 복구와 뉴스레터, 각종 업데이트 소식을\n정기적으로 수신할 수 있는 수단입니다."]
    fileprivate var mainTextFieldList: [String] = ["프로필 이름", "이름", "비밀번호", "비밀번호 재입력", "이메일"]
    fileprivate var errorTextLabelList: [String] = ["프로필 이름은 영문자(A-Z)와 숫자(0-9), 언더바(_)와 마침표(.)만을 조합하여 만들 수 있습니다.",
                                                    "",
                                                    "입력하신 비밀번호가 정확하지 않습니다.",
                                                    "유효하지 않은 이메일 형식입니다."]
    
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"

    fileprivate var mainTitleLabel: UILabel = SignUpView().mainTitleLabel()
    fileprivate var subTitleLabel: UILabel = SignUpView().subTitleLabel()
    fileprivate var errorTextLabel: UILabel = SignUpView().errorTextLabel()
    
    fileprivate var mainTextField: UITextField = SignUpView().mainTextField()
    fileprivate var checkTextField: UITextField = SignUpView().mainTextField()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        addOnView()
        viewLayout()
        errorTextLabelLayout()
        navigationBarLayout()
        uiViewUpdate()
        uiViewSetting()

        mainTextField.delegate = self
        checkTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
    }
    
    fileprivate func addOnView() {
        viewList = [mainTitleLabel, subTitleLabel, mainTextField, checkTextField, errorTextLabel]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }
    
    fileprivate func viewLayout() {
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
            make.centerX.equalToSuperview()
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 330, height: 40))
        }
        
        checkTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainTextField.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 330, height: 40))
        }
        
        checkTextField.alpha = 0
        checkTextField.isSecureTextEntry = true
    }
    
    fileprivate func errorTextLabelLayout() {
        errorTextLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTextField.snp.bottom).offset(15)
            make.leading.equalTo(mainTextField)
            make.trailing.equalToSuperview()
        }
        
        errorTextLabel.alpha = 0
    }
    
    fileprivate func navigationBarLayout() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonAction))
        let nextButton = UIBarButtonItem(title: "다음", style: .done, target: self, action: #selector(nextButtonAction))
        
        backButton.tintColor = UIColor.white
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = nextButton
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    fileprivate func validateEmail(email: String) -> Bool {
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    fileprivate func uiViewUpdate() {
        
    }
    
    fileprivate func uiViewSetting() {
        
    }
    
    @objc fileprivate func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func nextButtonAction() {
    }
}

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
            
            errorTextLabel.alpha = 0
            
            if let navigationController = self.view.window?.rootViewController as? UINavigationController {
                navigationController.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.")
        let characterSet = CharacterSet(charactersIn: string)
        
        if allowedCharacters.isSuperset(of: characterSet) {
            print("옳바른 문자입니다.")
            
            self.mainTextField.layer.borderWidth = 0.5
            self.mainTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
            
            self.errorTextLabel.alpha = 0

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

class AccountPasswordViewController: BaseSignUpViewController {
    
    override func errorTextLabelLayout() {
        errorTextLabel.snp.makeConstraints { make in
            make.top.equalTo(checkTextField.snp.bottom).offset(15)
            make.leading.equalTo(checkTextField)
            make.trailing.equalToSuperview()
        }
        
        errorTextLabel.alpha = 0
    }
    
    override func uiViewSetting() {
        mainTextField.isSecureTextEntry = true
        checkTextField.alpha = 1
    }
    
    override func uiViewUpdate() {
        mainTitleLabel.text = mainTitleLabelList[2]
        subTitleLabel.text = subTitleLabelList[2]
        mainTextField.placeholder = mainTextFieldList[2]
        checkTextField.placeholder = mainTextFieldList[3]
        errorTextLabel.text = errorTextLabelList[2]
    }
    
    override func nextButtonAction() {
        if let mainTextField = self.mainTextField.text, mainTextField.isEmpty {
            self.mainTextField.layer.borderWidth = 1.0
            self.mainTextField.layer.borderColor = UIColor.red.cgColor
            AnimationView().shakeView(self.mainTextField)
            
        } else {
            let viewController = AccountEmailViewController()
            
            errorTextLabel.alpha = 0

            if let navigationController = self.view.window?.rootViewController as? UINavigationController {
                navigationController.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_!@#$%^&*()-+=[]{}|;:',.<>?")
        let characterSet = CharacterSet(charactersIn: string)
        
        if allowedCharacters.isSuperset(of: characterSet) {
            print("올바른 문자입니다.")
            
            if textField == mainTextField {
                self.mainTextField.layer.borderWidth = 0.5
                self.mainTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor

            } else {
                self.checkTextField.layer.borderWidth = 0.5
                self.checkTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
            }
        } else {
            print("잘못된 문자입니다.")
            
            if textField == mainTextField {
                self.mainTextField.layer.borderWidth = 2
                self.mainTextField.layer.borderColor = UIColor.red.cgColor
                AnimationView().shakeView(self.mainTextField)

            } else {
                self.checkTextField.layer.borderWidth = 2
                self.checkTextField.layer.borderColor = UIColor.red.cgColor
                AnimationView().shakeView(self.checkTextField)
            }
        }
        
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == checkTextField, let mainTextField = self.mainTextField.text, let checkTextField = self.checkTextField.text, mainTextField == checkTextField{
            print("비밀번호가 일치합니다.")
            
            self.checkTextField.layer.borderWidth = 0.5
            self.checkTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
            
            self.errorTextLabel.alpha = 0
            
        } else if textField == checkTextField, let mainTextField = self.mainTextField.text, let checkTextField = self.checkTextField.text, mainTextField != checkTextField  {
            print("비밀번호가 일치하지 않습니다.")

            self.checkTextField.layer.borderWidth = 1.0
            self.checkTextField.layer.borderColor = UIColor.red.cgColor
            
            self.errorTextLabel.alpha = 1
        }
    }
}

class AccountEmailViewController: BaseSignUpViewController {
    
    override func uiViewUpdate() {
        mainTitleLabel.text = mainTitleLabelList[3]
        subTitleLabel.text = subTitleLabelList[3]
        mainTextField.placeholder = mainTextFieldList[4]
        errorTextLabel.text = errorTextLabelList[3]
    }
    
    override func nextButtonAction() {
        if let mainTextField = self.mainTextField.text, mainTextField.isEmpty {
            self.mainTextField.layer.borderWidth = 1.0
            self.mainTextField.layer.borderColor = UIColor.red.cgColor
            AnimationView().shakeView(self.mainTextField)
            
        } else {
            
        }
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
                
            } else {
                print("유효하지 않은 이메일 주소입니다.")
                
                self.mainTextField.layer.borderWidth = 1.0
                self.mainTextField.layer.borderColor = UIColor.red.cgColor
                
                errorTextLabel.alpha = 1
            }
        }
        
        return true
    }
}
