//
//  UserMainView.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/19/23.
//

import UIKit

class UserMainView: UIView {
    
    func topView() -> UIView {
        let view = UIView()
        
        view.backgroundColor = UIColor.black

        return view
    }
    
    func profileNameTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        
        return label
    }
    
    func userProfileImageView() -> UIImageView {
        let imageView = UIImageView()
        
        imageView.image = UIImage()
        imageView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        return imageView
    }
    
    func userNameTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        
        return label
    }
    
    func introductionLabel() -> UILabel {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        return label
    }
    
    func userMainStatusTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        
        return label
    }
    
    func userMainStatusDigitsLabel() -> UILabel {
        let label = UILabel()
        
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        
        return label
    }
    
    func userSubStatusTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        
        return label
    }
    
    func userSubStatusDigitsLabel() -> UILabel {
        let label = UILabel()
        
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        
        return label
    }
    
    func socialValidationMarkButton() -> UIButton {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        button.tintColor = UIColor.systemBlue
        
        return button
    }
    
    func selectMyPostFeedButton() -> UIButton {
        let button = UIButton()
        
        button.backgroundColor = UIColor.black
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.titleLabel?.textAlignment = .center
        
        // Add border to the bottom
        let border = CALayer()
        border.backgroundColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: button.frame.size.height - 1, width: button.frame.size.width, height: 1)
        button.layer.addSublayer(border)
        
        return button
    }
    
    func selectMyPostFeedButtonBottomBar() -> UIView {
        let view = UIView()
        
        view.backgroundColor = UIColor.white

        return view
    }
    
    class MyProfileView: UIView {
        
        func settingListButton() -> UIButton {
            let button = UIButton()
            
            button.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
            button.tintColor = UIColor.white
            button.contentHorizontalAlignment = .fill
            button.contentVerticalAlignment = .fill
            
            return button
        }
        
        func postingButton() -> UIButton {
            let button = UIButton()
            
            button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
            button.tintColor = UIColor.white
            button.contentHorizontalAlignment = .fill
            button.contentVerticalAlignment = .fill
            
            return button
        }
        
        func profileEditButton() -> UIButton {
            let button = UIButton()
            
            button.setTitle("프로필 편집", for: .normal)
            button.setTitleColor(UIColor.systemBlue, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
            button.titleLabel?.textAlignment = .center
            
            button.tintColor = UIColor.white.withAlphaComponent(0.85)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4.5, bottom: 0, right: 0)
            button.semanticContentAttribute = .forceRightToLeft
            button.contentVerticalAlignment = .center
            button.contentHorizontalAlignment = .leading
            
            return button
        }
    }
}

