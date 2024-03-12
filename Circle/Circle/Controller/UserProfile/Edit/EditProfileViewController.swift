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
    private var headerViewList: [UIView] = []
    private let tableViewTitleLabelStringList: [String] = ["프로필 이름",
                                                           "사용자 이름",
                                                           "자기소개",
                                                           "성별",
                                                           "생년월일",
                                                           "이메일",
                                                           "전화번호"]
    
    private var headerView: UIView = UIView()
    private let tableView: UITableView = UITableView()
    private var separator: UIView = IntroView().separator()
    
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
        addOnHeaderView()
        headerViewLayout()
        addTagets()
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfile(_:)), name: NSNotification.Name(rawValue: "ProfileUpdated"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userProfileImageView.image = SharedProfileModel.myProfile.profileImage
        userProfileBackgroundImageView.image = SharedProfileModel.myProfile.backgroundImage
        
        navigationBarLayout()
        tableView.reloadData()
        tableView.layoutIfNeeded()
    }
    private func addOnView() {
        viewList = [tableView]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }
    
    private func viewLayout() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        tableView.backgroundColor = UIColor(named: "BackgroundColor")
        userProfileImageView.layer.cornerRadius = 40
        tableView.register(EditProfileTableViewCell.self, forCellReuseIdentifier: "EditProfileTableViewCell")
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableHeaderView = headerView
        tableView.separatorInset.left = 0

        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(156)
        }
    }
     
    func addOnHeaderView() {
        headerViewList = [userProfileImageView,
                           editProfileImageButton,
                          separator]
        
        for uiView in headerViewList {
            headerView.addSubview(uiView)
        }
    }
    
    func headerViewLayout() {
        userProfileImageView.snp.makeConstraints { make in
            make.top.equalTo(15)       
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        editProfileImageButton.snp.makeConstraints { make in
            make.top.equalTo(userProfileImageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(editProfileImageButton.titleLabel!.snp.width).offset(52)
            make.height.equalTo(30)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(editProfileImageButton.snp.bottom).offset(15)
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func navigationBarLayout() {
        let cancelBarButton = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(cancelButtonAction))

        cancelBarButton.tintColor = UIColor.white
        
        navigationItem.leftBarButtonItem = cancelBarButton
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
    
    @objc private func cancelButtonAction() {
        dismiss(animated: true)
    }
    
    @objc func updateProfile(_ notification: Notification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ProfileUpdatedAndLayout"), object: nil)
        }
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
