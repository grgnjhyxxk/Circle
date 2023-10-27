//
//  EditUserNameViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/26/23.
//

import UIKit
import SnapKit

class EditUserNameViewController: UserNameViewController {
    override func viewLayout() {
        view.backgroundColor = UIColor.black
        
        mainTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 330, height: 40))
        }
        
        mainTextField.text = SharedProfileModel.shared.userName
    }

    override func navigationBarLayout() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), style: .done, target: self, action: #selector(backButtonAction))
        
        nextButton.title = "완료"

        backButton.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "사용자 이름"
    }
    
    override func nextButtonAction() {
        if let userID = SharedProfileModel.shared.userID, let newUserName = mainTextField.text, let profileName = SharedProfileModel.shared.profileName {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicator)
            self.activityIndicator.startAnimating()
            updateProfileName(field: "userName", userID: userID, updateData: newUserName) { error in
                if error != nil {
                    print("error")
                } else {
                    fetchUserData(profileName: "\(profileName)") { (error) in
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
