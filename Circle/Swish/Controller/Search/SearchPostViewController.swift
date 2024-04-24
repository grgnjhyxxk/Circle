//
//  SearchPostViewController.swift
//  Swish
//
//  Created by Jaehyeok Lim on 4/15/24.
//

import UIKit

class SearchPostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 마지막 섹션과 마지막 행에 해당하는지 확인
        let lastSection = tableView.numberOfSections - 1
        let lastRow = tableView.numberOfRows(inSection: lastSection) - 1
        
        if indexPath.section == lastSection && indexPath.row == lastRow {
            // 마지막 셀인 경우에만 세퍼레이터를 없앰
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        } else {
            // 마지막 셀이 아닌 경우 기본 세퍼레이터를 설정
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // 또는 원하는 여백으로 설정
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SharedPostModel.searchPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = SharedPostModel.searchPosts[indexPath.row]
        let myProfile = SharedProfileModel.myProfile
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowingPostsTableViewCell", for: indexPath) as! FollowingPostsTableViewCell
        
        cell.images = post.images
        cell.feedTextLabel.text = post.content
        
        // 게시글 작성자의 프로필 정보 가져오기
        if let userID = post.userID, let myID = myProfile.userID, let date = post.date, let like = post.like, let comment = post.comments, let _ = post.location {
            if post.userID == myID {
                cell.profileImageView.image = myProfile.profileImage
                cell.profileNameLabel.text = myProfile.profileName
                cell.userNameLabel.text = myProfile.userName
                cell.dateLabel.text = formatPostTimestamp(date)
                cell.socialValidationImageView.isHidden = !(myProfile.socialValidation ?? false)
            } else {
                if let userProfile = SharedProfileModel.searchPostsProfiles.first(where: { $0.userID == userID }) {
                    cell.profileImageView.image = userProfile.profileImage
                    cell.profileNameLabel.text = userProfile.profileName
                    cell.userNameLabel.text = userProfile.userName
                    cell.dateLabel.text = formatPostTimestamp(date)
                    cell.socialValidationImageView.isHidden = !(userProfile.socialValidation ?? false)
                }
            }
            
            cell.likeAndCommentCount = (like.count, comment)
            
            let likeStatus = like.contains(myID)
            
            if likeStatus {
                if let image = UIImage(systemName: "heart.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 19, weight: .medium)) {
                    cell.likeButton.setImage(image, for: .normal)
                }
                cell.likeButton.tintColor = .red
                cell.likeButton.isSelected = true
            } else {
                if let image = UIImage(systemName: "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 19, weight: .medium)) {
                    cell.likeButton.setImage(image, for: .normal)
                }
                cell.likeButton.tintColor = .white
                cell.likeButton.isSelected = false
            }
            
            //            cell.likeAndCommentCount = (like.count, comment)
            cell.likeStatusButton.setTitle("좋아요 \(like.count)", for: .normal)
            cell.commentStatusButton.setTitle("댓글 \(comment)", for: .normal)
        }
        
        //        cell.collectionView.reloadData()
        //        tableView.layoutIfNeeded()
        
        return cell
    }
    
    private var viewList: [UIView] = []
    
    private let tableView: UITableView = {
        let view = UITableView()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.register(FollowingPostsTableViewCell.self, forCellReuseIdentifier: "FollowingPostsTableViewCell")
        
        return view
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        return view
    }()
    
    private let loading = UIActivityIndicatorView()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController()
        
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.searchTextField.placeholder = "검색"
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.searchTextField.autocapitalizationType = .none
        searchController.searchBar.searchTextField.backgroundColor = UIColor(named: "SubBackgroundColor")
        searchController.searchBar.setValue("닫기", forKey: "cancelButtonText")
        
        return searchController
    }()
    
    var searchquery: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarLayout()
        addOnView()
        viewLayout()
        network()
        
        if let searchquery = searchquery {
            searchController.searchBar.text = searchquery
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    private func addOnView() {
        viewList = [tableView, loading]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }
        
    private func viewLayout() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        tableView.tableHeaderView = headerView

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loading.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        loading.startAnimating()
    }
    
    private func navigationBarLayout() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(named: "BackgroundColor")
        navigationBarAppearance.shadowColor = .clear
        navigationBarAppearance.shadowImage = UIImage()
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance

        navigationItem.searchController = searchController
        definesPresentationContext = true
//        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "검색 결과"
    }
    
    private func network() {
        SharedPostModel.searchPosts = []
        
        if let searchquery = self.searchquery {
            retrievePostsRelatedToSearch(searchquery) { error in
                print("\(searchquery)와 연관성있는 포스트 찾기 실행")
                if let error = error {
                    print("Error retrieving posts related to search: \(error.localizedDescription)")
                    self.loading.stopAnimating()
                } else {
                    print("Posts related to search retrieved successfully.")
                    print(SharedPostModel.searchPosts.count)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.loading.stopAnimating()
                        self.loading.isHidden = true
                        
                        DispatchQueue.main.async {
                            // 테이블 뷰를 업데이트
                            self.tableView.reloadData()
                        }
                        
                        self.tableView.reloadData()
                        self.tableView.layoutIfNeeded()
                    }
                }
            }
        }
    }
}
