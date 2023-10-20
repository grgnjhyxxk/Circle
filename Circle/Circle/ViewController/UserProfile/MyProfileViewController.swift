//
//  MyProfileViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/20/23.
//

import UIKit
import SnapKit

class MyProfileViewController: BasicUserProfileViewController {
    
    override func mainViewSetting() {
        settingListButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-25)
            make.centerY.equalTo(profileNameTitleLabel).offset(2)
            make.size.equalTo(CGSize(width: 25, height: 24))
        }
        
        postingButton.snp.makeConstraints { make in
            make.trailing.equalTo(settingListButton.snp.leading).offset(-15)
            make.centerY.equalTo(profileNameTitleLabel)
            make.size.equalTo(CGSize(width: 28, height: 28))
        }
    }
    
    override func contentViewSetting() {

    }
    
    override func uiViewUpdate() {
        let userData = myDataList[0]
        
        profileNameTitleLabel.text = userData.profileName
        userNameTitleLabel.text = userData.userName
        introductionLabel.text = userData.intrduction
        myCircleDigitsLabel.text = formatNumber(userData.myCircleDigits)
        myInTheCircleDigitsLabel.text = formatNumber(userData.myInTheCircleDigits)
        myPostDigitsLabel.text = formatNumber(userData.myPostDigits)
        followerDigitsLabel.text = formatNumber(userData.followerDigits)
        followingDigitsLabel.text = formatNumber(userData.followingDigits)
        
        if let imageString = userData.image {
            if let image = UIImage(named: imageString) {
                userProfileImageView.image = image
            } else {
                // 이미지를 로드할 수 없는 경우
                userProfileImageView.image = UIImage(named: "BasicUserProfileImage")
            }
        } else {
            // 이미지 정보가 없는 경우
            userProfileImageView.image = UIImage(named: "BasicUserProfileImage")
        }
        
        if userData.socialValidation {
            socialValidationMarkButton.isHidden = false
        } else {
            socialValidationMarkButton.isHidden = true
        }
    }
    
    @objc override func refreshData() {
        let profileName = myDataList[0].profileName
        fetchUserData(profileName: "\(profileName)") { (userData, error) in
            if let userData = userData {
                myDataList.removeAll()
                myDataList.append(userData)
                print(myDataList)
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                
            }
            self.refreshControl.endRefreshing()
            self.uiViewUpdate()
        }
    }
    
    @objc override func settingListButtonAction() {
        let viewController = SettingTableViewController()
        
        present(viewController, animated: true)
    }
}

