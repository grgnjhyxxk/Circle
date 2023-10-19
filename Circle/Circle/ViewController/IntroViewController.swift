//
//  ViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/11/23.
//

import UIKit
import SnapKit

class IntroViewController: UIViewController {
    
    internal var isLoggedInBool: Bool = Bool()
    
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
    private var errorTextLabel: UILabel = SystemView().errorTextLabel()
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
    }
    
    internal func isLoggedIn() -> UIViewController? {
        if isLoggedInBool {
            return TabBarController()
        } else {
            let introViewController = IntroViewController()
            let navigationController = UINavigationController(rootViewController: introViewController)
            
            return navigationController
        }
    }
    
    private func addOnView() {
        viewList = [spinningCirclesView, startButton, introMainTitleLabel, introSubTitleLabel, idTextField, passwordTextField, separator_left, separator_right, registerButton, recoverCredentialsButton, separatorTitleLabel, errorTextLabel]
        
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
        
        introMainTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(340)
        }
        
        introSubTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(introMainTitleLabel.snp.bottom)
        }
        
        spinningCirclesView.setCircleSizes(bigCircleSize: 20, smallCircleSize: 5, radius: 17)

        spinningCirclesView.snp.makeConstraints { make in
            make.leading.equalTo(introMainTitleLabel.snp.trailing).offset(30)
            make.top.equalTo(introMainTitleLabel).offset(32)
        }
        
        idTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(introSubTitleLabel.snp.bottom).offset(40)
            make.size.equalTo(CGSize(width: 340, height: 40))
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(idTextField.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 340, height: 40))
        }
        
        errorTextLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(passwordTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
        }
        
        separator_left.snp.makeConstraints { make in
            make.top.equalTo(errorTextLabel.snp.bottom).offset(25)
            make.leading.equalTo(idTextField)
            make.size.equalTo(CGSize(width: 140, height: 1))
        }
        
        separator_right.snp.makeConstraints { make in
            make.top.equalTo(errorTextLabel.snp.bottom).offset(25)
            make.trailing.equalTo(idTextField)
            make.size.equalTo(CGSize(width: 140, height: 1))
        }
        
        separatorTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(separator_right).offset(-9)
            make.centerX.equalToSuperview()
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(separator_right.snp.bottom).offset(15)
            make.trailing.equalTo(separator_right)
        }
        
        recoverCredentialsButton.snp.makeConstraints { make in
            make.top.equalTo(registerButton)
            make.leading.equalTo(separator_left)
        }
        
        idTextField.alpha = 0
        passwordTextField.alpha = 0
        separator_left.alpha = 0
        separator_right.alpha = 0
        separatorTitleLabel.alpha = 0
        registerButton.alpha = 0
        recoverCredentialsButton.alpha = 0
        
        errorTextLabel.text = "아디이 혹은 비밀번호가 잘못되었습니다."
        errorTextLabel.isHidden = true
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
        if let image = self.startButton.imageView?.image,
           image == UIImage(systemName: "chevron.up")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)) {
            
            UIView.animate(withDuration: 0.7, animations: {
                self.introMainTitleLabel.snp.updateConstraints { make in
                    make.top.equalToSuperview().offset(150)
                }
                self.view.layoutIfNeeded()
            }) { _ in
                
                UIView.animate(withDuration: 0.5) {
                    self.idTextField.alpha = 1
                    self.passwordTextField.alpha = 1
                    
                    UIView.animate(withDuration: 0.3, delay: 0.5, options: [], animations: {
                        self.separator_left.alpha = 1
                        self.separator_right.alpha = 1
                        self.separatorTitleLabel.alpha = 1
                        self.registerButton.alpha = 1
                        self.recoverCredentialsButton.alpha = 1
                    }, completion: nil)
                }
                
                UIView.transition(with: self.startButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    let newImage = UIImage(systemName: "checkmark")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .thin))
                    self.startButton.setImage(newImage, for: .normal)
                }, completion: nil)
            }
        } else if let image = self.startButton.imageView?.image, image == UIImage(systemName: "checkmark")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)) {
            if let idText = self.idTextField.text, idText.isEmpty {
                UIView.animate(withDuration: 0.5) {
                    self.idTextField.layer.borderWidth = 2
                    self.idTextField.layer.borderColor = UIColor.red.withAlphaComponent(0.5).cgColor
                    AnimationView().shakeView(self.idTextField)
                } completion: { _ in
                    UIView.animate(withDuration: 0.5) {
                        self.idTextField.layer.borderWidth = 0.5
                        self.idTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
                    }
                }

            } else if let passwordText = self.passwordTextField.text, passwordText.isEmpty {
                UIView.animate(withDuration: 0.5) {
                    self.passwordTextField.layer.borderWidth = 2
                    self.passwordTextField.layer.borderColor = UIColor.red.withAlphaComponent(0.5).cgColor
                    AnimationView().shakeView(self.passwordTextField)
                } completion: { _ in
                    UIView.animate(withDuration: 0.5) {
                        self.passwordTextField.layer.borderWidth = 0.5
                        self.passwordTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor                        }
                }
                
            } else if let idText = self.idTextField.text, let passwordText = self.passwordTextField.text, !passwordText.isEmpty && !idText.isEmpty {
                isLoggedInBool = true
                    
                fetchUserData(profileName: "\(idText)") { (userData, error) in
                    if let userData = userData {
                        let inputPassword = userData.password
                        if comparePasswords(inputPassword: passwordText, savedPassword: inputPassword) {
                            if let tabBarController = self.isLoggedIn() {
                                self.errorTextLabel.isHidden = true
                                tabBarController.modalPresentationStyle = .fullScreen
                                self.present(tabBarController, animated: true)
                            }
                        } else {
                            self.errorTextLabel.isHidden = false
                        }
                        
                    } else if let error = error {
                        self.errorTextLabel.isHidden = false
                        print("Error: \(error.localizedDescription)")
                    } else {
                        
                    }
                }
            }
        }
    }
}
