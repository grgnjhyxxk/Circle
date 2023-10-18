//
//  SignUpViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/16/23.
//

import UIKit
import SnapKit

class BaseSignUpViewController: UIViewController, UITextFieldDelegate {
    
    internal var viewList: [UIView] = []
    internal var mainTitleLabelList: [String] = ["프로필 이름", "사용자 이름", "계정 비밀번호", "계정 이메일"]
    internal var subTitleLabelList: [String] = ["서클에서 대표로 보이게될 프로필 활동명입니다.\n추후에도 변경이 가능합니다.",
                                                   "서클에서 자신이 누군지 명확하게 보여줄 이름입니다.\n추후에 제한적으로 변경이 가능합니다.",
                                                   "로그인과 몇가지 설정과 인증을 위해 사용하는\n사용자 계정 비밀번호입니다.",
                                                   "사용자 계정 복구와 뉴스레터, 각종 업데이트 소식을\n정기적으로 수신할 수 있는 수단입니다."]
    internal var mainTextFieldList: [String] = ["프로필 이름", "이름", "비밀번호", "비밀번호 재입력", "이메일"]
    internal var errorTextLabelList: [String] = ["프로필 이름은 영문자(A-Z)와 숫자(0-9), 언더바(_)와 마침표(.)만을 조합하여 만들 수 있습니다.",
                                                    "",
                                                    "입력하신 비밀번호가 정확하지 않습니다.",
                                                    "유효하지 않은 이메일 형식입니다."]
    
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"

    internal var mainTitleLabel: UILabel = SignUpView().mainTitleLabel()
    internal var subTitleLabel: UILabel = SignUpView().subTitleLabel()
    internal var errorTextLabel: UILabel = SignUpView().errorTextLabel()
    
    internal var mainTextField: UITextField = SignUpView().mainTextField()
    internal var checkTextField: UITextField = SignUpView().mainTextField()
    
    internal let nextButton = UIBarButtonItem(title: "다음", style: .done, target: self, action: #selector(nextButtonAction))
    internal let sendEmailVerificationButton: UIButton = SignUpView().checkButton()
    internal let verifyCodeButton: UIButton = SignUpView().checkButton()

    internal let mainTextFieldBlurView: UIView = SignUpView().blurView()
    internal let checkTextFieldBlurView: UIView = SignUpView().blurView()

    override func viewDidLoad() {
        super .viewDidLoad()
        
        navigationItemSetting()
        addOnView()
        viewLayout()
        errorTextLabelLayout()
        navigationBarLayout()
        uiViewUpdate()
        uiViewSetting()
        addTargets()
        
        mainTextField.delegate = self
        checkTextField.delegate = self
        
        mainTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainTextField.becomeFirstResponder()
    }
    
    internal func addOnView() {
        viewList = [mainTitleLabel, subTitleLabel, mainTextField, checkTextField, errorTextLabel, sendEmailVerificationButton, verifyCodeButton, mainTextFieldBlurView, checkTextFieldBlurView]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }
    
    internal func viewLayout() {
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
    
    internal func errorTextLabelLayout() {
        errorTextLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTextField.snp.bottom).offset(15)
            make.leading.equalTo(mainTextField)
            make.trailing.equalToSuperview()
        }
        
        errorTextLabel.alpha = 0
    }
    
    internal func navigationBarLayout() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonAction))
        
        backButton.tintColor = UIColor.white
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = nextButton
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    internal func validateEmail(email: String) -> Bool {
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    internal func uiViewUpdate() {
        
    }
    
    internal func uiViewSetting() {
        
    }
    
    internal func navigationItemSetting() {
        nextButton.isEnabled = false
    }
    
    internal func addTargets() {
        
    }
    
    @objc internal func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc internal func nextButtonAction() {
        
    }
}
