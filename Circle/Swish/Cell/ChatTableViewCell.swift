//
//  ChatTableViewCell.swift
//  Swish
//
//  Created by Jaehyeok Lim on 4/21/24.
//

import UIKit
import SnapKit

class ChatTableViewCell: UITableViewCell {
    let chatUserProfileImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage()
        imageView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        imageView.layer.borderWidth = 1
        
        return imageView
    }()
    
    let chatUserProfileNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        return label
    }()

    let chatTextLabel: UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        return label
    }()
    
    let chatDateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "10시간"
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        return label
    }()
    
    let centerDotLabel: UILabel = {
        let label = UILabel()
        
        label.text = " · "
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(chatUserProfileImageView)
        contentView.addSubview(chatUserProfileNameLabel)
        contentView.addSubview(chatTextLabel)
        contentView.addSubview(chatDateLabel)
        contentView.addSubview(centerDotLabel)
        
        chatUserProfileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(15)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        chatUserProfileNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(chatUserProfileImageView.snp.trailing).offset(10)
            make.centerY.equalToSuperview().offset(-10)
        }
        
        chatDateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-15)
            make.centerY.equalToSuperview().offset(10)
        }
        
        centerDotLabel.snp.makeConstraints { make in
            make.trailing.equalTo(chatDateLabel.snp.leading)
            make.centerY.equalToSuperview().offset(10)
        }
        
        chatTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(chatUserProfileImageView.snp.trailing).offset(10)
            make.trailing.equalTo(centerDotLabel.snp.leading).offset(-2)
            make.centerY.equalToSuperview().offset(10)
        }
        
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
