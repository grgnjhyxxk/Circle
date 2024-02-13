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
            self.profileNameButton.setTitle("\(sharedProfile.profileName ?? "")", for: .normal)
            self.userNameTitleLabel.text = sharedProfile.userName
            self.userCategoryTitleLabel.text = sharedProfile.userCategory
            self.introductionLabel.text = sharedProfile.introduction
            self.userProfileImageView.image = sharedProfile.profileImage
            self.userProfileBackgroundImageView.image = sharedProfile.backgroundImage
            
            if sharedProfile.socialValidation ?? false {
                if let image = UIImage(systemName: "checkmark.seal.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 14, weight: .light)) {
                    self.profileNameButton.setImage(image, for: .normal)
                }
                
                self.profileNameButton.tintColor = UIColor.systemBlue
                self.profileNameButton.imageEdgeInsets = UIEdgeInsets(top: 1, left: 4.5, bottom: 0, right: 0)
                self.profileNameButton.semanticContentAttribute = .forceRightToLeft
                self.profileNameButton.contentVerticalAlignment = .center
                self.profileNameButton.contentHorizontalAlignment = .center
            } else {
                self.profileNameButton.setImage(nil, for: .normal)
            }
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

        profileNameButton.snp.makeConstraints { make in
            make.width.equalTo(200)
        }
        
        settingListBarButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 23, height: 21))
        }
        
        postingBarButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 27, height: 24))
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
        let myProfile = SharedProfileModel.myProfile
        fetchUserData(profileName: "\(myProfile.profileName ?? "")") { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                SharedPostModel.myPosts.removeAll()
                retrieveMyPosts(userID: myProfile.userID!) { (error) in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    } else {
                        DispatchQueue.main.async {
                            self.uiViewUpdate()
                            self.postsTableView.reloadData()
                        }
                    }
                    
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
        
        viewController.hidesBottomBarWhenPushed = true
        viewController.modalPresentationStyle = .fullScreen

        present(viewController, animated: true)
    }
    
    @objc override func profileEdditButtonAction() {
        let viewController = UINavigationController(rootViewController: EditProfileViewController())
        
        viewController.modalPresentationStyle = .fullScreen
        
        present(viewController, animated: true)
    }
    
    @objc override func postSettingButtonAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: postsTableView)
        guard let indexPath = postsTableView.indexPathForRow(at: point) else { return }
        
        let myProfile = SharedProfileModel.myProfile
        let myPosts = SharedPostModel.myPosts
        
        if myPosts[indexPath.row].userID == myProfile.userID {
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

    func editPostButtonAction(indexPath: IndexPath) {
        DispatchQueue.main.async {
            let notificationData: [IndexPath: Any] = [indexPath: "indexPath"]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PostEditingIsOn"), object: nil, userInfo: notificationData)
        }
        
        let viewController = UINavigationController(rootViewController: PostEditingViewController())
        
        viewController.hidesBottomBarWhenPushed = true
        viewController.modalPresentationStyle = .fullScreen

        present(viewController, animated: true)
    }

    func deletePostButtonAction(indexPath: IndexPath) {
        let myProfile = SharedProfileModel.myProfile
        let myPosts = SharedPostModel.myPosts
        
        if let userID = myProfile.userID {
            if let postIDForDelete = myPosts[indexPath.row].postID {
                
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
                
        cell.images = post.images
        cell.feedTextLabel.text = post.content

        cell.profileImageView.image = userProfile.profileImage
        cell.profileNameLabel.text = userProfile.profileName
        cell.userNameLabel.text = userProfile.userName
        cell.socialValidationImageView.isHidden = !(userProfile.socialValidation ?? false)

        cell.collectionView.reloadData()
        contentView.layoutIfNeeded()
        postsTableView.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

