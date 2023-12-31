//
//  EditPorfileViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/24/23.
//

import UIKit
import SnapKit

class EditProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private var viewList: [UIView] = []
    private var contentViewList: [UIView] = []
    private let tableViewTitleLabelStringList: [String] = ["프로필 이름", 
                                                           "사용자 이름",
                                                           "자기소개",
                                                           "성별",
                                                           "생년월일",
                                                           "이메일",
                                                           "전화번호"]
    
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()
    private let tableView: UITableView = UITableView()
    
    private var userProfileBackgroundImageView: UIImageView = UserMainView().userProfileBackgroundImageView()
    private var userProfileImageView: UIImageView = UserMainView().userProfileImageView()
    
    private let editProfileImageButton = UserMainView.EditProfileView().editProfileImageButton()
    private let editBackgroundImageButton = UserMainView.EditProfileView().editBackgroundImageButton()
    private let editBackgroundColorButton = UserMainView.EditProfileView().editBackgroundColorButton()
    
    let profileImagePicker = UIImagePickerController()
    let backgroundImagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarLayout()
        addOnView()
        viewLayout()
        addOnContentView()
        contentViewLayout()
        addTagets()
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfile(_:)), name: NSNotification.Name(rawValue: "ProfileUpdated"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userProfileImageView.image = SharedProfileModel.myProfile.profileImage
        userProfileBackgroundImageView.image = SharedProfileModel.myProfile.backgroundImage
    }
    private func addOnView() {
        viewList = [userProfileBackgroundImageView, scrollView]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
        
        scrollView.addSubview(contentView)
        scrollView.addSubview(editBackgroundImageButton)
        scrollView.addSubview(editBackgroundColorButton)
    }
    
    private func viewLayout() {
        view.backgroundColor = UIColor.black
        scrollView.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.black
        
        userProfileBackgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.top)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        editBackgroundImageButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.top).offset(-10)
            make.trailing.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 38, height: 38))
        }
        
        editBackgroundColorButton.snp.makeConstraints { make in
            make.bottom.equalTo(editBackgroundImageButton)
            make.trailing.equalTo(editBackgroundImageButton.snp.leading).offset(-10)
            make.size.equalTo(CGSize(width: 38, height: 38))
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView).offset(120)
            make.leading.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().offset(-85)
        }
        
        scrollView.showsVerticalScrollIndicator = false
    }
    
    func addOnContentView() {
        contentViewList = [userProfileImageView, tableView,
                           editProfileImageButton]
        
        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }
    }
    
    func contentViewLayout() {
        tableView.backgroundColor = UIColor.black

        userProfileImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(-45)
            make.centerX.equalTo(contentView)
            make.size.equalTo(CGSize(width: 90, height: 90))
        }
        
        editProfileImageButton.snp.makeConstraints { make in
            make.top.equalTo(userProfileImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(editProfileImageButton.titleLabel!.snp.width).offset(52)
            make.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.isScrollEnabled = false
        tableView.register(EditProfileTableViewCell.self, forCellReuseIdentifier: "EditProfileTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.1)
    }
    
    private func navigationBarLayout() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)), style: .done, target: self, action: #selector(backButtonAction))
        
        backButton.tintColor = UIColor.white
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "프로필 편집"
    }
    
    private func addTagets() {
        editProfileImageButton.addTarget(self, action: #selector(editProfileImageButtonAction), for: .touchUpInside)
        editBackgroundImageButton.addTarget(self, action: #selector(editBackgroundImageButtonAction), for: .touchUpInside)
    }
    
    @objc private func editProfileImageButtonAction() {
        DispatchQueue.main.async {
            self.profileImagePicker.delegate = self
            self.profileImagePicker.sourceType = .photoLibrary
            self.profileImagePicker.modalPresentationStyle = .overFullScreen
            self.profileImagePicker.allowsEditing = true
            self.present(self.profileImagePicker, animated: true, completion: nil)
        }
    }
        
    @objc private func editBackgroundImageButtonAction() {
        DispatchQueue.main.async {
            self.backgroundImagePicker.delegate = self
            self.backgroundImagePicker.sourceType = .photoLibrary
            self.backgroundImagePicker.modalPresentationStyle = .overFullScreen
            self.backgroundImagePicker.allowsEditing = true
            self.present(self.backgroundImagePicker, animated: true, completion: nil)
        }
    }
    
    @objc private func backButtonAction() {
        dismiss(animated: true)
    }
    
    @objc func updateProfile(_ notification: Notification) {
        tableView.reloadData()
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewTitleLabelStringList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditProfileTableViewCell", for: indexPath) as! EditProfileTableViewCell
        
        cell.titleLabel.text = tableViewTitleLabelStringList[indexPath.row]
        
        switch indexPath.row {
        case 0:
            cell.subLabel.text = SharedProfileModel.myProfile.profileName
            cell.subLabel.textColor = UIColor.white
        case 1:
            if let userName = SharedProfileModel.myProfile.userName, userName != "" {
                cell.subLabel.text = SharedProfileModel.myProfile.userName
                cell.subLabel.textColor = UIColor.white
            } else {
                cell.subLabel.text = "이름"
                cell.subLabel.textColor = UIColor.placeholderText
            }
        case 2:
            if let introduction = SharedProfileModel.myProfile.introduction, introduction != "" {
                cell.subLabel.text = SharedProfileModel.myProfile.introduction
                cell.subLabel.textColor = UIColor.white
            } else {
                cell.subLabel.text = "소개"
                cell.subLabel.textColor = UIColor.placeholderText
            }
        case 3:
            if let gender = SharedProfileModel.myProfile.gender, gender != "" {
                cell.subLabel.text = SharedProfileModel.myProfile.gender
                cell.subLabel.textColor = UIColor.white
            } else {
                cell.subLabel.text = "성별"
                cell.subLabel.textColor = UIColor.placeholderText
            }
        case 4:
            if let email = SharedProfileModel.myProfile.birth, email != "" {
                cell.subLabel.text = SharedProfileModel.myProfile.birth
                cell.subLabel.textColor = UIColor.white
            } else {
                cell.subLabel.text = "생년월일"
                cell.subLabel.textColor = UIColor.placeholderText
            }
        case 5:
            if let email = SharedProfileModel.myProfile.email, email != "" {
                cell.subLabel.text = SharedProfileModel.myProfile.email
                cell.subLabel.textColor = UIColor.white
            } else {
                cell.subLabel.text = "이메일"
                cell.subLabel.textColor = UIColor.placeholderText
            }
        case 6:
            if let phoneNumber = SharedProfileModel.myProfile.phoneNumber, phoneNumber != "" {
                cell.subLabel.text = SharedProfileModel.myProfile.phoneNumber
                cell.subLabel.textColor = UIColor.white
            } else {
                cell.subLabel.text = "전화번호"
                cell.subLabel.textColor = UIColor.placeholderText
            }
        default:
            break
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let viewController = EditProfileNameViewController()
            show(viewController, sender: nil)
        case 1:
            let viewController = EditUserNameViewController()
            show(viewController, sender: nil)
        case 2:
            let viewController = EditIntroductionViewController()
            show(viewController, sender: nil)
        default:
            break
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImagePicker = (picker == profileImagePicker) ? "profileImage" : "backgroundImage"
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let userID = SharedProfileModel.myProfile.userID {
//            if let resizingSelectedImage = resizeImage(image: selectedImage, newWidth: 200) {
                uploadImage(field: "\(selectedImagePicker)", image: selectedImage, userID: userID) { result in
                    switch result {
                    case .success:
                        let profileName = SharedProfileModel.myProfile.profileName
                        fetchUserData(profileName: "\(profileName ?? "")") { (error) in
                            if let error = error {
                                print("Error: \(error.localizedDescription)")
                            }
                            DispatchQueue.main.async {
                                if SharedProfileModel.myProfile.profileImage != nil {
                                    (selectedImagePicker == "profileImage") ? (self.userProfileImageView.image = selectedImage) : (self.userProfileBackgroundImageView.image = selectedImage)
                                } else {
                                }
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                    case .failure(let error):
                        print("프로필 이미지 업로드 실패: \(error.localizedDescription)")
                    }
                }
//            }
        }
    }
}
