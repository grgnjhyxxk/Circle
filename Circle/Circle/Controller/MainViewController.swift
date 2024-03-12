//
//  MainViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/12/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, FollowingPostsTableViewCellDelegate {
    
    private var viewList: [UIView] = []
    private var contentViewList: [UIView] = []
    
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()
    private var spinningCirclesView = SpinningCirclesView()
    private var tableHeaderView = UIView()
    
    private var appIcon = UILabel()
    
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

        followingPostsTableView.dataSource = self
        followingPostsTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if navigationController?.isNavigationBarHidden == false {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        
        DispatchQueue.main.async {
            self.followingPostsTableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if navigationController?.isNavigationBarHidden == true {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }

    private func addOnView() {
        viewList = [followingPostsTableView]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
        
        tableHeaderView.addSubview(appIcon)
        followingPostsTableView.tableHeaderView = tableHeaderView
    }
    
    private func viewLayout() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        followingPostsTableView.backgroundColor = UIColor(named: "BackgroundColor")
        followingPostsTableView.refreshControl = refreshControl
        followingPostsTableView.separatorInset.left = 0
        
        tableHeaderView.backgroundColor = UIColor(named: "BackgroundColor")
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func addOnContentView() {
        tableHeaderView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(80)
        }
        
        appIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        appIcon.text = "Swish"
        appIcon.font = UIFont(name: "pilgi", size: 44)
        followingPostsTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        spinningCirclesView.setCircleSizes(bigCircleSize: 20, smallCircleSize: 5, radius: 17)
    }
    
    private func contentViewLayout() {
        followingPostsTableView.register(FollowingPostsTableViewCell.self, forCellReuseIdentifier: "FollowingPostsTableViewCell")
    }
    
    @objc private func refreshData() {
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
    
    var isLoadingPosts = false

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let boundsHeight = scrollView.bounds.size.height

        let beforeCount = SharedPostModel.othersPosts.count

        // 스크롤이 맨 아래로 도달했을 때 리프레시 실행
        if offsetY > contentHeight - boundsHeight {
            if !isLoadingPosts && !refreshControl.isRefreshing {
                isLoadingPosts = true
                
                retrieveNextFourPosts { error in
                    if let error = error {
                        print("Failed to retrieve all posts:", error.localizedDescription)
                    } else {
                        let afterCount = SharedPostModel.othersPosts.count

                        if afterCount > beforeCount {
                            print("All posts retrieved successfully")

                            DispatchQueue.main.async {
                                self.followingPostsTableView.reloadData()
                                self.refreshControl.endRefreshing()
                            }
                        } else {
                            print("none...")
                        }
                    }
                    
                    self.isLoadingPosts = false
                }
            }
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SharedPostModel.othersPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = SharedPostModel.othersPosts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingPostsTableViewCell", for: indexPath) as! FollowingPostsTableViewCell
        
        cell.delegate = self

        cell.images = post.images
        cell.feedTextLabel.text = post.content

        // 게시글 작성자의 프로필 정보 가져오기
        if let userID = post.userID, let date = post.date, let like = post.like,
           let userProfile = SharedProfileModel.postsProfile.first(where: { $0.userID == userID }) {
            cell.profileImageView.image = userProfile.profileImage
            cell.profileNameLabel.text = userProfile.profileName
            cell.userNameLabel.text = userProfile.userName
            cell.dateLabel.text = formatPostTimestamp(date)
            cell.socialValidationImageView.isHidden = !(userProfile.socialValidation ?? false)
            let likeStatus = like.contains(userID)
            if likeStatus {
                if let image = UIImage(systemName: "heart.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 19, weight: .medium)) {
                    cell.likeButton.setImage(image, for: .normal)
                }
                cell.likeButton.tintColor = .red
                cell.likeButton.isSelected = true
                print(true)
            } else {
                if let image = UIImage(systemName: "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 19, weight: .medium)) {
                    cell.likeButton.setImage(image, for: .normal)
                }
                cell.likeButton.tintColor = .white
                cell.likeButton.isSelected = false
                print(false)
            }
        }
    
        cell.collectionView.reloadData()
        followingPostsTableView.layoutIfNeeded()
        
        return cell
    }
    
    func didTapLikeButton(in cell: FollowingPostsTableViewCell) {
        if let indexPath = followingPostsTableView.indexPath(for: cell) {
            var post = SharedPostModel.othersPosts[indexPath.row]

            if let userID = SharedProfileModel.myProfile.userID, var like = post.like {
                if like.contains(userID) {
                    // 이미 좋아요한 경우, 여기서 처리
                    like.removeAll { $0 == userID }
                    print("like removed")
                } else {
                    // 좋아요하지 않은 경우, 여기서 처리
                    like.append(userID)
                    print("like append")
                }
                post.like = like
                SharedPostModel.othersPosts[indexPath.row] = post
            }

            let feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator.selectionChanged()
            followingPostsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = PostViewerViewController()
    
        viewController.selectedIndex = indexPath.row
        viewController.images = SharedPostModel.othersPosts[indexPath.row].images
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
