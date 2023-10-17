//
//  ViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/11/23.
//

import UIKit
import SnapKit

class IntroViewController: UIViewController {
    
    private var viewList: [UIView] = []
    
    private var spinningCirclesView = SpinningCirclesView()
    private var separator_left: UIView = IntroView().separator()
    private var separator_right: UIView = IntroView().separator()

    private var startButton: UIButton = IntroView().startButton()
    private var registerButton: UIButton = IntroView().registerButton()
    private var recoverCredentialsButton: UIButton = IntroView().recoverCredentialsButton()
    
    private var introMainTitleLabel: UILabel = IntroView().introMainTitleLabel()
    private var introSubTitleLabel: UILabel = IntroView().introSubTitleLabel()
    private var separatorTitleLabel: UILabel = IntroView().separatorTitleLabel()
    
    private var idTextField: UITextField = IntroView().idTextField()
    private var passwordTextField: UITextField = IntroView().passwordTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addOnView()
        viewLayout()
        spinningCirclesView.startAnimation()
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spinningCirclesView.startAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }
    
    private func addOnView() {
        viewList = [spinningCirclesView, startButton, introMainTitleLabel, introSubTitleLabel, idTextField, passwordTextField, separator_left, separator_right, registerButton, recoverCredentialsButton, separatorTitleLabel]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }
    
    private func viewLayout() {
        view.backgroundColor = .black

        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(330)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        spinningCirclesView.setCircleSizes(bigCircleSize: 85, smallCircleSize: 19, radius: 72)

        spinningCirclesView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(250)
        }
        
        introMainTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(spinningCirclesView.snp.bottom).offset(120)
        }
        
        introSubTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(introMainTitleLabel.snp.bottom).offset(5)
        }
        
        idTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(spinningCirclesView.snp.bottom).offset(120)
            make.size.equalTo(CGSize(width: 340, height: 40))
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(idTextField.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 340, height: 40))
        }
        
        separator_left.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.leading.equalTo(idTextField)
            make.size.equalTo(CGSize(width: 140, height: 1))
        }
        
        separator_right.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.trailing.equalTo(idTextField)
            make.size.equalTo(CGSize(width: 140, height: 1))
        }
        
        separatorTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(separator_right).offset(-8)
            make.centerX.equalToSuperview()
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(separator_right.snp.bottom).offset(8)
            make.trailing.equalTo(separator_right)
        }
        
        recoverCredentialsButton.snp.makeConstraints { make in
            make.top.equalTo(separator_left.snp.bottom).offset(8)
            make.leading.equalTo(separator_left)
        }
        
        idTextField.alpha = 0
        passwordTextField.alpha = 0
        separator_left.alpha = 0
        separator_right.alpha = 0
        separatorTitleLabel.alpha = 0
        registerButton.alpha = 0
        recoverCredentialsButton.alpha = 0
    }
    
    private func addTargets() {
        startButton.addTarget(self, action: #selector(startButtonTouchAction), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(signUpButtonTouchAction), for: .touchUpInside)
    }
    
    @objc private func signUpButtonTouchAction() {
        let viewController = ProfileNameViewController()
        
        if let navigationController = self.view.window?.rootViewController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    @objc private func startButtonTouchAction() {
        if let image = self.startButton.imageView?.image, image == UIImage(systemName: "chevron.left.2")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .ultraLight)) {
            UIView.animate(withDuration: 0.5, animations: {
                self.introMainTitleLabel.alpha = 0
                self.introSubTitleLabel.alpha = 0
                
                self.spinningCirclesView.snp.updateConstraints { make in
                    make.top.equalToSuperview().offset(180)
                }
                
                let image = UIImage(systemName: "checkmark")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .ultraLight))
                self.startButton.setImage(image, for: .normal)
                
                self.view.layoutIfNeeded()
            }) { _ in
                UIView.animate(withDuration: 0.3) {
                    self.idTextField.alpha = 1
                    self.passwordTextField.alpha = 1
                    UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
                        self.separator_left.alpha = 1
                        self.separator_right.alpha = 1
                        self.separatorTitleLabel.alpha = 1
                        self.registerButton.alpha = 1
                        self.recoverCredentialsButton.alpha = 1
                    }, completion: nil)
                }
            }
            
        } else if let image = self.startButton.imageView?.image, image == UIImage(systemName: "checkmark")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .ultraLight)) {
            if let idText = self.idTextField.text, let passwordText = self.passwordTextField.text {
                if idText.isEmpty {
                    UIView.animate(withDuration: 0.5) {
                        self.idTextField.layer.borderWidth = 1.0
                        self.idTextField.layer.borderColor = UIColor.red.cgColor
                    } completion: { _ in
                        UIView.animate(withDuration: 0.5) {
                            self.idTextField.layer.borderWidth = 0.0
                        }
                    }
                }

                if passwordText.isEmpty {
                    UIView.animate(withDuration: 0.5) {
                        self.passwordTextField.layer.borderWidth = 1.0
                        self.passwordTextField.layer.borderColor = UIColor.red.cgColor
                    } completion: { _ in
                        UIView.animate(withDuration: 0.5) {
                            self.passwordTextField.layer.borderWidth = 0.0
                        }
                    }
                }

                if idText.isEmpty || passwordText.isEmpty {
                    print("wrong!")
                } else {
                    print("perfect")
                }
            }
        }
    }
}

