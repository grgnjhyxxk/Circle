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
        
        button.setTitle("프로필", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        button.titleLabel?.textAlignment = .left
        
        return button
    }
    
    func userProfileView() -> UIView {
        let view = UIView()
        
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 48
        
        return view
    }
    
    func socialValidationImageView() -> UIImageView {
        let imageView = UIImageView()
        
        imageView.tintColor = UIColor.white
        imageView.isHidden = false
        imageView.image = UIImage(systemName: "checkmark.seal.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 15, weight: .regular))

        return imageView
    }
    
    func socialValidationBackgroundImageView() -> UIImageView {
        let imageView = UIImageView()
        
        imageView.tintColor = UIColor(named: "BackgroundColor")
        imageView.isHidden = false
        imageView.image = UIImage(systemName: "checkmark.seal.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 21, weight: .regular))

        return imageView
    }
    
    func userProfileImageView() -> UIImageView {
        let imageView = UIImageView()
        
        imageView.image = UIImage()
        imageView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        imageView.layer.borderWidth = 1
        
        return imageView
    }
    
    func userProfileBackgroundImageView() -> UIImageView {
        let imageView = UIImageView()
        
        imageView.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }
    
    func userNameTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        
        return label
    }
    
    func profileNameTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
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
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        
        return label
    }
    
    func subStatusButton() -> UIButton {
        let button = UIButton()
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.textAlignment = .left
        
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
    
    func noPostsAvailableImageView() -> UIImageView {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "x.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 50, weight: .thin))
        imageView.tintColor =  UIColor.white.withAlphaComponent(0.85)
        
        return imageView
    }
    
    func noPostsAvailableLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "게시물 없음"
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        label.textColor = UIColor.white.withAlphaComponent(0.85)
        
        return label
    }
    
    func followButton() -> UIButton {
        let button = UIButton()
        
        button.setTitle("팔로우", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor

        return button
    }
    
    func mentionwButton() -> UIButton {
        let button = UIButton()
        
        button.setTitle("언급", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor

        return button
    }
    
    class MyProfileView: UIView {
        func profileEditButton() -> UIButton {
            let button = UIButton()
            
            button.setTitle("프로필 편집", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            button.titleLabel?.textAlignment = .center
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
            
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
            button.backgroundColor = UIColor(named: "BackgroundColor")
            
            return button
        }
        
        func editBackgroundImageButton() -> UIButton {
            let button = UIButton()
            
            button.setImage(UIImage(systemName: "camera.on.rectangle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)), for: .normal)
            button.tintColor = UIColor.white
            button.layer.cornerRadius = 19
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
            button.backgroundColor = UIColor(named: "BackgroundColor")
            
            return button
        }
        
        func editBackgroundColorButton() -> UIButton {
            let button = UIButton()
            
            button.setImage(UIImage(systemName: "paintbrush")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)), for: .normal)
            button.tintColor = UIColor.white
            button.layer.cornerRadius = 19
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
            button.backgroundColor = UIColor(named: "BackgroundColor")
            
            return button
        }
    }
    
    class postView: UIView {
        func postingBarButton() -> UIButton {
            let button = UIButton()
            
            button.setTitle("게시", for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            button.layer.cornerRadius = 15
            button.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            
            return button
        }
        
        func linkLineView() -> UIView {
            let view = UIView()
            
            view.backgroundColor = UIColor.darkGray
            view.layer.cornerRadius = 3
            
            return view
        }
        
        func linkLineLabel() -> UILabel {
            let label = UILabel()
            
            label.text = "포스트에 추가"
            label.textColor = UIColor.systemGray
            label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            
            return label
        }
        
        func linkLinProfileImageView() -> UIImageView {
            let imageView = UIImageView()
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.backgroundColor = UIColor(white: 1, alpha: 0.75)
            imageView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
            imageView.layer.borderWidth = 1
            
            return imageView
        }
        
        func userProfileBarButton() -> UIButton {
            let button = UIButton()
            var image = UIImage()
            
            if let profileImage = SharedProfileModel.myProfile.profileImage {
                image = profileImage
            }
            
            button.setImage(image, for: .normal)
            button.backgroundColor = UIColor.white.withAlphaComponent(0.1)
            button.layer.cornerRadius = 12.5
            button.layer.borderColor = UIColor.black.cgColor
            button.clipsToBounds = true
            button.contentMode = .scaleAspectFill
            
            return button
        }
        
        func postTextView() -> UITextView {
            let textView = UITextView()
            
            textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            textView.textColor = UIColor.white
            textView.backgroundColor = UIColor(named: "SubBackgroundColor_2")
            textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
            textView.isScrollEnabled = false
            textView.tintColor = UIColor.white

            return textView
        }
        
        func bottomView() -> UIView {
            let view = UIView()
            
            view.backgroundColor = UIColor(named: "SubBackgroundColor_2")
            
            return view
        }
        
        func voiceRecordingButton() -> UIButton {
            let button = UIButton()
            
            button.setImage(UIImage(systemName: "mic"), for: .normal)
            button.tintColor = UIColor.systemGray
            button.layer.cornerRadius = 15

            return button
        }
        
        func photoLibraryButton() -> UIButton {
            let button = UIButton()
            
            button.setImage(UIImage(systemName: "photo.on.rectangle.angled"), for: .normal)
            button.tintColor = UIColor.systemGray
            button.layer.cornerRadius = 15

            return button
        }
        
        func locationButton() -> UIButton {
            let button = UIButton()
            
            button.setImage(UIImage(systemName: "pin"), for: .normal)
            button.tintColor = UIColor.systemGray
            button.layer.cornerRadius = 15
            
            return button
        }
        
        func scopeOfDisclosureButton() -> UIButton {
            let button = UIButton()
            
            button.setImage(UIImage(systemName: "globe.asia.australia.fill"), for: .normal)
            button.setTitle("모두에게 공개", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
            button.tintColor = UIColor.white
            
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            button.semanticContentAttribute = .forceLeftToRight
            button.contentVerticalAlignment = .center
            button.contentHorizontalAlignment = .trailing
            
            return button
        }
        
        func locationNotiButton() -> UIButton {
            let button = UIButton()
            
            button.setImage(UIImage(systemName: "map"), for: .normal)
            button.setTitle("위치 추가", for: .normal)
            button.setTitleColor(UIColor.systemGray, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            button.tintColor = UIColor.systemGray
            
            button.semanticContentAttribute = .forceLeftToRight
            button.contentVerticalAlignment = .center
            button.contentHorizontalAlignment = .leading
            
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10) // 오른쪽으로의 간격
            
            return button
        }
        
        class SearchLocationView {
            func searchController() -> UISearchController {
                let searchController = UISearchController()
                
                searchController.searchBar.searchBarStyle = .minimal
                searchController.searchBar.searchTextField.textColor = .white
                searchController.searchBar.searchTextField.tintColor = .white
                searchController.searchBar.searchTextField.font = .systemFont(ofSize: 16, weight: .regular)
                searchController.searchBar.searchTextField.placeholder = "검색"
                
                return searchController
            }
        }
    }
}

