//
//  BasicEditViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/27/23.
//

import UIKit
import SnapKit

class BasicEditViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var profileNameInput: String?
    var userNameInput: String?
    
    var viewList: [UIView] = []
    var navigationTitleStringList: [String] = ["프로필 이름", "사용자 이름", "자기소개", "성별", "생년월일", "이메일", "전화번호"]
    var errorTextLabelList: [String] = ["프로필 이름은 영문자(A-Z)와 숫자(0-9), 언더바(_)와 마침표(.)만을 조합하여 만들 수 있습니다.",
                                        "",
                                        "입력하신 비밀번호가 정확하지 않습니다.",
                                        "유효하지 않은 이메일 형식입니다."]
    
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"

    var errorTextLabel: UILabel = SystemView().errorTextLabel()
    
    var mainTextField: UITextField = SignUpView().mainTextField()
    var mainTextView: UITextView = SignUpView().mainTextView()

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
        
        mainTextField.delegate = self
        mainTextView.delegate = self
    }
    
    func addOnView() {
        viewList = [mainTextField, 
                    mainTextView,
                    errorTextLabel,
                    sendEmailVerificationButton, verifyCodeButton,
                    mainTextFieldBlurView, checkTextFieldBlurView]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }
    
    func viewLayout() {
        view.backgroundColor = UIColor.black
        
        mainTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 330, height: 40))
        }
        
        mainTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 330, height: 100))
        }
        
        mainTextView.isHidden = true
    }
    
    func navigationBarLayout() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), style: .done, target: self, action: #selector(backButtonAction))
        
        backButton.tintColor = UIColor.white
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    func validateEmail(email: String) -> Bool {
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func uiViewUpdate() {
        
    }
    
    func errorTextLabelLayout() {

    }
    
    func navigationItemSetting() {

    }
    
    @objc func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func nextButtonAction() {
        
    }
}

