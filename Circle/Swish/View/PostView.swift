//
//  PostView.swift
//  Circle
//
//  Created by Jaehyeok Lim on 3/10/24.
//

import UIKit

class PostView: UIView {
    func profileImageView() -> UIImageView {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(white: 1, alpha: 0.75)
        imageView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        imageView.layer.borderWidth = 1
        
        return imageView
    }
    
    func profileNameLabel() -> UILabel {
        let label = UILabel()
        
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }
    
    func socialValidationImageView() -> UIImageView {
        let imageView = UIImageView()
        
        imageView.tintColor = UIColor.white
        imageView.isHidden = false
        imageView.image = UIImage(systemName: "checkmark.seal.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 12, weight: .light))
        
        return imageView
    }
    
    func feedTextLabel() -> UILabel {
        let label = UILabel()
        
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        
        return label
    }
    
    func dateLabel() -> UILabel {
        let label = UILabel()
        
        label.text = ""
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        return label
    }
    
    func likeButton() -> UIButton {
        let button = UIButton()
        
        if let image = UIImage(systemName: "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 19, weight: .medium)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.white
        
        return button
    }

    func commentButton() -> UIButton {
        let button = UIButton()
        
        if let image = UIImage(systemName: "message")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 17, weight: .medium)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.white
        
        return button
    }

    func rewriteButton() -> UIButton {
        let button = UIButton()
        
        if let image = UIImage(systemName: "arrow.2.squarepath")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 17, weight: .medium)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.white
        
        return button
    }

    func massageButton() -> UIButton {
        let button = UIButton()
        
        if let image = UIImage(systemName: "envelope")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 17, weight: .medium)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.white
        
        return button
    }

    func moreButton() -> UIButton {
        let button = UIButton()
        
        if let image = UIImage(systemName: "ellipsis")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)) {
            button.setImage(image, for: .normal)
        }
        
        button.tintColor = UIColor.white
        
        return button
    }
    
    func bottomView() -> UIView {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        return view
    }
    
    func commetingView() -> UIView {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")

        return view
    }
    
    func commentingButton() -> UIButton {
        let button = UIButton()
        
        button.backgroundColor = UIColor(named: "SubBackgroundColor")
        button.layer.cornerRadius = 20
        
        return button
    }
    
    func commentingLabel() -> UILabel {
        let label = UILabel()
        
        label.text = ""
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return label
    }
    
    func placeholderLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "새로운 소식이 있나요?"
        label.textColor = UIColor.systemGray2
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        return label
    }
    
    func locationStatusButton() -> UIButton {
        let button = UIButton()
        
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.titleLabel?.numberOfLines = 0
    
        return button
    }
    
    func likeStatusButton() -> UIButton {
        let button = UIButton()
        
        button.setTitle("좋아요 0", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return button
    }

    func centerDotLabel() -> UILabel {
        let label = UILabel()
        
        label.text = " · "
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return label
    }

    func commentStatusButton() -> UIButton {
        let button = UIButton()
        
        button.setTitle("댓글 0", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return button
    }

}

