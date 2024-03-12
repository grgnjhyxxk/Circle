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
        profileEditButton.isHidden = true
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
        profileNameTitleLabel.text = "@\(sharedProfile.profileName ?? "unknown")"

        if sharedProfile.userName == "" {
            userNameTitleLabel.text = sharedProfile.profileName
        } else {
            userNameTitleLabel.text = sharedProfile.userName
        }
        
        userCategoryTitleLabel.text = sharedProfile.userCategory
        introductionLabel.text = sharedProfile.introduction
        userProfileImageView.image = sharedProfile.profileImage
        
        DispatchQueue.main.async {
            let labelHeight = self.heightForLabel(label: self.introductionLabel)
            
            self.contentView.snp.updateConstraints { make in
                make.height.equalTo(180 + labelHeight + 15)
            }
        }
        
        self.postsTableView.layoutIfNeeded()
        self.contentView.layoutIfNeeded()
    }

    override func navigationBarLayout() {
        let settingListBarButton = UIButton()
        let notificationtBarButton = UIButton()

        settingListBarButton.addTarget(self, action: #selector(settingListButtonAction), for: .touchUpInside)
        notificationtBarButton.addTarget(self, action: #selector(postingButtonAction), for: .touchUpInside)
        
        if let image = UIImage(systemName: "list.bullet.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 26, weight: .regular)) {
            settingListBarButton.setImage(image, for: .normal)
        }
        
        if let image = UIImage(systemName: "bell")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 26, weight: .regular)) {
            notificationtBarButton.setImage(image, for: .normal)
        }
        
        settingListBarButton.tintColor = UIColor.white
        notificationtBarButton.tintColor = UIColor.white
        
        settingListBarButton.contentHorizontalAlignment = .fill
        settingListBarButton.contentVerticalAlignment = .fill
        
        notificationtBarButton.contentHorizontalAlignment = .fill
        notificationtBarButton.contentVerticalAlignment = .fill
        
        let righthStackview = UIStackView.init(arrangedSubviews: [notificationtBarButton, settingListBarButton])
        righthStackview.distribution = .equalSpacing
        righthStackview.axis = .horizontal
        righthStackview.alignment = .center
        righthStackview.spacing = 15
        
        let rightStackBarButtonItem = UIBarButtonItem(customView: righthStackview)
        
        self.navigationController?.navigationBar.topItem?.title = "뒤로"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        navigationItem.rightBarButtonItem = rightStackBarButtonItem
    }
    
    @objc private func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
}
