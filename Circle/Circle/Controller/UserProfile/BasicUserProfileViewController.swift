//
//  UserMainViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/19/23.
//

import UIKit
import SnapKit

class BasicUserProfileViewController: UIViewController, UIScrollViewDelegate {
    
    var viewList: [UIView] = []
    var contentViewList: [UIView] = []
    
    var contentView: UIView = UIView()
    var topViewBottomSeparator: UIView = IntroView().separator()
    
    var profileNameButton: UIButton = UserMainView().profileNameButton()
    
    var userNameTitleLabel: UILabel = UserMainView().userNameTitleLabel()
    var profileNameTitleLabel: UILabel = UserMainView().profileNameTitleLabel()
    var userCategoryTitleLabel: UILabel = UserMainView().userCategoryTitleLabel()
    var introductionLabel: UILabel = UserMainView().introductionLabel()
    
    var userProfileImageView: UIImageView = UserMainView().userProfileImageView()
    var socialValidationImageView: UIImageView = UserMainView().socialValidationImageView()
    var socialValidationBackgroundImageView: UIImageView = UserMainView().socialValidationBackgroundImageView()

    var profileEditButton: UIButton = UserMainView.MyProfileView().profileEditButton()
    var followButton: UIButton = UserMainView().followButton()
    var mentionButton: UIButton = UserMainView().mentionwButton()
    
    var subStatusButton: UIButton = UserMainView().subStatusButton()
    
    let postsTableView: UITableView = UITableView()
    
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
        print("didload")
        NotificationCenter.default.addObserver(self, selector: #selector(updatePost(_:)), name: NSNotification.Name(rawValue: "PostUpdated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfile(_:)), name: NSNotification.Name(rawValue: "ProfileUpdatedAndLayout"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        uiViewUpdate()
        contentViewLayout()
        
        DispatchQueue.main.async {
            self.postsTableView.reloadData()
            self.noPostsAvailableImageViewSetting()
        }
    }
    
    func addOnView() {
        viewList = [postsTableView]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }
    
    func viewLayout() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        postsTableView.backgroundColor = UIColor(named: "BackgroundColor")
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
        
        postsTableView.tableHeaderView = contentView
        postsTableView.refreshControl = refreshControl
        
        DispatchQueue.main.async {
            let labelHeight = self.heightForLabel(label: self.introductionLabel)
            
            self.contentView.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalTo(167 + labelHeight + 15)
            }
        }
        
        postsTableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(named: "BackgroundColor")
        navigationBarAppearance.shadowColor = .clear
        navigationBarAppearance.shadowImage = UIImage()
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    // 라벨의 높이를 계산하는 함수
    func heightForLabel(label: UILabel) -> CGFloat {
        let maxSize = CGSize(width: label.frame.width, height: CGFloat.greatestFiniteMagnitude)
        let expectedSize = label.sizeThatFits(maxSize)
        return expectedSize.height
    }
    
    func addOnContentView() {
        contentViewList = [userProfileImageView, socialValidationBackgroundImageView, socialValidationImageView,
                           userNameTitleLabel, userCategoryTitleLabel, introductionLabel, profileNameTitleLabel,
                           topViewBottomSeparator,
                           subStatusButton, profileEditButton, followButton, mentionButton]
        
        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }
    }
    
    func contentViewLayout() {
        userProfileImageView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.trailing.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        socialValidationImageView.snp.makeConstraints { make in
            make.bottom.equalTo(userProfileImageView).offset(-5)
            make.trailing.equalTo(userProfileImageView.snp.leading).offset(14)
        }
        
        socialValidationBackgroundImageView.snp.makeConstraints { make in
            make.center.equalTo(socialValidationImageView)
        }
        
        userNameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(userProfileImageView)
            make.leading.equalToSuperview().offset(15)
        }
        
        profileNameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(userNameTitleLabel)
        }
        
//        userCategoryTitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(userNameTitleLabel.snp.bottom)
//            make.centerX.equalTo(contentView)
//        }
        
        introductionLabel.snp.makeConstraints { make in
            make.top.equalTo(profileNameTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(userNameTitleLabel)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        subStatusButton.snp.makeConstraints { make in
            make.top.equalTo(introductionLabel.snp.bottom).offset(5)
            make.leading.equalTo(userNameTitleLabel)
            make.width.equalTo(subStatusButton.titleLabel!.snp.width)
            make.height.equalTo(subStatusButton.titleLabel!.snp.height)
        }
        
        profileEditButton.snp.makeConstraints { make in
            make.top.equalTo(subStatusButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(35)
        }
        
        followButton.snp.makeConstraints { make in
            make.top.equalTo(subStatusButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.width.equalTo((view.bounds.width / 2) - 22.5)
            make.height.equalTo(35)
        }
        
        mentionButton.snp.makeConstraints { make in
            make.top.equalTo(subStatusButton.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-15)
            make.width.equalTo((view.bounds.width / 2) - 22.5)
            make.height.equalTo(35)
        }
        
        topViewBottomSeparator.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(profileEditButton.snp.bottom).offset(20)
            make.height.equalTo(1)
        }
        
        topViewBottomSeparator.backgroundColor = UIColor.white.withAlphaComponent(0.05)
    }
    
    func addTargets() {
        profileEditButton.addTarget(self, action: #selector(profileEdditButtonAction), for: .touchUpInside)
    }
    
    func uiViewUpdate() {
        
    }
    
    func mainViewSetting() {
        
    }
    
    func contentViewSetting() {
        
    }
    
    func noPostsAvailableImageViewSetting() {
        
    }
    
    @objc func updatePost(_ notification: Notification) {
        DispatchQueue.main.async {
            self.postsTableView.reloadData()
        }
    }
    
    @objc func updateProfile(_ notification: Notification) {
        
    }
    
    @objc func refreshData() {
        
    }
    
    @objc func settingListButtonAction() {
        
    }
    
    @objc func postingButtonAction() {
        
    }
    
    @objc func profileEdditButtonAction() {
        
    }
    
    @objc func postSettingButtonAction(_ sender: UIButton) {
        
    }
    
    func navigationBarLayout() {
        
    }
//        
//    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
//        } else {
//            self.navigationController?.setNavigationBarHidden(false, animated: true)
//        }
//    }
}
