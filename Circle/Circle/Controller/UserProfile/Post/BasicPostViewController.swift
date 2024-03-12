//
//  BasicPostViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 11/5/23.
//

import UIKit
import SnapKit
import MobileCoreServices

class BasicPostViewController: UIViewController, UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, SearchViewControllerDelegate, PostViewImageCellDelegate {
    
    let MAX_CHARACTER_LIMIT = 300
    
    var postIndexPathForEditing: Int?
    
    var viewList: [UIView] = []
    var scrollViewList: [UIView] = []
    var contentViewList: [UIView] = []
    var bottomViewList: [UIView] = []
    
    var selectedImages: [UIImage] = []
    var selectedLocation: String?
    
    let scrollView: UIScrollView = UIScrollView()
    let contentView: UIView = UIView()
    let bottomView = UserMainView.postView().bottomView()
    let bottomViewSeparator = IntroView().separator()
    
    let activityIndicator = SystemView().activityIndicator()
    
    let locationNotiButton = UserMainView.postView().locationNotiButton()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(PostViewImageCollectionViewCell.self, forCellWithReuseIdentifier: "PostViewImageCollectionViewCell")
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
        
        return collectionView
    }()
    
    let postTextView: UITextView = UserMainView.postView().postTextView()
    
    let postingBarButton: UIButton = UserMainView.postView().postingBarButton()
    let postEditingBarButton: UIButton = UserMainView.postView().postEditingBarButton()

    var userProfileBarButton: UIButton = UserMainView.postView().userProfileBarButton()
    var voiceRecordingButton: UIButton = UserMainView.postView().voiceRecordingButton()
    var photoLibraryButton: UIButton = UserMainView.postView().photoLibraryButton()
    var locationButton: UIButton = UserMainView.postView().locationButton()
    var scopeOfDisclosureButton: UIButton = UserMainView.postView().scopeOfDisclosureButton()

    let circularProgressBar = CircularProgressBar()
    
    let photoLibraryImagePicker: UIImagePickerController = {
        let photoLibraryImagePicker = UIImagePickerController()
        
        photoLibraryImagePicker.sourceType = .photoLibrary
        photoLibraryImagePicker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
        photoLibraryImagePicker.allowsEditing = true
        
        return photoLibraryImagePicker
    }()
    
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
        addTagets()
        addTagetsChild()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        postTextView.becomeFirstResponder()
        postTextView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        photoLibraryImagePicker.delegate = self
        scrollView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(PostEditingIsOn(_:)), name: NSNotification.Name(rawValue: "PostEditingIsOn"), object: nil)
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
        view.backgroundColor = UIColor(named: "BackgroundColor")
        scrollView.backgroundColor = UIColor(named: "BackgroundColor")
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
        
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
            make.height.equalTo(1000)
        }
    }
    
    func addOnContentView() {
        contentViewList = [postTextView, collectionView, locationNotiButton]
        
        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }
    }
    
    func contentViewLayout() {
        postTextView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(postTextView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(1)
        }
        
        locationNotiButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(locationNotiButton.titleLabel!.snp.width).offset(52)
            make.height.equalTo(30)
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
        let size = CGSize(width: postTextView.frame.width, height: 1000)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
        
        if selectedImages.count != 0 {
            contentView.constraints.forEach { (constraint) in
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height + collectionView.contentSize.height + 50
                }
            }
            
        } else {
            contentView.constraints.forEach { (constraint) in
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height + 70
                }
            }
        }
    }
    
    func navigationBarLayout() {
        
    }
    
    func addTagets() {
        photoLibraryButton.addTarget(self, action: #selector(photoLibraryButtonAction), for: .touchUpInside)
        locationButton.addTarget(self, action: #selector(locationButtonAction), for: .touchUpInside)
    }
    
    func addTagetsChild() {
        
    }
    
    @objc func PostEditingIsOn(_ notification: Notification) {
        if let indexPath = postIndexPathForEditing {
            postEditingSetting(indexPath: indexPath)
            print(indexPath)
        }
    }
    
    func postEditingSetting(indexPath: Int) {
        let myPost = SharedPostModel.myPosts
                
        if let postImages = myPost[indexPath].images {
            selectedImages = postImages
        }
            
        if let postContent = myPost[indexPath].content {
            postTextView.text = postContent
        }
        
        if let postLocation = myPost[indexPath].location {
        
        }
        
        DispatchQueue.main.async {
            let progress = min(1.0, CGFloat(self.postTextView.text.count) / CGFloat(self.MAX_CHARACTER_LIMIT))
            self.circularProgressBar.updateProgress(to: progress)
            self.collectionView.reloadData()
        }
    }
    
    @objc func photoLibraryButtonAction() {
        DispatchQueue.main.async {
            self.photoLibraryImagePicker.modalPresentationStyle = .overFullScreen
            
            self.present(self.photoLibraryImagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func locationButtonAction(button: UIButton) {
        let isSystemBlue = button.backgroundColor == UIColor.systemBlue
        
        button.backgroundColor = isSystemBlue ? UIColor.clear : UIColor.systemBlue
        
        let viewController = SearchViewController()
        viewController.delegate = self // 이 부분이 추가되었습니다.
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true)
    }

    func didSelectLocation(_ location: String) {
        selectedLocation = location
    }
    
    @objc func cancelButtonAction() {
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage { // 편집된 이미지 확인
            selectedImages.append(pickedImage)
        } else if let originalImage = info[.originalImage] as? UIImage { // 편집되지 않은 원본 이미지 확인
            selectedImages.append(originalImage)
        }
        
        collectionView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostViewImageCollectionViewCell", for: indexPath) as! PostViewImageCollectionViewCell
        
        cell.imageView.image = selectedImages[indexPath.row]
        
        let selectedImagesState = selectedImages.isEmpty
        
        cell.delegate = self
        
        photoLibraryButton.backgroundColor = selectedImagesState ? UIColor.clear : UIColor.systemBlue
        
        return cell
    }
    
    func deleteButtonTapped(cell: PostViewImageCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        selectedImages.remove(at: indexPath.row) // 데이터에서도 삭제를 해줘야 합니다.
        collectionView.performBatchUpdates({
            collectionView.deleteItems(at: [indexPath])
        }) { completed in
            if self.selectedImages.isEmpty {
                self.collectionView.snp.updateConstraints { make in
                    make.height.equalTo(10)
                }
            } else {
                if self.selectedImages.count == 1 {
                    self.collectionView.snp.updateConstraints { make in
                        make.height.equalTo(self.selectedImages[0].size.height)
                    }
                }
            }
        }
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = selectedImages[indexPath.row]
        let count = selectedImages.count
        let screenWidth = collectionView.bounds.width // 화면의 너비
        let screenHeight = UIScreen.main.bounds.height

        if count == 1 {
            // If there's only one image, display it in its original size
            let aspectRatio = image.size.width / image.size.height
            let cellWidth = min(image.size.width, screenWidth) // 이미지의 너비와 화면의 너비 중 작은 값 선택
            let cellHeight = cellWidth / aspectRatio // 이미지 비율을 유지한 높이 계산

            collectionView.snp.updateConstraints { make in
                make.height.equalTo(cellHeight)
            }
            
            let totalHeight = (screenHeight - (postTextView.bounds.height + cellHeight))
            
            contentView.snp.updateConstraints { make in
                make.height.equalTo(totalHeight)
            }
                        
            return CGSize(width: cellWidth, height: cellHeight)
        } else {
            // If there are multiple images, set the height to 200 and adjust the width proportionally
            let aspectRatio = image.size.width / image.size.height // 이미지의 가로 세로 비율
            let cellHeight: CGFloat = 200 // 셀의 높이 고정
            let cellWidth = cellHeight * aspectRatio // 이미지 비율을 유지한 너비 계산
            
            let zero_image = selectedImages[0]
            let zero_aspectRatio = zero_image.size.width / zero_image.size.height
            let zero_cellWidth = min(zero_image.size.width, screenWidth) // 이미지의 너비와 화면의 너비 중 작은 값 선택
            let zero_cellHeight = zero_cellWidth / zero_aspectRatio // 이미지 비율을 유지한 높이 계산
            
            collectionView.snp.updateConstraints { make in
                make.height.equalTo(cellHeight)
            }
            
            let totalHeight = (screenHeight - (postTextView.bounds.height + zero_cellHeight))
            
            contentView.snp.updateConstraints { make in
                make.height.equalTo(totalHeight)
            }
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewMaxY = scrollView.contentSize.height - scrollView.bounds.height
        
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            postTextView.endEditing(false) // 위로 스크롤할 때, 키보드 보이기
        } else if scrollView.contentOffset.y <= 0 {
            postTextView.endEditing(true) // 스크롤뷰가 맨 위에 도달했을 때, 키보드 숨기기
        } else if scrollView.contentOffset.y >= scrollViewMaxY {
            postTextView.endEditing(false) // 스크롤뷰가 맨 아래에 도달했을 때, 키보드 보이기
        }
    }
}
