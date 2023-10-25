//
//  UserMainView.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/19/23.
//

import UIKit

class UserMainView: UIView {
    func profileNameButton() -> UIButton {
        let button = UIButton()
        
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.titleLabel?.textAlignment = .center

        return button
    }

    func userProfileImageView() -> UIImageView {
        let imageView = UIImageView()
        
        imageView.image = UIImage()
        imageView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        imageView.layer.cornerRadius = 45
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true

        return imageView
    }
    
    func userProfileBackgroundImageView() -> UIImageView {
        let imageView = UIImageView()
        
        imageView.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }
    
    func userNameTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .left
        
        return label
    }
    
    func userCategoryTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        label.textAlignment = .left
        label.text = "개발자"
        
        return label
    }
    
    func introductionLabel() -> UILabel {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        
        return label
    }

    func subStatusButton() -> UIButton {
        let button = UIButton()

        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.tintColor = UIColor.white
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        button.backgroundColor = UIColor.black
//        button.sizeToFit()

        return button
    }
    
    func selectMyPostFeedButton() -> UIButton {
        let button = UIButton()
        
        button.backgroundColor = UIColor.black
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.titleLabel?.textAlignment = .center
        
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
        func profileEditButton() -> UIButton {
            let button = UIButton()
            
            button.setTitle("편집", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            button.titleLabel?.textAlignment = .center
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
            button.backgroundColor = UIColor.black
            
            return button
        }
    }
    
    class EditProfileView: UIView {
        func editProfileImageButton() -> UIButton {
            let button = UIButton()
            
            button.setTitle("이미지 변경", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            button.titleLabel?.textAlignment = .center
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
            button.backgroundColor = UIColor.black
            
            return button
        }
        
        func editBackgroundImageButton() -> UIButton {
            let button = UIButton()
            
            button.setImage(UIImage(systemName: "camera.on.rectangle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)), for: .normal)
            button.tintColor = UIColor.white
            button.layer.cornerRadius = 19
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
            button.backgroundColor = UIColor.black
            
            return button
        }
        
        func editBackgroundColorButton() -> UIButton {
            let button = UIButton()
            
            button.setImage(UIImage(systemName: "paintbrush")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)), for: .normal)
            button.tintColor = UIColor.white
            button.layer.cornerRadius = 19
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
            button.backgroundColor = UIColor.black
            
            return button
        }
    }
}

