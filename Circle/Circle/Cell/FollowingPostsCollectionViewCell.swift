//
//  FollowingPostsCollectionViewCell.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/30/23.
//

import UIKit
import SnapKit

class FollowingPostsCollectionViewCell: UITableViewCell {
    private var contentViewList: [UIView] = []
    
    let topView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.clear
        
        return view
    }()
    
    let middleView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.clear

        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.clear

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
        
        label.text = "cat"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "I'm a cat"
        label.textColor = UIColor.white
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
        
        label.text = "hello"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)

        return label
    }()
    
    private func addOnContentView() {
        contentViewList = [topView, middleView, bottomView, 
                           profileImageView, socialValidationImageView,
                           profileNameLabel, userNameLabel]
        
        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }
    }

    private func contentViewLayout() {
        topView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalTo(topView)
            make.leading.equalTo(topView).offset(10)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(topView).offset(-7.5)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        socialValidationImageView.snp.makeConstraints { make in
            make.centerY.equalTo(profileNameLabel)
            make.leading.equalTo(profileNameLabel.snp.trailing).offset(2)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(topView).offset(7.5)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        middleView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(200)
        }
//        
//        feedTextLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.leading.equalToSuperview().offset(10)
//            make.trailing.equalToSuperview().offset(-10)
//            make.height.equalTo(feedT)
//        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(middleView.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.bottom)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addOnContentView()
        contentViewLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
