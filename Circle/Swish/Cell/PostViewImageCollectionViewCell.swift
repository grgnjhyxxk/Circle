//
//  PostViewImageCollectionViewCell.swift
//  Circle
//
//  Created by Jaehyeok Lim on 11/19/23.
//

import UIKit

protocol PostViewImageCellDelegate: AnyObject {
    func deleteButtonTapped(cell: PostViewImageCollectionViewCell)
}

class PostViewImageCollectionViewCell: UICollectionViewCell {
    var deleteButtonAction: (() -> Void)?
    
    weak var delegate: PostViewImageCellDelegate?
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        imageView.layer.borderWidth = 1
        
        return imageView
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "xmark")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 10, weight: .heavy)), for: .normal)
        button.backgroundColor = UIColor(named: "BackgroundColor")
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 12.5
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(deleteButton)
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
  
        // 이미지 뷰의 크기를 이미지의 높이에 맞게 조정
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // 이미지 뷰를 셀의 모든 영역에 맞추어 표시
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(imageView).offset(10)
            make.trailing.equalTo(imageView).offset(-10)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        contentView.backgroundColor = UIColor.clear
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }

    @objc func deleteButtonTapped() {
        delegate?.deleteButtonTapped(cell: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
