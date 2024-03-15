//
//  PostViewerViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 2/16/24.
//

import UIKit
import SnapKit

class PostViewerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var selectedIndex: Int?

    var viewList: [UIView] = []
    var headerViewList: [UIView] = []
    var bottomViewList: [UIView] = []
    var headerView: UIView = UIView()
    var bottomView: UIView = PostView().bottomView()
    var separator: UIView = IntroView().separator()
        
    var tableView = UITableView()

    var profileImageView: UIImageView = PostView().profileImageView()
    var socialValidationImageView: UIImageView = PostView().socialValidationImageView()

    var profileNameLabel: UILabel = PostView().profileNameLabel()
    var feedTextLabel: UILabel = PostView().feedTextLabel()
    var dateLabel: UILabel = PostView().dateLabel()
    
    let likeButton: UIButton = PostView().likeButton()
    let commentButton: UIButton = PostView().commentButton()
    let rewriteButton: UIButton = PostView().rewriteButton()
    let massageButton: UIButton = PostView().massageButton()
    let moreButton: UIButton = PostView().moreButton()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: headerView.bounds, collectionViewLayout: layout)
        collectionView.register(PostViewImageCollectionViewCell.self, forCellWithReuseIdentifier: "PostViewImageCollectionViewCell")
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    var images: [UIImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addOnView()
        viewLayout()
        addOnHeaderView()
        addOnBottomView()
        headerViewLayout()
        navigationBarLayout()
        uiViewSetting()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func addOnView() {
        viewList = [headerView]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }
    
    private func viewLayout() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        headerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(named: "BackgroundColor")
        navigationBarAppearance.shadowColor = .clear
        navigationBarAppearance.shadowImage = UIImage()
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    private func addOnHeaderView() {
        headerViewList = [bottomView, collectionView, separator,
                          profileImageView, socialValidationImageView,
        profileNameLabel, feedTextLabel, dateLabel,
        moreButton]
        
        for uiView in headerViewList {
            headerView.addSubview(uiView)
        }
    }
    
    private func addOnBottomView() {
        bottomViewList = [likeButton, commentButton, rewriteButton, massageButton]
        
        for uiView in bottomViewList {
            bottomView.addSubview(uiView)
        }
    }
    
    private func headerViewLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.centerY.equalTo(profileImageView)
        }
        
        socialValidationImageView.snp.makeConstraints { make in
            make.centerY.equalTo(profileNameLabel)
            make.leading.equalTo(profileNameLabel.snp.trailing).offset(4)
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalTo(-15)
            make.top.equalTo(profileNameLabel)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(moreButton)
            make.trailing.equalTo(moreButton.snp.leading).offset(-10)
        }
        
        if let images = images, !images.isEmpty {
            if images.count != 1 {
                collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)

                collectionView.snp.updateConstraints { make in
                    make.top.equalTo(feedTextLabel.snp.bottom)
                    make.bottom.equalTo(bottomView.snp.top)
                    make.leading.equalTo(0)
                    make.trailing.equalTo(0)
                    make.height.equalTo(200)
                }
                
                feedTextLabel.snp.updateConstraints { make in
                    make.top.equalTo(profileImageView.snp.bottom).offset(10)
                    make.leading.equalTo(profileImageView)
                    make.trailing.equalToSuperview().offset(-15)
                    make.bottom.equalTo(collectionView.snp.top).offset(-10)
                }
            } else {
                collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

                collectionView.snp.updateConstraints { make in
                    make.top.equalTo(feedTextLabel.snp.bottom)
                    make.bottom.equalTo(bottomView.snp.top)
                    make.leading.equalTo(15)
                    make.trailing.equalTo(-15)
                    make.height.equalTo(200) // 높이 값을 원하는 값으로 설정
                }
                
                feedTextLabel.snp.updateConstraints { make in
                    make.top.equalTo(profileImageView.snp.bottom).offset(10)
                    make.leading.equalTo(profileImageView)
                    make.trailing.equalToSuperview().offset(-15)
                    make.bottom.equalTo(collectionView.snp.top).offset(-10)
                }
            }
            
            collectionView.isHidden = false
            
        } else {
            collectionView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            
            feedTextLabel.snp.updateConstraints { make in
                make.top.equalTo(profileImageView).offset(10)
                make.leading.equalTo(profileImageView)
                make.trailing.equalToSuperview().offset(-15)
                make.bottom.equalTo(collectionView.snp.top)
            }
            
            collectionView.isHidden = true
        }

        collectionView.reloadData()
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(55)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView)
            make.leading.equalTo(profileImageView)
            make.width.equalTo(23)
        }
        
        commentButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView)
            make.leading.equalTo(likeButton.snp.trailing).offset(12)
            make.width.equalTo(23)
        }

        rewriteButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView)
            make.leading.equalTo(commentButton.snp.trailing).offset(12)
            make.width.equalTo(23)
        }
        
        massageButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView)
            make.leading.equalTo(rewriteButton.snp.trailing).offset(12)
            make.width.equalTo(23)
        }
    }
    
    private func uiViewSetting() {
        if let index = selectedIndex {
            let post = SharedPostModel.othersPosts[index]
            if let userID = post.userID, let date = post.date, let userProfile = SharedProfileModel.postsProfile.first(where: { $0.userID == userID }) {
                self.profileImageView.image = userProfile.profileImage
                self.profileNameLabel.text = userProfile.profileName
                self.dateLabel.text = formatPostTimestamp(date)
                self.feedTextLabel.text = post.content
                print(self.feedTextLabel.text)
                
            }
        }
    }
    
    private func uiViewUpdate() {
        
    }
    
    func navigationBarLayout() {
        self.navigationController?.navigationBar.topItem?.title = "뒤로"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.title = "포스트"
    }
    
    @objc func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let images = images {
            return images.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostViewImageCollectionViewCell", for: indexPath) as? PostViewImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.imageView.image = images![indexPath.row]
        cell.deleteButton.isHidden = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = images![indexPath.row]
        let count = images!.count
        let screenWidth = collectionView.bounds.width  // 화면의 너비
        
        if count == 1 {
            let aspectRatio = image.size.width / image.size.height
            let cellWidth = min(image.size.width, screenWidth)
            let cellHeight = cellWidth / aspectRatio

            collectionView.snp.updateConstraints { make in
                make.height.equalTo(cellHeight)
            }
            
            collectionView.layoutIfNeeded()
            
            return CGSize(width: cellWidth, height: cellHeight)
            
        }  else {
            let aspectRatio = image.size.width / image.size.height // 이미지의 가로 세로 비율
            let cellHeight: CGFloat = 200 // 셀의 높이 고정
            let cellWidth = cellHeight * aspectRatio // 이미지 비율을 유지한 너비 계산
            
            collectionView.snp.updateConstraints { make in
                make.height.equalTo(cellHeight)
            }
            
            collectionView.layoutIfNeeded()
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
}
