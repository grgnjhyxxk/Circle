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
        let sharedProfile = SharedProfileModel.shared
        
        let subStatusButtonString = "팔로우 \(formatNumber(sharedProfile.followerDigits ?? 0))   팔로잉 \(formatNumber(sharedProfile.followingDigits ?? 0))"
        let attributedsubStatusButtonString = NSMutableAttributedString(string: subStatusButtonString)
        let subStatusButtonStringRangeOne = (subStatusButtonString as NSString).range(of: "\(formatNumber(sharedProfile.followerDigits ?? 0))")
        let subStatusButtonStringRangeTwo = (subStatusButtonString as NSString).range(of: "\(formatNumber(sharedProfile.followingDigits ?? 0))")

        attributedsubStatusButtonString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .semibold), range: subStatusButtonStringRangeOne)
        attributedsubStatusButtonString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .semibold), range: subStatusButtonStringRangeTwo)
        
        subStatusButton.setAttributedTitle(attributedsubStatusButtonString, for: .normal)
        profileNameButton.setTitle("\(sharedProfile.profileName ?? "")", for: .normal)
        userNameTitleLabel.text = sharedProfile.userName
        userCategoryTitleLabel.text = sharedProfile.userCategory
        introductionLabel.text = sharedProfile.introduction
        userProfileImageView.image = sharedProfile.profileImage
        
        if let imageString = sharedProfile.backgroundImage {
            if let image = UIImage(named: imageString) {
                userProfileBackgroundImageView.image = image
            } else {
                userProfileBackgroundImageView.image = nil
            }
        } else {
            userProfileBackgroundImageView.image = nil
        }
        
        if sharedProfile.socialValidation ?? false {
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
        let settingListBarButton = UIButton()
        let postingBarButton = UIButton()

        settingListBarButton.addTarget(self, action: #selector(settingListButtonAction), for: .touchUpInside)
        
        if let image = UIImage(systemName: "list.bullet") {
            settingListBarButton.setImage(image, for: .normal)
        }
        
        if let image = UIImage(systemName: "plus.app") {
            postingBarButton.setImage(image, for: .normal)
        }
        
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
        
        navigationItem.titleView = profileNameButton
        navigationItem.rightBarButtonItem = rightStackBarButtonItem
    }
    
    @objc override func refreshData() {
        let profileName = SharedProfileModel.shared.profileName
        fetchUserData(profileName: "\(profileName ?? "")") { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.uiViewUpdate()
            }
                self.viewLayout()
                self.mainViewSetting()
                self.contentViewLayout()
                self.contentViewSetting()
                self.navigationBarLayout()

            self.refreshControl.endRefreshing()
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

