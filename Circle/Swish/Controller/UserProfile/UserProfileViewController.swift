//
//  UserProfileViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/28/23.
//

import UIKit
import SnapKit

class UserProfileViewController: BasicUserProfileViewController, UITableViewDelegate, UITableViewDataSource {
    var indexPath: Int?
    
    override func mainViewSetting() {

    }
    
    override func contentViewSetting() {
        postsTableView.register(FollowingPostsTableViewCell.self, forCellReuseIdentifier: "FollowingPostsTableViewCell")
        
        postsTableView.separatorInset.left = 0
        
        postsTableView.dataSource = self
        postsTableView.delegate = self
        
        profileEditButton.isHidden = true
            
        let labelHeight = self.heightForLabel(label: self.introductionLabel)

        loading.snp.makeConstraints { make in
            make.top.equalTo(180 + labelHeight + 15)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc override func refreshData() {
        DispatchQueue.main.async {
            self.uiViewUpdate()
            self.postsTableView.reloadData()
        }
        
        self.refreshControl.endRefreshing()
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
        
        let userProfile = SharedProfileModel.otherUsersProfiles[indexPath!]
        print(userProfile.userID)
        if let userID = userProfile.userID {
            retrieveMyPosts(userID: userID) { (error) in
                self.loading.startAnimating()
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    // 성공적으로 데이터를 가져왔을 때 로딩을 멈추도록 수정
                    self.loading.stopAnimating()
                    // 테이블 뷰를 업데이트하고 로딩을 멈추는 코드는 비동기 블록 밖으로 이동
                    DispatchQueue.main.async {
                        self.postsTableView.reloadData()
                        self.postsTableView.layoutIfNeeded()
                        self.contentView.layoutIfNeeded()
                    }
                }
            }
        }
        
        // 로딩을 멈추는 코드는 여기로 이동
        // self.loading.stopAnimating()
        // 테이블 뷰를 업데이트하는 코드도 여기로 이동
        // self.postsTableView.reloadData()
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedUserID = SharedProfileModel.otherUsersProfiles[indexPath!].userID
        let userPosts = SharedPostModel.searchUserPosts.filter { $0.userID == selectedUserID }
        return userPosts.count // 해당 사용자의 포스트 수 반환
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingPostsTableViewCell", for: indexPath) as! FollowingPostsTableViewCell
        
        let selectedUserID = SharedProfileModel.otherUsersProfiles[self.indexPath!].userID
        let userPosts = SharedPostModel.searchUserPosts.filter { $0.userID == selectedUserID }
        
        if indexPath.row < userPosts.count { // 배열의 인덱스가 유효한지 확인
            let post = userPosts[indexPath.row]
            let userProfile = SharedProfileModel.otherUsersProfiles[indexPath.row]
            
            cell.moreButton.tag = indexPath.row
            cell.moreButton.addTarget(self, action: #selector(postSettingButtonAction), for: .touchUpInside)
            
            cell.images = post.images
            cell.feedTextLabel.text = post.content
            
            if let date = post.date {
                cell.dateLabel.text = formatPostTimestamp(date)
            }
            
            cell.profileImageView.image = userProfile.profileImage
            cell.profileNameLabel.text = userProfile.profileName
            cell.userNameLabel.text = userProfile.userName
            cell.socialValidationImageView.isHidden = !(userProfile.socialValidation ?? false)
            
            cell.collectionView.reloadData()
        }
        
        return cell
    }
}
