//
//  FollowingPostsCollectionViewCell.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/30/23.
//

import UIKit
import SnapKit

class BaseFollowingPostsTableViewCell: UITableViewCell {
    
    var contentViewList: [UIView] = []
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(white: 1, alpha: 0.75)
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
        imageView.tintColor = UIColor.systemBlue
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
        
        if let image = UIImage(systemName: "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.systemGray
                
        return button
    }()
    
    let likeDigitsButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("0", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                
        return button
    }()
    
    let commentButton: UIButton = {
        let button = UIButton()
        
        if let image = UIImage(systemName: "message")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.systemGray
                
        return button
    }()
    
    let commentDigitsButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("0", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                
        return button
    }()
    
    let rewriteButton: UIButton = {
        let button = UIButton()
        
        if let image = UIImage(systemName: "arrow.2.squarepath")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.systemGray
                
        return button
    }()
    
    let rewriteButtonDigitsButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("0", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                
        return button
    }()
    
    let savePostButton: UIButton = {
        let button = UIButton()
        
        if let image = UIImage(systemName: "square.and.arrow.down")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.systemGray
                
        return button
    }()
    
    let savePostButtonDigitsButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("0", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                
        return button
    }()
    
    let moreButton: UIButton = {
        let button = UIButton()
        
        if let image = UIImage(systemName: "ellipsis")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.systemGray
                
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        
        if let image = UIImage(systemName: "bookmark")?.withConfiguration(UIImage.SymbolConfiguration(weight: .regular)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.systemGray
                
        return button
    }()
    
    func addOnContentView() {
        contentViewList = [topView, bottomView, feedTextLabel]
        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }
        topView.addSubview(profileImageView)
        topView.addSubview(profileNameLabel)
        topView.addSubview(userNameLabel)
        topView.addSubview(socialValidationImageView)
        topView.addSubview(moreButton)

        bottomView.addSubview(likeButton)
        bottomView.addSubview(likeDigitsButton)
        bottomView.addSubview(commentButton)
        bottomView.addSubview(commentDigitsButton)
        bottomView.addSubview(rewriteButton)
        bottomView.addSubview(rewriteButtonDigitsButton)
        bottomView.addSubview(savePostButton)
        bottomView.addSubview(savePostButtonDigitsButton)
        bottomView.addSubview(saveButton)
        
        
        moreButton.addTarget(MyProfileViewController().self, action: #selector(MyProfileViewController().postSettingButtonAction), for: .touchUpInside)
    }
    
    func contentViewLayout() {
        // Layout constraints for common UI elements
    }
}

class FollowingPostsTableViewCell: BaseFollowingPostsTableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: layout)
        collectionView.register(PostViewImageCollectionViewCell.self, forCellWithReuseIdentifier: "PostViewImageCollectionViewCell")
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    var images: [UIImage]? {
        didSet {
            if let images = images, !images.isEmpty {
                collectionView.snp.updateConstraints { make in
                    make.height.equalTo(200) // 높이 값을 원하는 값으로 설정
                }
            } else {
                collectionView.snp.updateConstraints { make in
                    make.height.equalTo(0)
                }
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
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    override func contentViewLayout() {
        super.contentViewLayout()
        
        contentView.backgroundColor = UIColor.black
                
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(profileNameLabel)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(8)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }

        socialValidationImageView.snp.makeConstraints { make in
            make.centerY.equalTo(profileNameLabel)
            make.leading.equalTo(profileNameLabel.snp.trailing).offset(2)
        }
        
        feedTextLabel.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.equalTo(60)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalTo(collectionView.snp.top).offset(-7)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(feedTextLabel.snp.bottom).offset(10)
            make.leading.equalTo(60)
            make.trailing.equalTo(-15)
            make.bottom.equalTo(bottomView.snp.top)
            make.height.equalTo(200)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView)
            make.leading.equalTo(58)
            make.width.equalTo(23)
        }
        
        likeDigitsButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView)
            make.leading.equalTo(likeButton.snp.trailing).offset(0)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        commentButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView)
            make.leading.equalTo(likeDigitsButton.snp.trailing).offset(30)
            make.width.equalTo(23)
        }
        
        commentDigitsButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView)
            make.leading.equalTo(commentButton.snp.trailing).offset(0)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        rewriteButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView)
            make.leading.equalTo(commentDigitsButton.snp.trailing).offset(30)
            make.width.equalTo(23)
        }
        
        rewriteButtonDigitsButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView)
            make.leading.equalTo(rewriteButton.snp.trailing).offset(0)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        savePostButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView)
            make.leading.equalTo(rewriteButtonDigitsButton.snp.trailing).offset(30)
            make.width.equalTo(23)
        }
        
        savePostButtonDigitsButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView)
            make.leading.equalTo(savePostButton.snp.trailing).offset(0)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerY.equalTo(bottomView)
            make.trailing.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 18, height: 18))
        }

    }
}
