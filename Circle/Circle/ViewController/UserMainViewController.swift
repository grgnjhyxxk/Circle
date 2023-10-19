//
//  UserMainViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/19/23.
//

import UIKit
import SnapKit

class UserMainViewController: UIViewController {

    private var viewList: [UIView] = []
    private var contentViewList: [UIView] = []
    
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()
    private let topView: UIView = UserMainView().topView()
    private var topViewBottomSeparator: UIView = IntroView().separator()
    
    private let profileNameTitleLabel: UILabel = UserMainView().profileNameTitleLabel()
    
    private let myCircleTitleLabel: UILabel = UserMainView().userMainStatusTitleLabel()
    private let inTheCircleTitleLabel: UILabel = UserMainView().userMainStatusTitleLabel()
    private let feedTitleLabel: UILabel = UserMainView().userMainStatusTitleLabel()

    private let myCircleDigitsLabel: UILabel = UserMainView().userMainStatusDigitsLabel()
    private let inTheCircleDigitsLabel: UILabel = UserMainView().userMainStatusDigitsLabel()
    private let feedDigitsLabel: UILabel = UserMainView().userMainStatusDigitsLabel()
    
    private let userNameTitleLabel: UILabel = UserMainView().userNameTitleLabel()
    private let introductionLabel: UILabel = UserMainView().introductionLabel()
    
    private let followerLabel: UILabel = UserMainView().userSubStatusTitleLabel()
    private let followingLabel: UILabel = UserMainView().userSubStatusTitleLabel()
    private let followerDigitsLabel: UILabel = UserMainView().userSubStatusDigitsLabel()
    private let followingDigitsLabel: UILabel = UserMainView().userSubStatusDigitsLabel()

    private let userProfileImageView: UIImageView = UserMainView().userProfileImageView()
    
    private let socialValidationMarkButton: UIButton = UserMainView().socialValidationMarkButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addOnView()
        viewLayout()
        addOnContentView()
        contentViewLayout()
        updateUI(with: userDataList[0])
    }

    private func addOnView() {
        viewList = [scrollView, topView, profileNameTitleLabel,
                    topViewBottomSeparator]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
        
        scrollView.addSubview(contentView)
    }

    private func viewLayout() {
        view.backgroundColor = UIColor.black
        scrollView.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1000)
        }
        
        topView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(90)
        }
        
        profileNameTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(topView)
            make.top.equalTo(topView).offset(55)
        }
        
        topViewBottomSeparator.snp.makeConstraints { make in
            make.leading.trailing.equalTo(topView)
            make.top.equalTo(topView.snp.bottom)
            make.height.equalTo(1)
        }
        
        topViewBottomSeparator.backgroundColor = UIColor.white.withAlphaComponent(0.05)
    }
    
    private func addOnContentView() {
        contentViewList = [userProfileImageView,
                           myCircleTitleLabel, inTheCircleTitleLabel, feedTitleLabel,
                           myCircleDigitsLabel, inTheCircleDigitsLabel, feedDigitsLabel,
                           userNameTitleLabel, introductionLabel,
                           followerLabel, followerDigitsLabel, followingLabel, followingDigitsLabel,
                           socialValidationMarkButton]
        
        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }
    }
    
    private func contentViewLayout() {
        userProfileImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(60)
            make.leading.equalTo(contentView).offset(25)
            make.size.equalTo(CGSize(width: 90, height: 90))
        }
        
        feedTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userProfileImageView).offset(10)
            make.trailing.equalTo(contentView).offset(-35)
        }
        
        feedDigitsLabel.snp.makeConstraints { make in
            make.centerX.equalTo(feedTitleLabel)
            make.centerY.equalTo(userProfileImageView).offset(-10)
        }
        
        inTheCircleTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userProfileImageView).offset(10)
            make.trailing.equalTo(feedTitleLabel.snp.leading).offset(-35)
        }
        
        inTheCircleDigitsLabel.snp.makeConstraints { make in
            make.centerX.equalTo(inTheCircleTitleLabel)
            make.centerY.equalTo(userProfileImageView).offset(-10)
        }
        
        myCircleTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userProfileImageView).offset(10)
            make.trailing.equalTo(inTheCircleTitleLabel.snp.leading).offset(-35)
        }
        
        myCircleDigitsLabel.snp.makeConstraints { make in
            make.centerX.equalTo(myCircleTitleLabel)
            make.centerY.equalTo(userProfileImageView).offset(-10)
        }
        
        userNameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(userProfileImageView.snp.bottom).offset(10)
            make.leading.equalTo(userProfileImageView)
        }
        
        introductionLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameTitleLabel.snp.bottom).offset(5)
            make.leading.equalTo(userNameTitleLabel)
            make.trailing.equalTo(contentView).offset(-25)
        }
        
        if introductionLabel.text == "" || introductionLabel.text == nil || introductionLabel.text == "nil" {
            followerLabel.snp.makeConstraints { make in
                make.top.equalTo(userNameTitleLabel.snp.bottom).offset(10)
                make.leading.equalTo(userNameTitleLabel)
            }
        } else if userNameTitleLabel.text == "" || userNameTitleLabel.text == nil || userNameTitleLabel.text == "nil" {
            followerLabel.snp.makeConstraints { make in
                make.top.equalTo(userProfileImageView.snp.bottom).offset(10)
                make.leading.equalTo(userProfileImageView)
            }
        } else {
            followerLabel.snp.makeConstraints { make in
                make.top.equalTo(introductionLabel.snp.bottom).offset(10)
                make.leading.equalTo(userNameTitleLabel)
            }
        }
        
        followerDigitsLabel.snp.makeConstraints { make in
            make.top.equalTo(followerLabel)
            make.leading.equalTo(followerLabel.snp.trailing).offset(5)
        }
        
        followingLabel.snp.makeConstraints { make in
            make.top.equalTo(followerDigitsLabel)
            make.leading.equalTo(followerDigitsLabel.snp.trailing).offset(25)
        }
        
        followingDigitsLabel.snp.makeConstraints { make in
            make.top.equalTo(followingLabel)
            make.leading.equalTo(followingLabel.snp.trailing).offset(5)
        }
        
        socialValidationMarkButton.snp.makeConstraints { make in
            make.leading.equalTo(userNameTitleLabel.snp.trailing).offset(5)
            make.centerY.equalTo(userNameTitleLabel)
            make.size.equalTo(CGSize(width: 17, height: 17))
        }
        
        myCircleTitleLabel.text = "마이 서클"
        inTheCircleTitleLabel.text = "인더 서클"
        feedTitleLabel.text = "게시물"
        followerLabel.text = "팔로워"
        followingLabel.text = "팔로잉"
    }
    
    func updateUI(with userData: UserData) {
        profileNameTitleLabel.text = userData.profileName
        userNameTitleLabel.text = userData.userName
        introductionLabel.text = userData.intrduction
        myCircleDigitsLabel.text = "\(userData.myCircleDigits)"
        inTheCircleDigitsLabel.text = "\(userData.inTheCircleDigits)"
        feedDigitsLabel.text = "\(userData.feedDigits)"
        followerDigitsLabel.text = "\(userData.followerDigits)"
        followingDigitsLabel.text = "\(userData.followingDigits)"
        
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
}
