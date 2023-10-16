//
//  SignUpViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/16/23.
//

import UIKit
import SnapKit

class BaseSignUpViewController: UIViewController {
    
    fileprivate var viewList: [UIView] = []
    fileprivate var mainTitleLabelList: [String] = ["프로필 이름", "사용자 이름", "계정 비밀번호", "계정 이메일"]
    fileprivate var subTitleLabelList: [String] = ["서클에서 대표로 보이게될 프로필 활동명입니다.\n추후에도 변경이 가능합니다.",
                                                   "서클에서 자신이 누군지 명확하게 보여줄 이름입니다.\n추후에 제한적으로 변경이 가능합니다.",
                                                   "로그인과 몇가지 설정과 인증을 위해 사용하는\n사용자 계정 비밀번호입니다.",
                                                   "사용자 계정 복구와 뉴스레터, 각종 업데이트 소식을\n정기적으로 수신할 수 있는 수단입니다."]
    
    fileprivate var mainTitleLabel: UILabel = SignUpView().mainTitleLabel()
    fileprivate var subTitleLabel: UILabel = SignUpView().subTitleLabel()
    
    fileprivate var mainTextField: UITextField = SignUpView().mainTextField()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        addOnView()
        viewLayout()
        navigationBarLayout()
        titleLabelUpdate()
    }
    
    fileprivate func addOnView() {
        viewList = [mainTitleLabel, subTitleLabel, mainTextField]
        
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
            make.size.equalTo(CGSize(width: 300, height: 30))
        }
    }
    
    fileprivate func navigationBarLayout() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonAction))
        let nextButton = UIBarButtonItem(title: "다음", style: .done, target: self, action: #selector(nextButtonAction))
        
        backButton.tintColor = UIColor.white
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = nextButton
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    fileprivate func titleLabelUpdate() {
        
    }
    
    @objc fileprivate func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func nextButtonAction() {
    }
}

class ProfileNameViewController: BaseSignUpViewController {
    
    override func titleLabelUpdate() {
        mainTitleLabel.text = mainTitleLabelList[0]
        subTitleLabel.text = subTitleLabelList[0]
    }
    
    override func nextButtonAction() {
        if let mainTextField = self.mainTextField.text, mainTextField.isEmpty {
            UIView.animate(withDuration: 0.5) {
                self.mainTextField.layer.borderWidth = 1.0
                self.mainTextField.layer.borderColor = UIColor.red.cgColor
            } completion: { _ in
                UIView.animate(withDuration: 0.5) {
                    self.mainTextField.layer.borderWidth = 0.0
                }
            }
        } else {
            let viewController = UserNameViewController()
            
            if let navigationController = self.view.window?.rootViewController as? UINavigationController {
                navigationController.pushViewController(viewController, animated: true)
            }
        }
    }
}

class UserNameViewController: BaseSignUpViewController {
    
    override func titleLabelUpdate() {
        mainTitleLabel.text = mainTitleLabelList[1]
        subTitleLabel.text = subTitleLabelList[1]
    }
    
    override func nextButtonAction() {
        if let mainTextField = self.mainTextField.text, mainTextField.isEmpty {
            UIView.animate(withDuration: 0.5) {
                self.mainTextField.layer.borderWidth = 1.0
                self.mainTextField.layer.borderColor = UIColor.red.cgColor
            } completion: { _ in
                UIView.animate(withDuration: 0.5) {
                    self.mainTextField.layer.borderWidth = 0.0
                }
            }
        } else {
            let viewController = AccountPasswordViewController()
            
            if let navigationController = self.view.window?.rootViewController as? UINavigationController {
                navigationController.pushViewController(viewController, animated: true)
            }
        }
    }
}

class AccountPasswordViewController: BaseSignUpViewController {
    
    override func titleLabelUpdate() {
        mainTitleLabel.text = mainTitleLabelList[2]
        subTitleLabel.text = subTitleLabelList[2]
    }
    
    override func nextButtonAction() {
        if let mainTextField = self.mainTextField.text, mainTextField.isEmpty {
            UIView.animate(withDuration: 0.5) {
                self.mainTextField.layer.borderWidth = 1.0
                self.mainTextField.layer.borderColor = UIColor.red.cgColor
            } completion: { _ in
                UIView.animate(withDuration: 0.5) {
                    self.mainTextField.layer.borderWidth = 0.0
                }
            }
        } else {
            let viewController = AccountEmailViewController()
            
            if let navigationController = self.view.window?.rootViewController as? UINavigationController {
                navigationController.pushViewController(viewController, animated: true)
            }
        }
    }
}

class AccountEmailViewController: BaseSignUpViewController {
    
    override func titleLabelUpdate() {
        mainTitleLabel.text = mainTitleLabelList[3]
        subTitleLabel.text = subTitleLabelList[3]
    }
    
    override func nextButtonAction() {
        if let mainTextField = self.mainTextField.text, mainTextField.isEmpty {
            UIView.animate(withDuration: 0.5) {
                self.mainTextField.layer.borderWidth = 1.0
                self.mainTextField.layer.borderColor = UIColor.red.cgColor
            } completion: { _ in
                UIView.animate(withDuration: 0.5) {
                    self.mainTextField.layer.borderWidth = 0.0
                }
            }
        } else {
            
        }
    }
}
