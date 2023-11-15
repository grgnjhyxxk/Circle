//
//  PostingViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 11/14/23.
//

import UIKit

class PostingViewController: BasicPostViewController {
    override func navigationBarLayout() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), style: .done, target: self, action: #selector(backButtonAction))
        backButton.tintColor = UIColor.white
                
        postingBarButton.snp.makeConstraints { make in
            make.width.equalTo(postingBarButton.titleLabel!.snp.width).offset(52)
            make.height.equalTo(30)
        }
        
        userProfileBarButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 28, height: 28))
        }
          
        circularProgressBar.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        let righthStackview = UIStackView.init(arrangedSubviews: [userProfileBarButton, circularProgressBar, postingBarButton])
        righthStackview.distribution = .equalSpacing
        righthStackview.axis = .horizontal
        righthStackview.alignment = .center
        righthStackview.spacing = 15
        
        let rightStackBarButtonItem = UIBarButtonItem(customView: righthStackview)
                
        navigationItem.rightBarButtonItem = rightStackBarButtonItem
        navigationItem.leftBarButtonItem = backButton
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let updatedText = (textView.text as NSString?)?.replacingCharacters(in: range, with: text) ?? ""
        
        print(updatedText.count)
        
        let progress = min(1.0, CGFloat(updatedText.count) / CGFloat(maxCharacterLimit))
        circularProgressBar.updateProgress(to: progress)
        
        postingBarButton.isEnabled = (0...300).contains(updatedText.count)
        
        return true
    }
}
