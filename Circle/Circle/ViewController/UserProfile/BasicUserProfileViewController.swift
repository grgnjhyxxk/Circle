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
    var topViewBottomSeparator: UIView = IntroView().separator()
    
    var profileNameButton: UIButton = UserMainView().profileNameButton()
    
    var userNameTitleLabel: UILabel = UserMainView().userNameTitleLabel()
    var userCategoryTitleLabel: UILabel = UserMainView().userCategoryTitleLabel()
    var introductionLabel: UILabel = UserMainView().introductionLabel()
    
    var userProfileBackgroundImageView: UIImageView = UserMainView().userProfileBackgroundImageView()
    var userProfileImageView: UIImageView = UserMainView().userProfileImageView()
    
    var myPersonalPostsFeedButton: UIButton = UserMainView().selectMyPostFeedButton()
    var myCirclePostsFeedButton: UIButton = UserMainView().selectMyPostFeedButton()
    
    var myPersonalPostsFeedButtonBottomBar = UserMainView().selectMyPostFeedButtonBottomBar()
    var myCirclePostsButtonBottomBar = UserMainView().selectMyPostFeedButtonBottomBar()

    var profileEditButton: UIButton = UserMainView.MyProfileView().profileEditButton()
    
    var subStatusButton: UIButton = UserMainView().subStatusButton()
    
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
        navigationBarLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        uiViewUpdate()
        contentViewLayout()
    }
    
    func addOnView() {
        viewList = [userProfileBackgroundImageView, scrollView]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
        
        scrollView.addSubview(contentView)
    }
    
    func viewLayout() {
        view.backgroundColor = UIColor.black
        scrollView.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.black
        scrollView.refreshControl = refreshControl

        
        userProfileBackgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.top)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView).offset(120)
            make.leading.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1000)
        }
                
        scrollView.showsVerticalScrollIndicator = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func addOnContentView() {
        contentViewList = [userProfileImageView,
                           userNameTitleLabel, userCategoryTitleLabel, introductionLabel,
                           topViewBottomSeparator,
                           myPersonalPostsFeedButton, myCirclePostsFeedButton,
                           profileEditButton,
                           subStatusButton]
        
        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }
    }
    
    func contentViewLayout() {
        userProfileImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(-45)
            make.centerX.equalTo(contentView)
            make.size.equalTo(CGSize(width: 90, height: 90))
        }
        
        userNameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(userProfileImageView.snp.bottom).offset(5)
            make.centerX.equalTo(contentView)
        }
        
        userCategoryTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameTitleLabel.snp.bottom)
            make.centerX.equalTo(contentView)
        }
        
        introductionLabel.snp.makeConstraints { make in
            make.top.equalTo(userCategoryTitleLabel.snp.bottom)
            make.leading.equalTo(contentView).offset(50)
            make.trailing.equalTo(contentView).offset(-50)
        }
        
        subStatusButton.snp.makeConstraints { make in
            make.top.equalTo(introductionLabel.snp.bottom).offset(20)
            make.centerX.equalTo(contentView)
            make.width.equalTo(subStatusButton.titleLabel!.snp.width).offset(52)
            make.height.equalTo(30)
        }
        
        myPersonalPostsFeedButton.setTitle("게시물", for: .normal)
        myCirclePostsFeedButton.setTitle("서클 게시물", for: .normal)
        topViewBottomSeparator.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        myCirclePostsButtonBottomBar.isHidden = true
    }
    
    func addTargets() {
        myPersonalPostsFeedButton.addTarget(self, action: #selector(selectMyPostFeedButtonAction), for: .touchUpInside)
        myCirclePostsFeedButton.addTarget(self, action: #selector(selectMyPostFeedButtonAction), for: .touchUpInside)
        profileEditButton.addTarget(self, action: #selector(profileEdditButtonAction), for: .touchUpInside)
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
        
    @objc func profileEdditButtonAction() {
        
    }
    
    func navigationBarLayout() {

    }
}
