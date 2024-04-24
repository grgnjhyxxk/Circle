//
//  SearchInformationTableViewCell.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/21/23.
//

import UIKit
import SnapKit

protocol RecentSearchesTableViewCellDelegate: AnyObject {
    func didTapDeleteButton(in cell: RecentSearchesTableViewCell)
}

class BaseSearchTableViewCell: UITableViewCell {
    weak var delegate: RecentSearchesTableViewCellDelegate?

    var contentViewList: [UIView] = []
    
    let searchIconImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "magnifyingglass")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 15))
        imageView.tintColor = UIColor.systemGray
    
        return imageView
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "xmark")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 12)), for: .normal)
        button.tintColor = UIColor.systemGray
    
        return button
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
    
    let postSearchLabel: UILabel = {
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
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let socialValidationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.white
        imageView.isHidden = false
        imageView.image = UIImage(systemName: "checkmark.seal.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 12, weight: .light))
        return imageView
    }()
    
    let followButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("팔로우", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 7.5
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor

        return button
    }()
    
    let followLabel: UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)

        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SearchInformationTableViewCell: BaseSearchTableViewCell {
    func addOnContentView() {
        contentViewList = [profileImageView, profileNameLabel, userNameLabel, socialValidationImageView, followButton]
        
        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }
    }
    
    func contentViewLayout() {
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView)
            make.leading.equalTo(profileImageView).offset(50)
        }

        socialValidationImageView.snp.makeConstraints { make in
            make.centerY.equalTo(profileNameLabel)
            make.leading.equalTo(profileNameLabel.snp.trailing).offset(4)
        }
        
        followButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.trailing.equalTo(-15)
            make.width.equalTo((contentView.bounds.width / 2) - 42.5)
            make.height.equalTo(30)
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

class RecommendationsTableViewCell: BaseSearchTableViewCell {
    func addOnContentView() {
        contentViewList = [profileImageView, profileNameLabel, userNameLabel, socialValidationImageView, followButton, followLabel]
        
        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }
    }
    
    func contentViewLayout() {
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView)
            make.leading.equalTo(profileImageView).offset(50)
        }
        
        followLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(userNameLabel)
        }

        socialValidationImageView.snp.makeConstraints { make in
            make.centerY.equalTo(profileNameLabel)
            make.leading.equalTo(profileNameLabel.snp.trailing).offset(4)
        }
        
        followButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.trailing.equalTo(-15)
            make.width.equalTo((contentView.bounds.width / 2) - 42.5)
            make.height.equalTo(30)
        }
        
        followLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(userNameLabel)
            make.bottom.equalTo(-15)
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

class RecentSearchesTableViewCell: BaseSearchTableViewCell {
    func addOnContentView() {
        contentViewList = [searchIconImageView, postSearchLabel, profileImageView, profileNameLabel, userNameLabel, socialValidationImageView, followButton, deleteButton]
        
        for uiView in contentViewList {
            contentView.addSubview(uiView)
            uiView.isHidden = true
        }
    }
    
    func userSsearchSetting() {
        profileImageView.isHidden = false
        profileNameLabel.isHidden = false
        userNameLabel.isHidden = false
        deleteButton.isHidden = false
        socialValidationImageView.isHidden = false
        followButton.isHidden = true
        searchIconImageView.isHidden = true
        postSearchLabel.isHidden = true

        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView)
            make.leading.equalTo(profileImageView).offset(50)
        }
        
        socialValidationImageView.snp.makeConstraints { make in
            make.centerY.equalTo(profileNameLabel)
            make.leading.equalTo(profileNameLabel.snp.trailing).offset(4)
        }
        
        followButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.trailing.equalTo(-15)
            make.width.equalTo((contentView.bounds.width / 2) - 42.5)
            make.height.equalTo(30)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.trailing.equalTo(-15)
        }
    }
    
    func postSearchSetting() {
        searchIconImageView.isHidden = false
        postSearchLabel.isHidden = false
        deleteButton.isHidden = false
        profileImageView.isHidden = true
        profileNameLabel.isHidden = true
        userNameLabel.isHidden = true
        socialValidationImageView.isHidden = true
        followButton.isHidden = true
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        searchIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalTo(profileImageView)
        }
        
        postSearchLabel.snp.makeConstraints { make in
            make.centerY.equalTo(searchIconImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchIconImageView)
            make.trailing.equalTo(-15)
        }
    }
    
    func contentViewLayout() {
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    func addOnTargets() {
        deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
    }
    
    @objc func deleteButtonAction(button: UIButton) {
        delegate?.didTapDeleteButton(in: self)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addOnContentView()
        contentViewLayout()
        addOnTargets()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
