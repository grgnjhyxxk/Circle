//
//  MainViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/12/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    private var viewList: [UIView] = []
    private var contentViewList: [UIView] = []
    
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()
    private var separator: UIView = IntroView().separator()
    private var spinningCirclesView = SpinningCirclesView()
    
    private let navigationTitleViewLabel: UILabel = IntroView().introMainTitleLabel()
    
    private var segmentedControl: UISegmentedControl = MainView().createSegmentedControl()
    
    let followingPostsTableView: UITableView = UITableView()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addOnView()
        viewLayout()
        addOnContentView()
        contentViewLayout()
        navigationBarLayout()
        addTargets()
        setupSwipeGesture()
        
        followingPostsTableView.dataSource = self
        followingPostsTableView.delegate = self

        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.followingPostsTableView.reloadData()
        }
    }
    
    private func addOnView() {
        viewList = [segmentedControl, separator, followingPostsTableView]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }
    
    private func viewLayout() {
        view.backgroundColor = UIColor.clear
        followingPostsTableView.backgroundColor = UIColor.black
        followingPostsTableView.refreshControl = refreshControl
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func addOnContentView() {
        followingPostsTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func contentViewLayout() {
        followingPostsTableView.register(FollowingPostsTableViewCell.self, forCellReuseIdentifier: "FollowingPostsTableViewCell")
        followingPostsTableView.register(FollowingPostsTableViewCell2.self, forCellReuseIdentifier: "FollowingPostsTableViewCell2")
    }
    
    private func navigationBarLayout() {
        let alarmBarButton = UIButton()
        let boltBarButton = UIButton()
        
        if let image = UIImage(systemName: "bell") {
            alarmBarButton.setImage(image, for: .normal)
        }
        
        if let image = UIImage(systemName: "bolt") {
            boltBarButton.setImage(image, for: .normal)
        }
        
        alarmBarButton.tintColor = UIColor.white
        boltBarButton.tintColor = UIColor.white
        alarmBarButton.contentHorizontalAlignment = .fill
        alarmBarButton.contentVerticalAlignment = .fill
        boltBarButton.contentHorizontalAlignment = .fill
        boltBarButton.contentVerticalAlignment = .fill
        
        alarmBarButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 27, height: 27))
        }
        
        boltBarButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 27, height: 27))
        }
        
        let righthStackview = UIStackView.init(arrangedSubviews: [boltBarButton, alarmBarButton])
        righthStackview.distribution = .equalSpacing
        righthStackview.axis = .horizontal
        righthStackview.alignment = .center
        righthStackview.spacing = 15
        
        let rightStackBarButtonItem = UIBarButtonItem(customView: righthStackview)
        
        spinningCirclesView.setCircleSizes(bigCircleSize: 18.5, smallCircleSize: 4.5, radius: 15.5)
        navigationTitleViewLabel.text = "Circles"
        navigationTitleViewLabel.font = UIFont(name: "PetitFormalScript-Regular", size: 28)
        
        navigationItem.rightBarButtonItem = rightStackBarButtonItem
        navigationItem.titleView = navigationTitleViewLabel
        
        followingPostsTableView.separatorInset.left = 0
    }
    
    private func setupSwipeGesture() {
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(_:)))
        swipeRightGesture.direction = .left
        self.view.addGestureRecognizer(swipeRightGesture)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
        swipeLeftGesture.direction = .right
        self.view.addGestureRecognizer(swipeLeftGesture)
    }
    
    private func addTargets() {
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    @objc private func swipeRight(_ gesture: UISwipeGestureRecognizer) {
        if segmentedControl.selectedSegmentIndex == 0 {
            segmentedControl.selectedSegmentIndex = 1
            segmentedControlValueChanged(segmentedControl)
        }
    }
    
    @objc private func swipeLeft(_ gesture: UISwipeGestureRecognizer) {
        if segmentedControl.selectedSegmentIndex == 1 {
            segmentedControl.selectedSegmentIndex = 0
            segmentedControlValueChanged(segmentedControl)
        }
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // "팔로우 중" 선택 시 처리
            break
        case 1:
            // "가입 서클" 선택 시 처리
            break
        default:
            break
        }
    }
    
    @objc private func refreshData() {
        SharedPostModel.othersPosts.removeAll()

        retrieveFirstFourPosts { error in
            if let error = error {
                print("Failed to retrieve all posts:", error.localizedDescription)
            } else {
                print("All posts retrieved successfully")
                
                DispatchQueue.main.async {
                    // Reload table view or perform any other UI updates here
                    self.followingPostsTableView.reloadData()
                    
                    // End refreshing after updating UI
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let boundsHeight = scrollView.bounds.size.height

        // 스크롤이 맨 아래로 도달했을 때 리프레쉬 실행
        if offsetY > contentHeight - boundsHeight {
            if !refreshControl.isRefreshing {
                refreshControl.beginRefreshing()

                retrieveNextFourPosts { error in
                    if let error = error {
                        print("Failed to retrieve all posts:", error.localizedDescription)
                    } else {
                        print("All posts retrieved successfully")
                        
                        DispatchQueue.main.async {
                            // Reload table view or perform any other UI updates here
                            self.followingPostsTableView.reloadData()
                            
                            // End refreshing after updating UI
                            self.refreshControl.endRefreshing()
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SharedPostModel.othersPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = SharedPostModel.othersPosts[indexPath.row]
        
        if post.images?.isEmpty == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingPostsTableViewCell2", for: indexPath) as! FollowingPostsTableViewCell2

            cell.feedTextLabel.text = post.content

            // 게시글 작성자의 프로필 정보 가져오기
            if let userID = post.userID,
               let userProfile = SharedProfileModel.postsProfile.first(where: { $0.userID == userID }) {
                cell.profileImageView.image = userProfile.profileImage
                cell.profileNameLabel.text = userProfile.profileName
                cell.userNameLabel.text = userProfile.userName
                cell.socialValidationImageView.isHidden = !(userProfile.socialValidation ?? false)
            }

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingPostsTableViewCell", for: indexPath) as! FollowingPostsTableViewCell

            cell.images = post.images
            cell.feedTextLabel.text = post.content

            // 게시글 작성자의 프로필 정보 가져오기
            if let userID = post.userID,
               let userProfile = SharedProfileModel.postsProfile.first(where: { $0.userID == userID }) {
                cell.profileImageView.image = userProfile.profileImage
                cell.profileNameLabel.text = userProfile.profileName
                cell.userNameLabel.text = userProfile.userName
                cell.socialValidationImageView.isHidden = !(userProfile.socialValidation ?? false)
            }

            cell.collectionView.reloadData()
            followingPostsTableView.layoutIfNeeded()

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
