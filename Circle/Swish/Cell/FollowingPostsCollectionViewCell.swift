//
//  FollowingPostsCollectionViewCell.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/30/23.
//

import UIKit
import SnapKit

protocol FollowingPostsTableViewCellDelegate: AnyObject {
    func didTapLikeButton(in cell: FollowingPostsTableViewCell)
    func didTaplikeStatusButton(in cell: FollowingPostsTableViewCell)
    func didTapMoreButton(in cell: FollowingPostsTableViewCell)
}

class BaseFollowingPostsTableViewCell: UITableViewCell {
    let feedbackGenerator = UISelectionFeedbackGenerator()
    weak var delegate: FollowingPostsTableViewCellDelegate?

    var contentViewList: [UIView] = []
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        return view
    }()
    
    let fakeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(white: 1, alpha: 0.75)
        imageView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    let profileNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    let socialValidationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.white
        imageView.isHidden = false
        imageView.image = UIImage(systemName: "checkmark.seal.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 12, weight: .light))
        return imageView
    }()
    
    let feedTextLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        
        if let image = UIImage(systemName: "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 19, weight: .medium)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.white
                
        return button
    }()
    
    let commentButton: UIButton = {
        let button = UIButton()
        
        if let image = UIImage(systemName: "message")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 17, weight: .medium)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.white
                
        return button
    }()
    
    let rewriteButton: UIButton = {
        let button = UIButton()
        
        if let image = UIImage(systemName: "arrow.2.squarepath")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 17, weight: .medium)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.white
                
        return button
    }()
    
    let massageButton: UIButton = {
        let button = UIButton()
        
        if let image = UIImage(systemName: "envelope")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 17, weight: .medium)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.white
                
        return button
    }()
    
    let moreButton: UIButton = {
        let button = UIButton()
        
        if let image = UIImage(systemName: "ellipsis")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.white
                
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        return label
    }()
    
    let likeStatusButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("좋아요 0", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)

        return button
    }()
    
    let centerDotLabel: UILabel = {
        let label = UILabel()
        
        label.text = " · "
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    let commentStatusButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("댓글 0", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)

        return button
    }()
    
    let locationStatusButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("location", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        return button
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: layout)
        collectionView.register(PostViewImageCollectionViewCell.self, forCellWithReuseIdentifier: "PostViewImageCollectionViewCell")
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()
    
    let loading: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var images: [UIImage]? {
        didSet {
            if let images = images, !images.isEmpty {
                if images.count != 1 {
                    collectionView.contentInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)

                    collectionView.snp.updateConstraints { make in
                        make.top.equalTo(feedTextLabel.snp.bottom)
                        make.bottom.equalTo(bottomView.snp.top).offset(-5)
                        make.leading.equalTo(0)
                        make.trailing.equalTo(0)
                        make.height.equalTo(200)
                    }
                    
                    feedTextLabel.snp.updateConstraints { make in
                        make.top.equalTo(profileNameLabel.snp.bottom).offset(5)
                        make.leading.equalTo(profileImageView).offset(50)
                        make.trailing.equalToSuperview().offset(-15)
                        make.bottom.equalTo(collectionView.snp.top).offset(-10)
                    }
                } else {
                    let image = images[0]
                    let screenWidth = collectionView.bounds.width  // 화면의 너비
                    
                    let aspectRatio = image.size.width / image.size.height
                    let cellWidth = min(image.size.width, screenWidth)
                    let cellHeight = cellWidth / aspectRatio
                    
                    collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

                    collectionView.snp.updateConstraints { make in
                        make.top.equalTo(feedTextLabel.snp.bottom)
                        make.bottom.equalTo(bottomView.snp.top).offset(-5)
                        make.leading.equalTo(60)
                        make.trailing.equalTo(-15)
                        make.height.equalTo(cellHeight) // 높이 값을 원하는 값으로 설정
                    }
                    
                    feedTextLabel.snp.updateConstraints { make in
                        make.top.equalTo(profileNameLabel.snp.bottom).offset(5)
                        make.leading.equalTo(profileImageView).offset(50)
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
                    make.top.equalTo(profileNameLabel.snp.bottom).offset(5)
                    make.leading.equalTo(profileImageView).offset(50)
                    make.trailing.equalToSuperview().offset(-15)
                    make.bottom.equalTo(collectionView.snp.top)
                }
                
                collectionView.isHidden = true
            }
            
            collectionView.reloadData()
            feedTextLabel.layoutIfNeeded()
            contentView.layoutIfNeeded()
        }
    }
    
    var likeAndCommentCount: (Int, Int)? {
        didSet {
            if let likeCount = likeAndCommentCount?.0, let commentCount = likeAndCommentCount?.1, likeCount > 0 && commentCount == 0 {
                bottomView.snp.updateConstraints { make in
                    make.bottom.equalToSuperview()
                    make.width.equalToSuperview()
                    make.height.equalTo(90)
                }
                
                likeButton.snp.updateConstraints { make in
                    make.centerY.equalTo(bottomView).offset(-22.5)
                    make.leading.equalTo(profileImageView).offset(48)
                    make.width.equalTo(23)
                }

                likeStatusButton.isHidden = false
                
                centerDotLabel.isHidden = true
                commentStatusButton.isHidden = true
            } else if let likeCount = likeAndCommentCount?.0, let commentCount = likeAndCommentCount?.1, likeCount == 0 && commentCount > 0 {
                bottomView.snp.updateConstraints { make in
                    make.bottom.equalToSuperview()
                    make.width.equalToSuperview()
                    make.height.equalTo(90)
                }
                
                likeButton.snp.updateConstraints { make in
                    make.centerY.equalTo(bottomView).offset(-22.5)
                    make.leading.equalTo(profileImageView).offset(48)
                    make.width.equalTo(23)
                }
                
                commentStatusButton.snp.removeConstraints()
    
                commentStatusButton.snp.updateConstraints { make in
                    make.top.equalTo(likeButton.snp.bottom).offset(10)
                    make.leading.equalTo(profileNameLabel)
                    make.width.equalTo(commentStatusButton.titleLabel!.snp.width)
                }

                commentStatusButton.isHidden = false
                
                centerDotLabel.isHidden = true
                likeStatusButton.isHidden = true
            } else if let likeCount = likeAndCommentCount?.0, let commentCount = likeAndCommentCount?.1, likeCount > 0 && commentCount > 0 {
                
                bottomView.snp.updateConstraints { make in
                    make.bottom.equalToSuperview()
                    make.width.equalToSuperview()
                    make.height.equalTo(90)
                }
                
                likeButton.snp.updateConstraints { make in
                    make.centerY.equalTo(bottomView).offset(-22.5)
                    make.leading.equalTo(profileImageView).offset(48)
                    make.width.equalTo(23)
                }
                
                commentStatusButton.snp.removeConstraints()
    
                commentStatusButton.snp.updateConstraints { make in
                    make.top.equalTo(likeButton.snp.bottom).offset(10)
                    make.leading.equalTo(centerDotLabel.snp.trailing)
                    make.width.equalTo(commentStatusButton.titleLabel!.snp.width)
                }

                likeStatusButton.isHidden = false
                centerDotLabel.isHidden = false
                commentStatusButton.isHidden = false
            } else if let likeCount = likeAndCommentCount?.0, let commentCount = likeAndCommentCount?.1, likeCount == 0 && commentCount == 0 {
                bottomView.snp.updateConstraints { make in
                    make.bottom.equalToSuperview().offset(-5)
                    make.width.equalToSuperview()
                    make.height.equalTo(45)
                }
                
                likeButton.snp.updateConstraints { make in
                    make.centerY.equalTo(bottomView)
                    make.leading.equalTo(profileImageView).offset(48)
                    make.width.equalTo(23)
                }

                likeStatusButton.isHidden = true
                centerDotLabel.isHidden = true
                commentStatusButton.isHidden = true
            }
            
            bottomView.layoutIfNeeded()
        }
    }
    
    func addOnContentView() {
        contentViewList = [profileImageView, profileNameLabel, userNameLabel, socialValidationImageView, moreButton, dateLabel, bottomView, feedTextLabel, locationStatusButton, loading]
        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }

        bottomView.addSubview(likeButton)
        bottomView.addSubview(commentButton)
        bottomView.addSubview(rewriteButton)
        bottomView.addSubview(massageButton)
        
        bottomView.addSubview(likeStatusButton)
        bottomView.addSubview(centerDotLabel)
        bottomView.addSubview(commentStatusButton)
    }
    
    func contentViewLayout() {

    }
}

class FollowingPostsTableViewCell: BaseFollowingPostsTableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addOnContentView()
        contentView.addSubview(collectionView)
        contentViewLayout()
        addOnTargets()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        collectionView.reloadData()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addOnTargets() {
        likeButton.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
        likeStatusButton.addTarget(self, action: #selector(likeStatusButtonAction), for: .touchUpInside)
        moreButton.addTarget(self, action: #selector(moreButtonAction), for: .touchUpInside)
    }
    
    @objc func likeButtonAction(button: UIButton) {
        if button.isSelected {
            if let image = UIImage(systemName: "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 19, weight: .medium)) {
                button.setImage(image, for: .normal)
            }
            likeButton.tintColor = .white
            button.isSelected = false
            delegate?.didTapLikeButton(in: self)
        } else {
            if let image = UIImage(systemName: "heart.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 19, weight: .medium)) {
                button.setImage(image, for: .normal)
            }
            likeButton.tintColor = .red
            button.isSelected = true
            delegate?.didTapLikeButton(in: self)
        }
    }
    
    @objc func likeStatusButtonAction(button: UIButton) {
        delegate?.didTaplikeStatusButton(in: self)
    }
    
    @objc func moreButtonAction(button: UIButton) {
        delegate?.didTapMoreButton(in: self)
    }
    
    override func contentViewLayout() {
        super.contentViewLayout()
        
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView).offset(-2.5)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(profileNameLabel)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(moreButton)
            make.trailing.equalTo(moreButton.snp.leading).offset(-10)
        }
        
        loading.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(profileNameLabel)
        }

        socialValidationImageView.snp.makeConstraints { make in
            make.centerY.equalTo(profileNameLabel)
            make.leading.equalTo(profileNameLabel.snp.trailing).offset(4)
        }
        
        feedTextLabel.snp.makeConstraints { make in
            make.top.equalTo(profileNameLabel.snp.bottom).offset(5)
            make.leading.equalTo(profileImageView).offset(50)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalTo(collectionView.snp.top)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(feedTextLabel.snp.bottom)
            make.leading.equalTo(60)
            make.trailing.equalTo(-15)
            make.bottom.equalTo(bottomView.snp.top).offset(-5)
            make.height.equalTo(200)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalToSuperview()
            make.height.equalTo(45)
        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView)
            make.leading.equalTo(profileImageView).offset(48)
            make.width.equalTo(23)
        }
        
        commentButton.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.leading.equalTo(likeButton.snp.trailing).offset(12)
            make.width.equalTo(23)
        }

        rewriteButton.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.leading.equalTo(commentButton.snp.trailing).offset(12)
            make.width.equalTo(23)
        }
        
        massageButton.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.leading.equalTo(rewriteButton.snp.trailing).offset(12)
            make.width.equalTo(23)
        }
        
        likeStatusButton.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(10)
            make.leading.equalTo(profileImageView).offset(48)
            make.width.equalTo(likeStatusButton.titleLabel!.snp.width)
        }
        
        centerDotLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeStatusButton)
            make.leading.equalTo(likeStatusButton.snp.trailing)
        }
        
        commentStatusButton.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(10)
            make.leading.equalTo(profileNameLabel)
            make.width.equalTo(commentStatusButton.titleLabel!.snp.width)
        }
    }
    
    func startLoading() {
        loading.startAnimating()
        dateLabel.isHidden = true
        moreButton.isHidden = true
        isUserInteractionEnabled = false
    }
    
    func stopLoading() {
        loading.stopAnimating()
        dateLabel.isHidden = false
        moreButton.isHidden = false
        isUserInteractionEnabled = true
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
        
        if let images = self.images, !images.isEmpty {
            cell.imageView.image = images[indexPath.row]
        } else {
            cell.imageView.image = nil
        }
        
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
            
//            collectionView.layoutIfNeeded()
//            contentView.layoutIfNeeded()

            return CGSize(width: cellWidth, height: cellHeight)
            
        }  else {
            let aspectRatio = image.size.width / image.size.height // 이미지의 가로 세로 비율
            let cellHeight: CGFloat = 200 // 셀의 높이 고정
            let cellWidth = cellHeight * aspectRatio // 이미지 비율을 유지한 너비 계산
            
            collectionView.snp.updateConstraints { make in
                make.height.equalTo(cellHeight)
            }
            
//            collectionView.layoutIfNeeded()
//            contentView.layoutIfNeeded()

            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
}

class spacingCell: UITableViewCell {
    let spacingView: UIImageView = {
        let view = UIImageView()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(spacingView)
        
        spacingView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
