//
//  UserMainViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/19/23.
//

import UIKit
import SnapKit

class BasicUserProfileViewController: UIViewController {

    var viewList: [UIView] = []
    var contentViewList: [UIView] = []
    
    var scrollView: UIScrollView = UIScrollView()
    var contentView: UIView = UIView()
    var topView: UIView = UserMainView().topView()
    var topViewBottomSeparator: UIView = IntroView().separator()
    
    var profileNameTitleLabel: UILabel = UserMainView().profileNameTitleLabel()
    
    var myCircleTitleLabel: UILabel = UserMainView().userMainStatusTitleLabel()
    var inTheCircleTitleLabel: UILabel = UserMainView().userMainStatusTitleLabel()
    var feedTitleLabel: UILabel = UserMainView().userMainStatusTitleLabel()

    var myCircleDigitsLabel: UILabel = UserMainView().userMainStatusDigitsLabel()
    var myInTheCircleDigitsLabel: UILabel = UserMainView().userMainStatusDigitsLabel()
    var myPostDigitsLabel: UILabel = UserMainView().userMainStatusDigitsLabel()
    
    var userNameTitleLabel: UILabel = UserMainView().userNameTitleLabel()
    var introductionLabel: UILabel = UserMainView().introductionLabel()
    
    var followerLabel: UILabel = UserMainView().userSubStatusTitleLabel()
    var followingLabel: UILabel = UserMainView().userSubStatusTitleLabel()
    var followerDigitsLabel: UILabel = UserMainView().userSubStatusDigitsLabel()
    var followingDigitsLabel: UILabel = UserMainView().userSubStatusDigitsLabel()

    var userProfileImageView: UIImageView = UserMainView().userProfileImageView()
    
    var socialValidationMarkButton: UIButton = UserMainView().socialValidationMarkButton()
    var myPersonalPostsFeedButton: UIButton = UserMainView().selectMyPostFeedButton()
    var myCirclePostsFeedButton: UIButton = UserMainView().selectMyPostFeedButton()
    
    var myPersonalPostsFeedButtonBottomBar = UserMainView().selectMyPostFeedButtonBottomBar()
    var myCirclePostsButtonBottomBar = UserMainView().selectMyPostFeedButtonBottomBar()
    
    var settingListButton: UIButton = UserMainView.MyProfileView().settingListButton()
    var postingButton: UIButton = UserMainView.MyProfileView().postingButton()

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiViewUpdate()
        addOnView()
        viewLayout()
        mainViewSetting()
        addOnContentView()
        contentViewLayout()
        contentViewSetting()
        addTargets()
    }

    func addOnView() {
        viewList = [scrollView, topView,
                    profileNameTitleLabel,
                    settingListButton, postingButton]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
        
        scrollView.addSubview(contentView)
    }

    func viewLayout() {
        view.backgroundColor = UIColor.black
        scrollView.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.black
        
        topView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(90)
        }
        
        profileNameTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(topView)
            make.top.equalTo(topView).offset(55)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView).offset(-40)
            make.leading.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1000)
        }
        
        scrollView.refreshControl = refreshControl
    }
    
    func addOnContentView() {
        contentViewList = [userProfileImageView,
                           myCircleTitleLabel, inTheCircleTitleLabel, feedTitleLabel,
                           myCircleDigitsLabel, myInTheCircleDigitsLabel, myPostDigitsLabel,
                           userNameTitleLabel, introductionLabel,
                           followerLabel, followerDigitsLabel, followingLabel, followingDigitsLabel,
                           socialValidationMarkButton,
                           topViewBottomSeparator,
                           myPersonalPostsFeedButton, myCirclePostsFeedButton]
        
        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }
    }
    
    func contentViewLayout() {
        userProfileImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(60)
            make.leading.equalTo(contentView).offset(25)
            make.size.equalTo(CGSize(width: 90, height: 90))
        }
        
        feedTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userProfileImageView).offset(10)
            make.trailing.equalTo(contentView).offset(-35)
        }
        
        myPostDigitsLabel.snp.makeConstraints { make in
            make.centerX.equalTo(feedTitleLabel)
            make.centerY.equalTo(userProfileImageView).offset(-10)
        }
        
        inTheCircleTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userProfileImageView).offset(10)
            make.trailing.equalTo(feedTitleLabel.snp.leading).offset(-35)
        }
        
        myInTheCircleDigitsLabel.snp.makeConstraints { make in
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
        
        topViewBottomSeparator.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(followerDigitsLabel.snp.bottom).offset(15)
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
        
        topViewBottomSeparator.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        
        myCircleTitleLabel.text = "마이 서클"
        inTheCircleTitleLabel.text = "인더 서클"
        feedTitleLabel.text = "게시물"
        followerLabel.text = "팔로워"
        followingLabel.text = "팔로잉"
        myPersonalPostsFeedButton.setTitle("게시물", for: .normal)
        myCirclePostsFeedButton.setTitle("서클 게시물", for: .normal)
        
        myCirclePostsButtonBottomBar.isHidden = true
    }
    
    func addTargets() {
        myPersonalPostsFeedButton.addTarget(self, action: #selector(selectMyPostFeedButtonAction), for: .touchUpInside)
        myCirclePostsFeedButton.addTarget(self, action: #selector(selectMyPostFeedButtonAction), for: .touchUpInside)
        settingListButton.addTarget(self, action: #selector(settingListButtonAction), for: .touchUpInside)
    }
    
    func uiViewUpdate() {
        
    }
    
    func mainViewSetting() {
        
    }
    
    func contentViewSetting() {
        
    }
    
    @objc func selectMyPostFeedButtonAction(sender: UIButton) {
        if sender == myPersonalPostsFeedButton {
            myPersonalPostsFeedButtonBottomBar.isHidden = false
            myCirclePostsButtonBottomBar.isHidden = true
        } else {
            myCirclePostsButtonBottomBar.isHidden = false
            myPersonalPostsFeedButtonBottomBar.isHidden = true
        }
    }
    
    @objc func refreshData() {

    }
    
    @objc func settingListButtonAction() {
        
    }
}
