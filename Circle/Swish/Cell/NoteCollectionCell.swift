//
//  NoteCollectionCell.swift
//  Swish
//
//  Created by Jaehyeok Lim on 4/21/24.
//

import UIKit
import SnapKit

class NoteCollectionCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage()
        imageView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        imageView.layer.borderWidth = 1
        
        return imageView
    }()
    
    let profileNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        return label
    }()
    
    let noteImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "message.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 40))
        imageView.tintColor = UIColor.systemGray3
        
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(profileNameLabel)
        contentView.addSubview(noteImageView)
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        noteImageView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top).offset(-30)
            make.centerX.equalTo(imageView)
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
