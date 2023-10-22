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
    
    func userNameTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        
        return label
    }
    
    func userCategoryTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        
        return label
    }
    
    func introductionLabel() -> UILabel {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        
        return label
    }

    func subStatusButton() -> UIButton {
        let button = UIButton()

        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.tintColor = UIColor.white
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
}

