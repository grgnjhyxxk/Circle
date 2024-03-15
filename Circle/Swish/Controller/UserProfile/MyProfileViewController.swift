//
//  MyProfileViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/20/23.
//

import UIKit
import SnapKit

class MyProfileViewController: BasicUserProfileViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func mainViewSetting() {
        
    }
    
    override func contentViewSetting() {
        postsTableView.register(FollowingPostsTableViewCell.self, forCellReuseIdentifier: "FollowingPostsTableViewCell")
        
        postsTableView.separatorInset.left = 0
        
        postsTableView.dataSource = self
        postsTableView.delegate = self
        
        followButton.isHidden = true
        mentionButton.isHidden = true
    }
    
    override func uiViewUpdate() {
        DispatchQueue.main.async {
            let sharedProfile = SharedProfileModel.myProfile
            
            let subStatusButtonString = "팔로우 \(formatNumber(sharedProfile.followerDigits ?? 0))   팔로잉 \(formatNumber(sharedProfile.followingDigits ?? 0))"
            let attributedsubStatusButtonString = NSMutableAttributedString(string: subStatusButtonString)
            let subStatusButtonStringRangeOne = (subStatusButtonString as NSString).range(of: "\(formatNumber(sharedProfile.followerDigits ?? 0))")
            let subStatusButtonStringRangeTwo = (subStatusButtonString as NSString).range(of: "\(formatNumber(sharedProfile.followingDigits ?? 0))")
            
            attributedsubStatusButtonString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .semibold), range: subStatusButtonStringRangeOne)
            attributedsubStatusButtonString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .semibold), range: subStatusButtonStringRangeTwo)
            
            self.subStatusButton.setAttributedTitle(attributedsubStatusButtonString, for: .normal)
//            self.profileNameTitleLabel.text = sharedProfile.profileName
            self.profileNameTitleLabel.text = "@\(sharedProfile.profileName ?? "unknown")"
            if sharedProfile.userName == "" {
                self.userNameTitleLabel.text = sharedProfile.profileName
            } else {
                self.userNameTitleLabel.text = sharedProfile.userName
            }
            
            self.userCategoryTitleLabel.text = sharedProfile.userCategory
            self.introductionLabel.text = sharedProfile.introduction
            self.userProfileImageView.image = sharedProfile.profileImage
            
            if sharedProfile.socialValidation ?? false {
                self.socialValidationImageView.isHidden = false
            } else {
                self.socialValidationImageView.isHidden = true
            }
            
            DispatchQueue.main.async {
                let labelHeight = self.heightForLabel(label: self.introductionLabel)
                
                self.contentView.snp.updateConstraints { make in
                    make.height.equalTo(167 + labelHeight + 15)
                }
            }
            
            self.postsTableView.layoutIfNeeded()
            self.contentView.layoutIfNeeded()
        }
    }
    
    override func navigationBarLayout() {
        let settingListBarButton = UIButton()
        let postingBarButton = UIButton()
        
        settingListBarButton.addTarget(self, action: #selector(settingListButtonAction), for: .touchUpInside)
        postingBarButton.addTarget(self, action: #selector(postingButtonAction), for: .touchUpInside)
        
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
        
        settingListBarButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 23, height: 21))
        }
        
        let righthStackview = UIStackView.init(arrangedSubviews: [settingListBarButton])
        righthStackview.distribution = .equalSpacing
        righthStackview.axis = .horizontal
        righthStackview.alignment = .center
        righthStackview.spacing = 15
        
        let leftStackView = UIStackView.init(arrangedSubviews: [profileNameButton])
        
        let rightStackBarButtonItem = UIBarButtonItem(customView: righthStackview)
        let leftStackBarButtonItem = UIBarButtonItem(customView: leftStackView)
        
        navigationItem.leftBarButtonItem = leftStackBarButtonItem
        navigationItem.rightBarButtonItem = rightStackBarButtonItem
    }
    
    @objc override func refreshData() {
        let myProfile = SharedProfileModel.myProfile
        fetchUserData(profileName: "\(myProfile.profileName ?? "")") { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                retrieveMyPosts(userID: myProfile.userID!) { (error) in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    } else {
                        DispatchQueue.main.async {
                            self.uiViewUpdate()
                            self.postsTableView.reloadData()
                        }
                    }
                    
                    self.noPostsAvailableImageViewSetting()
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    @objc override func settingListButtonAction() {
        let viewController = SettingTableViewController()
        present(viewController, animated: true)
    }
    
    @objc override func postingButtonAction() {
        let viewController = UINavigationController(rootViewController: PostingViewController())
        
        viewController.modalPresentationStyle = .fullScreen
        
        present(viewController, animated: true)
    }
    
    @objc override func profileEdditButtonAction() {
        let viewController = UINavigationController(rootViewController: EditProfileViewController())
        
        viewController.modalPresentationStyle = .fullScreen
        
        present(viewController, animated: true)
    }
    
    @objc override func postSettingButtonAction(_ sender: UIButton) {
        let indexPath = sender.tag
        let myProfile = SharedProfileModel.myProfile
        let myPosts = SharedPostModel.myPosts
        
        if myPosts[indexPath].userID == myProfile.userID {
            // UIAlertController 생성
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            // 수정 액션 추가
            let editAction = UIAlertAction(title: "수정", style: .default) { _ in
                // 수정 버튼이 눌렸을 때의 동작
                self.editPostButtonAction(indexPath: indexPath)
            }
            alertController.addAction(editAction)
            
            // 삭제 액션 추가
            let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
                // 삭제 버튼이 눌렸을 때의 동작
                self.deletePostButtonAction(indexPath: indexPath)
            }
            alertController.addAction(deleteAction)
            
            // 취소 액션 추가
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            // 액션 시트 표시
            present(alertController, animated: true, completion: nil)
        } else {
            
        }
    }
    
    @objc override func updateProfile(_ notification: Notification) {
        DispatchQueue.main.async {
            self.uiViewUpdate()
        }
    }
    
    func editPostButtonAction(indexPath: Int) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PostEditingIsOn"), object: nil)
        }
        
        let viewController = PostEditingViewController()
        
        viewController.postIndexPathForEditing = indexPath
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.hidesBottomBarWhenPushed = true
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true)
    }
    
    func deletePostButtonAction(indexPath: Int) {
        let myProfile = SharedProfileModel.myProfile
        let myPosts = SharedPostModel.myPosts
        
        if let userID = myProfile.userID {
            if let postIDForDelete = myPosts[indexPath].postID {
                
                deletePost(userID: userID, postID: postIDForDelete) { (error) in
                    if let error = error {
                        
                    } else {
                        SharedPostModel.myPosts.removeAll()
                        
                        retrieveMyPosts(userID: userID) { (error) in
                            if let error = error {
                                print("Error: \(error.localizedDescription)")
                            } else {
                                DispatchQueue.main.async {
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PostUpdated"), object: nil)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SharedPostModel.myPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = SharedPostModel.myPosts[indexPath.row]
        let userProfile = SharedProfileModel.myProfile
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingPostsTableViewCell", for: indexPath) as! FollowingPostsTableViewCell
        
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
        contentView.layoutIfNeeded()
        postsTableView.layoutIfNeeded()
        
        return cell
    }
}

