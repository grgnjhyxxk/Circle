//
//  SearchInformationTableViewCell.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/21/23.
//

import UIKit
import SnapKit

class SearchInformationTableViewCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 22.5
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let profileNameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        return label
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)

        return label
    }()
    
    let socialValidationImageView: UIImageView = {
        let imageView = UIImageView()
    
        imageView.tintColor = UIColor.systemBlue
        imageView.isHidden = true

        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.black
        contentView.addSubview(profileImageView)
        contentView.addSubview(profileNameLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(socialValidationImageView)

        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(17.5)
            make.size.equalTo(CGSize(width: 45, height: 45))
        }
        profileNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-7.5)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        socialValidationImageView.snp.makeConstraints { make in
            make.centerY.equalTo(profileNameLabel)
            make.leading.equalTo(profileNameLabel.snp.trailing).offset(2)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(7.5)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

