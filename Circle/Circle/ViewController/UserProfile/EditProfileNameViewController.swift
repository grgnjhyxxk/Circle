//
//  EditProfileNameViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/26/23.
//

import UIKit
import SnapKit

class EditProfileNameViewController: ProfileNameViewController {
    override func viewLayout() {
        view.backgroundColor = UIColor.black
        
        mainTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 330, height: 40))
        }
        
        mainTextField.text = SharedProfileModel.shared.profileName
    }

    override func navigationBarLayout() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), style: .done, target: self, action: #selector(backButtonAction))
        
        nextButton.title = "완료"

        backButton.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "프로필 이름"
    }
    
    override func nextButtonAction() {
        checkIfProfileNameExists(mainTextField.text!) { (exists, error) in
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicator)
            self.activityIndicator.startAnimating()
            
            if exists {
                self.mainTextField.layer.borderWidth = 2
                self.mainTextField.layer.borderColor = UIColor.red.cgColor
                
                AnimationView().shakeView(self.mainTextField)
                
                self.errorTextLabel.isHidden = false
                self.errorTextLabel.text = "이미 사용 중인 프로필 이름입니다."
            } else {
                self.errorTextLabel.isHidden = true
                self.mainTextField.layer.borderWidth = 0.5
                self.mainTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
                
                if let userID = SharedProfileModel.shared.userID, let newProfileName = self.mainTextField.text {
                    updateProfileName(field: "profileName", userID: userID, updateData: newProfileName) { error in
                        if error != nil {
                            print("error")
                        } else {
                            fetchUserData(profileName: "\(newProfileName)") { (error) in
                                if let error = error {
                                    print("Error: \(error.localizedDescription)")
                                }
                                DispatchQueue.main.async {
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ProfileUpdated"), object: nil)
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
