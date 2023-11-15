//
//  BasicPostViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 11/5/23.
//

import UIKit
import SnapKit

class BasicPostViewController: UIViewController, UITextViewDelegate {
    var viewList: [UIView] = []
    var scrollViewList: [UIView] = []
    var contentViewList: [UIView] = []
    var bottomViewList: [UIView] = []

    let scrollView: UIScrollView = UIScrollView()
    let contentView: UIView = UIView()
    let bottomView = UserMainView.postView().bottomView()
    let bottomViewSeparator = IntroView().separator()
    
    let postTextView: UITextView = UserMainView.postView().postTextView()
    
    let postingBarButton: UIButton = UserMainView.postView().postingBarButton()
    var userProfileBarButton: UIButton = UserMainView.postView().userProfileBarButton()
    var voiceRecordingButton: UIButton = UserMainView.postView().voiceRecordingButton()
    var photoLibraryButton: UIButton = UserMainView.postView().photoLibraryButton()
    var locationButton: UIButton = UserMainView.postView().locationButton()
    var scopeOfDisclosureButton: UIButton = UserMainView.postView().scopeOfDisclosureButton()

    let circularProgressBar = CircularProgressBar()
    
    let maxCharacterLimit = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarLayout()
        addOnView()
        viewLayout()
        addOnBottomView()
        bottomViewLayout()
        addOnScrollView()
        scrollViewLayout()
        addOnContentView()
        contentViewLayout()
        registerForKeyboardNotifications()
        updateMainTextViewHeight()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        postTextView.becomeFirstResponder()
        postTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        postTextView.becomeFirstResponder()
    }
    
    func addOnView() {
        viewList = [scrollView, bottomView]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }
    
    func viewLayout() {
        view.backgroundColor = UIColor.black
        scrollView.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.black
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(bottomView.safeAreaLayoutGuide.snp.top)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    func addOnBottomView() {
        bottomViewList = [voiceRecordingButton, photoLibraryButton, locationButton, scopeOfDisclosureButton, bottomViewSeparator]
        
        for uiView in bottomViewList {
            bottomView.addSubview(uiView)
        }
    }
    
    func bottomViewLayout() {
        voiceRecordingButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(20)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        photoLibraryButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(voiceRecordingButton.snp.trailing).offset(20)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        locationButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(photoLibraryButton.snp.trailing).offset(20)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        scopeOfDisclosureButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-20)
            make.width.equalTo(scopeOfDisclosureButton.titleLabel!.snp.width).offset(30)
            make.height.equalTo(30)
        }
        
        bottomViewSeparator.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func addOnScrollView() {
        scrollViewList = [contentView]
        
        for uiView in scrollViewList {
            scrollView.addSubview(uiView)
        }
    }
    
    func scrollViewLayout() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(400)
        }
    }
    
    func addOnContentView() {
        contentViewList = [postTextView]
        
        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }
    }
    
    func contentViewLayout() {
        postTextView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        postTextView.isScrollEnabled = false
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func updateMainTextViewHeight() {
        // mainTextView의 크기를 현재 텍스트에 맞게 조정
        let fixedWidth = postTextView.frame.size.width
        let newSize = postTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        postTextView.snp.updateConstraints { make in
            make.height.equalTo(newSize.height)
        }
        view.layoutIfNeeded()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
        let size = CGSize(width: postTextView.frame.width, height: 1000)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
        
        contentView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    func navigationBarLayout() {
        
    }
    
    @objc func backButtonAction() {
        dismiss(animated: true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        bottomView.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-(keyboardHeight - 35))
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        bottomView.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
