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
        label.textAlignment = .natural
        
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
}

