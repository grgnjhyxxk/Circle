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
    private var separator: UIView = IntroView().separator()
    
    private var startButton: UIButton = IntroView().startButton()
    private var registerButton: UIButton = IntroView().registerButton()
    private var recoverCredentialsButton: UIButton = IntroView().recoverCredentialsButton()
    
    private var introMainTitleLabel: UILabel = IntroView().introMainTitleLabel()
    private var introSubTitleLabel: UILabel = IntroView().introSubTitleLabel()
    
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
        viewList = [spinningCirclesView, startButton, introMainTitleLabel, introSubTitleLabel, idTextField, passwordTextField, separator, registerButton, recoverCredentialsButton]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }
    
    private func viewLayout() {
        view.backgroundColor = .black

        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(300)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        spinningCirclesView.setCircleSizes(bigCircleSize: 80, smallCircleSize: 18, radius: 70)

        spinningCirclesView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(285)
        }
        
        introMainTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(spinningCirclesView.snp.bottom).offset(100)
        }
        
        introSubTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(introMainTitleLabel.snp.bottom).offset(5)
        }
        
        idTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(introSubTitleLabel.snp.bottom).offset(40)
            make.size.equalTo(CGSize(width: 220, height: 30))
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(idTextField.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 220, height: 30))
        }
        
        separator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: 220, height: 1))
        }
        
        registerButton.snp.makeConstraints { make in
            make.trailing.equalTo(separator)
            make.top.equalTo(separator.snp.bottom)
        }
        
        recoverCredentialsButton.snp.makeConstraints { make in
            make.leading.equalTo(separator)
            make.top.equalTo(separator.snp.bottom)
        }
        
        idTextField.alpha = 0
        passwordTextField.alpha = 0
        separator.alpha = 0
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
        if let image = self.startButton.imageView?.image, image == UIImage(systemName: "chevron.left.2")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 25, weight: .ultraLight)) {
            UIView.animate(withDuration: 0.5, animations: {
                self.spinningCirclesView.snp.updateConstraints { make in
                    make.top.equalToSuperview().offset(170)
                }
                
                self.introMainTitleLabel.snp.updateConstraints { make in
                    make.top.equalTo(self.spinningCirclesView.snp.bottom).offset(100)
                }
                
                self.introSubTitleLabel.snp.updateConstraints { make in
                    make.top.equalTo(self.introMainTitleLabel.snp.bottom).offset(5)
                }
                
                let image = UIImage(systemName: "checkmark")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 25, weight: .ultraLight))
                self.startButton.setImage(image, for: .normal)
                
                self.view.layoutIfNeeded()
            }) { _ in
                UIView.animate(withDuration: 0.3) {
                    self.idTextField.alpha = 1
                    self.passwordTextField.alpha = 1
                    UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
                        self.separator.alpha = 1
                        self.registerButton.alpha = 1
                        self.recoverCredentialsButton.alpha = 1
                    }, completion: nil)
                }
            }
            
        } else if let image = self.startButton.imageView?.image, image == UIImage(systemName: "checkmark")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 25, weight: .ultraLight)) {
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

