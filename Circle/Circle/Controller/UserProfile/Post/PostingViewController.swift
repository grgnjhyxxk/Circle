//
//  PostingViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 11/14/23.
//

import UIKit

class PostingViewController: BasicPostViewController {
    override func navigationBarLayout() {
        let cancelBarButton = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(cancelButtonAction))
        
        cancelBarButton.tintColor = UIColor.white
                
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
        navigationItem.leftBarButtonItem = cancelBarButton
    }
    
    override func addTagetsChild() {
        postingBarButton.addTarget(self, action: #selector(postingBarButtonAction), for: .touchUpInside)
    }
    
    @objc func postingBarButtonAction() {
        let righthStackview = UIStackView.init(arrangedSubviews: [userProfileBarButton, circularProgressBar, activityIndicator])
        righthStackview.distribution = .equalSpacing
        righthStackview.axis = .horizontal
        righthStackview.alignment = .center
        righthStackview.spacing = 15

        let rightStackBarButtonItem = UIBarButtonItem(customView: righthStackview)
        navigationItem.rightBarButtonItem = rightStackBarButtonItem

        // 작업 시작
        activityIndicator.startAnimating()

        // 포스팅 데이터 업로드 코드
        if let userID = SharedProfileModel.myProfile.userID, let content = postTextView.text {
            let time = currentDateTimeString()
            let location = selectedLocation ?? ""
            let postData = PostData(userID: userID, content: content, date: time, location: location)
            
            uploadPostData(postData: postData, images: selectedImages, userID: userID) { result in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating() // 작업 완료 후 인디게이터를 중지시킴

                    switch result {
                    case .success:
                        print("작업이 성공적으로 완료되었습니다.")
                        
                        SharedPostModel.myPosts.removeAll()
                        
                        retrieveMyPosts(userID: userID) { (error) in
                            if let error = error {
                                print("Error: \(error.localizedDescription)")
                            } else {
                                DispatchQueue.main.async {
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PostUpdated"), object: nil)
                                }
                                
                                self.dismiss(animated: true)
                            }
                        }
                    // 성공한 경우의 동작 처리
                    case .failure(let error):
                        print("작업이 실패했습니다. 에러: \(error.localizedDescription)")
                        // 실패한 경우의 동작 처리
                    }
                }
            }
        } else {
            // handle else case if needed
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let updatedText = (textView.text as NSString?)?.replacingCharacters(in: range, with: text) ?? ""
        
        print(updatedText.count)
        
        let progress = min(1.0, CGFloat(updatedText.count) / CGFloat(MAX_CHARACTER_LIMIT))
        circularProgressBar.updateProgress(to: progress)
        
        postingBarButton.isEnabled = (0...300).contains(updatedText.count)
        
        return true
    }
}
