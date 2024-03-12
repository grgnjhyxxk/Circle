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
}

class BaseFollowingPostsTableViewCell: UITableViewCell {
    let feedbackGenerator = UISelectionFeedbackGenerator()
    weak var delegate: FollowingPostsTableViewCellDelegate?

    var contentViewList: [UIView] = []
    
//    let topView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(named: "BackgroundColor")
//        return view
//    }()
    
    let bottomView: UIView = {
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
        
    func addOnContentView() {
        contentViewList = [profileImageView, profileNameLabel, userNameLabel, socialValidationImageView, moreButton, dateLabel, bottomView, feedTextLabel]
        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }

        bottomView.addSubview(likeButton)
        bottomView.addSubview(commentButton)
        bottomView.addSubview(rewriteButton)
        bottomView.addSubview(massageButton)
    }
    
    func contentViewLayout() {

    }
}

class FollowingPostsTableViewCell: BaseFollowingPostsTableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: layout)
        collectionView.register(PostViewImageCollectionViewCell.self, forCellWithReuseIdentifier: "PostViewImageCollectionViewCell")
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
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
                    collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

                    collectionView.snp.updateConstraints { make in
                        make.top.equalTo(feedTextLabel.snp.bottom)
                        make.bottom.equalTo(bottomView.snp.top).offset(-5)
                        make.leading.equalTo(60)
                        make.trailing.equalTo(-15)
                        make.height.equalTo(200) // 높이 값을 원하는 값으로 설정
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
            contentView.layoutIfNeeded()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addOnContentView()
        contentView.addSubview(collectionView)
        contentViewLayout()
        addOnTargets()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addOnTargets() {
        likeButton.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
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
    
    override func contentViewLayout() {
        super.contentViewLayout()
        
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView).offset(-5)
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
