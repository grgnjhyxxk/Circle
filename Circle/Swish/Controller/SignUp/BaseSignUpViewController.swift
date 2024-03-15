//
//  SignUpViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/16/23.
//

import UIKit
import SnapKit

class BaseSignUpViewController: UIViewController, UITextFieldDelegate {
    
    var profileNameInput: String?
    var userNameInput: String?
    
    var viewList: [UIView] = []
    var mainTitleLabelList: [String] = ["프로필 이름", "사용자 이름", "계정 비밀번호", "계정 이메일"]
    var subTitleLabelList: [String] = ["서클에서 대표로 보이게될 프로필 활동명입니다.\n추후에도 변경이 가능합니다.",
                                                   "서클에서 자신이 누군지 명확하게 보여줄 이름입니다.\n추후에 제한적으로 변경이 가능합니다.",
                                                   "로그인과 몇가지 설정과 인증을 위해 사용하는\n사용자 계정 비밀번호입니다.",
                                                   "사용자 계정 복구와 뉴스레터, 각종 업데이트 소식을\n정기적으로 수신할 수 있는 수단입니다."]
    var mainTextFieldList: [String] = ["프로필 이름", "이름", "비밀번호", "비밀번호 재입력", "이메일"]
    var errorTextLabelList: [String] = ["프로필 이름은 영문자(A-Z)와 숫자(0-9), 언더바(_)와 마침표(.)만을 조합하여 만들 수 있습니다.",
                                                    "",
                                                    "입력하신 비밀번호가 정확하지 않습니다.",
                                                    "유효하지 않은 이메일 형식입니다."]
    
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"

    var mainTitleLabel: UILabel = SignUpView().mainTitleLabel()
    var subTitleLabel: UILabel = SignUpView().subTitleLabel()
    var errorTextLabel: UILabel = SystemView().errorTextLabel()
    
    var mainTextField: UITextField = SignUpView().mainTextField()
    var checkTextField: UITextField = SignUpView().mainTextField()
    
    let sendEmailVerificationButton: UIButton = SignUpView().checkButton()
    let verifyCodeButton: UIButton = SignUpView().checkButton()

    let mainTextFieldBlurView: UIView = SignUpView().blurView()
    let checkTextFieldBlurView: UIView = SignUpView().blurView()
    
    let activityIndicator: UIActivityIndicatorView = SystemView().activityIndicator()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        navigationItemSetting()
        addOnView()
        viewLayout()
        errorTextLabelLayout()
        navigationBarLayout()
        uiViewUpdate()
        mainViewSetting()
        addTargets()
        
        mainTextField.delegate = self
        checkTextField.delegate = self
    }
    
    func addOnView() {
        viewList = [mainTitleLabel, subTitleLabel, mainTextField, checkTextField, errorTextLabel, sendEmailVerificationButton, verifyCodeButton, mainTextFieldBlurView, checkTextFieldBlurView]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }
    
    func viewLayout() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
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
            make.size.equalTo(CGSize(width: 340, height: 40))
        }
    }
    
    func navigationBarLayout() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), style: .done, target: self, action: #selector(backButtonAction))
        
        backButton.tintColor = UIColor.white
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "회원가입"
    }
    
    func validateEmail(email: String) -> Bool {
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func errorTextLabelLayout() {

    }
    
    func uiViewUpdate() {
        
    }
    
    func mainViewSetting() {
        
    }
    
    func navigationItemSetting() {

    }
    
    func addTargets() {
        
    }
    
    @objc func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func nextButtonAction() {
        
    }
}
