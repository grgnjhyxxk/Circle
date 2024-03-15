//
//  SearchLocationTableViewCell.swift
//  Circle
//
//  Created by Jaehyeok Lim on 11/16/23.
//

import UIKit

class SearchLocationTableViewCell: UITableViewCell {
    let countryLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGray
        
        return label
    }()
    
    let checkButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        button.tintColor = UIColor.systemBlue
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(countryLabel)
        contentView.addSubview(checkButton)
        
        countryLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(45)
        }
        
        checkButton.snp.makeConstraints { make in
            make.centerY.equalTo(countryLabel)
            make.trailing.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        checkButton.isHidden = true
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
