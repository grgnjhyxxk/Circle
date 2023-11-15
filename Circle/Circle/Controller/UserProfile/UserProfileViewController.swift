//
//  UserProfileViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/28/23.
//

import UIKit
import SnapKit

class UserProfileViewController: BasicUserProfileViewController {
    var indexPath: Int?
    
    override func mainViewSetting() {

    }
    
    override func contentViewSetting() {
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
        let sharedProfile = SharedProfileModel.otherUsersProfiles[indexPath!]
        
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
        userProfileBackgroundImageView.image = sharedProfile.backgroundImage
        
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
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), style: .done, target: self, action: #selector(backButtonAction))
        
        backButton.tintColor = UIColor.white
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = profileNameButton
    }
    
    @objc private func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
}
