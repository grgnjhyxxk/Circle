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

    }
    
    override func contentViewSetting() {
        profileEditButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 70, height: 30))
        }
        
        topViewBottomSeparator.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(subStatusButton.snp.bottom).offset(20)
            make.height.equalTo(1)
        }
        
        myPersonalPostsFeedButton.snp.makeConstraints { make in
            make.top.equalTo(topViewBottomSeparator.snp.bottom)
            make.leading.equalTo(contentView)
            make.size.equalTo(CGSize(width: view.frame.width / 2, height: 40))
        }
        
        myCirclePostsFeedButton.snp.makeConstraints { make in
            make.top.equalTo(topViewBottomSeparator.snp.bottom)
            make.trailing.equalTo(contentView)
            make.size.equalTo(CGSize(width: view.frame.width / 2, height: 40))
        }
        
        myPersonalPostsFeedButton.addSubview(myPersonalPostsFeedButtonBottomBar)
        myCirclePostsFeedButton.addSubview(myCirclePostsButtonBottomBar)

        myPersonalPostsFeedButtonBottomBar.snp.makeConstraints { make in
            make.centerX.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 2))
        }
        
        myCirclePostsButtonBottomBar.snp.makeConstraints { make in
            make.centerX.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 2))
        }
    }
    
    override func uiViewUpdate() {
        let userData = myDataList[0]
        
//        profileNameTitleLabel.text = userData.profileName
        profileNameButton.setTitle("\(userData.profileName)", for: .normal)
        userNameTitleLabel.text = userData.userName
        userCategoryTitleLabel.text = userData.userCategory
        introductionLabel.text = userData.introduction
        
        let subStatusButtonString = "팔로우 \(formatNumber(userData.followerDigits))   팔로잉 \(formatNumber(userData.followingDigits))"
        
        let attributedsubStatusButtonString = NSMutableAttributedString(string: subStatusButtonString)
        
        let subStatusButtonStringRangeOne = (subStatusButtonString as NSString).range(of: "\(formatNumber(userData.followerDigits))")
        let subStatusButtonStringRangeTwo = (subStatusButtonString as NSString).range(of: "\(formatNumber(userData.followingDigits))")

        attributedsubStatusButtonString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .semibold), range: subStatusButtonStringRangeOne)
        attributedsubStatusButtonString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .semibold), range: subStatusButtonStringRangeTwo)
        
        subStatusButton.setAttributedTitle(attributedsubStatusButtonString, for: .normal)
        
        if let imageString = userData.profileImage {
            if let image = UIImage(named: imageString) {
                userProfileImageView.image = image
            } else {
                userProfileImageView.image = UIImage(named: "BasicUserProfileImage")
            }
        } else {
            userProfileImageView.image = UIImage(named: "BasicUserProfileImage")
        }
        
        if let imageString = userData.backgroundImage {
            if let image = UIImage(named: imageString) {
                userProfileBackgroundImageView.image = image
            } else {
                userProfileBackgroundImageView.image = UIImage()
            }
        } else {
            userProfileBackgroundImageView.image = UIImage()
        }
        
        if userData.socialValidation {
            if let image = UIImage(systemName: "checkmark.seal.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 14, weight: .light)) {
                profileNameButton.setImage(image, for: .normal)
            }
        
            profileNameButton.tintColor = UIColor.systemBlue
            profileNameButton.imageEdgeInsets = UIEdgeInsets(top: 1, left: 4.5, bottom: 0, right: 0)
            profileNameButton.semanticContentAttribute = .forceRightToLeft
            profileNameButton.contentVerticalAlignment = .center
            profileNameButton.contentHorizontalAlignment = .center
        } else {
            profileNameButton.setImage(nil, for: .normal)
        }
    }

    override func navigationBarLayout() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonAction))
        
        let settingListBarButton = UIButton()
        let postingBarButton = UIButton()

        settingListBarButton.addTarget(self, action: #selector(settingListButtonAction), for: .touchUpInside)
        
        if let image = UIImage(systemName: "list.bullet") {
            settingListBarButton.setImage(image, for: .normal)
        }
        
        if let image = UIImage(systemName: "plus.app") {
            postingBarButton.setImage(image, for: .normal)
        }
        
        backButton.tintColor = UIColor.white
        settingListBarButton.tintColor = UIColor.white
        postingBarButton.tintColor = UIColor.white
        settingListBarButton.contentHorizontalAlignment = .fill
        settingListBarButton.contentVerticalAlignment = .fill
        postingBarButton.contentHorizontalAlignment = .fill
        postingBarButton.contentVerticalAlignment = .fill

        profileNameButton.snp.makeConstraints { make in
            make.width.equalTo(200)
        }
        
        settingListBarButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 26, height: 24))
        }
        
        postingBarButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 27))
        }

        let righthStackview = UIStackView.init(arrangedSubviews: [postingBarButton, settingListBarButton])
        righthStackview.distribution = .equalSpacing
        righthStackview.axis = .horizontal
        righthStackview.alignment = .center
        righthStackview.spacing = 15

        let rightStackBarButtonItem = UIBarButtonItem(customView: righthStackview)
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = profileNameButton
        navigationItem.rightBarButtonItem = rightStackBarButtonItem
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
            self.viewLayout()
            self.mainViewSetting()
            self.contentViewLayout()
            self.contentViewSetting()
            self.navigationBarLayout()
        }
    }
    
    @objc override func settingListButtonAction() {
        let viewController = SettingTableViewController()
        
        present(viewController, animated: true)
    }
    
    @objc override func profileEdditButtonAction() {
        let viewController = EditPorfileViewController()

        show(viewController, sender: nil)
    }
}

