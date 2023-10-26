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
        if let userID = SharedProfileModel.shared.userID, let newProfileName = mainTextField.text {
            updateProfileName(userID: userID, newProfileName: newProfileName) { error in
                if let error = error {
                    print("프로필 이름 업데이트 실패: \(error.localizedDescription)")
                } else {
                    print("프로필 이름 업데이트 성공")
                    fetchUserData(profileName: "\(newProfileName)") { (error) in
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        }
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ProfileNameUpdated"), object: newProfileName)
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
}
