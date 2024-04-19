//
//  SearchInformationViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/20/23.
//

import UIKit
import SnapKit

class SearchInformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, RecentSearchesTableViewCellDelegate {
    private var viewList: [UIView] = []
    private var recentSearchesTableViewHeaderList: [UIView] = []
    
    private let searchController = UISearchController()
    private let tableView: UITableView = UITableView()
    private let userRecommendationsTableView: UITableView = UITableView()
    private let recentSearchesTableView: UITableView = UITableView()
    private let recentSearchesTableViewHeader: UIView = UIView()
    
    let loading = UIActivityIndicatorView()
    var count = 0
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    
    let recentSearchesTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "최근 검색"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    let recentSearchDeleteAllButton: UIButton = {
        let label = UIButton()
        
        label.setTitle("지우기", for: .normal)
        label.setTitleColor(UIColor.white, for: .normal)
        label.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.titleLabel?.textAlignment = .right
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addOnView()
        viewLayout()
        addOnRecentSearchesTableViewHeader()
        recentSearchesTableViewHeaderLayout()
        addOnTagets()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        userRecommendationsTableView.delegate = self
        userRecommendationsTableView.dataSource = self

        recentSearchesTableView.delegate = self
        recentSearchesTableView.dataSource = self
        
        searchController.searchBar.delegate = self
        
        userRecommendationsTableView.isHidden = false
        tableView.isHidden = true
        recentSearchesTableView.alpha = 0

        for i in SharedRecentSearchesRecordModel.nomarl {
            print("\(i.searchTime)\n\(i.searchesData)\n\(i.searchesType)")
        }
//        loading.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        uiViewUpdate()
        navigationBarLayout()
        self.navigationController?.loadViewIfNeeded()
        viewLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
    }

    private func addOnView() {
        viewList = [tableView, userRecommendationsTableView, recentSearchesTableView, loading]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }

    private func viewLayout() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        tableView.backgroundColor = UIColor(named: "BackgroundColor")
        userRecommendationsTableView.backgroundColor = UIColor(named: "BackgroundColor")
        recentSearchesTableView.backgroundColor = UIColor(named: "BackgroundColor")

        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
//        searchController.searchBar.searchTextField.overrideUserInterfaceStyle = .unspecified
        searchController.searchBar.searchTextField.placeholder = "검색"
        searchController.searchBar.tintColor = UIColor.white
//        searchController.searchBar.searchTextField.layer.cornerRadius = 15
//        searchController.searchBar.searchTextField.layer.borderWidth = 0.5
        searchController.searchBar.searchTextField.autocapitalizationType = .none
//        searchController.searchBar.searchTextField.layer.borderColor = UIColor(named: "SubBackgroundColor")?.cgColor
        searchController.searchBar.searchTextField.backgroundColor = UIColor(named: "SubBackgroundColor")
        searchController.searchBar.setValue("닫기", forKey: "cancelButtonText")

        userRecommendationsTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        recentSearchesTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        recentSearchesTableView.tableHeaderView = recentSearchesTableViewHeader
        
        recentSearchesTableViewHeader.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.width.equalToSuperview()
            make.height.equalTo(35)
        }
        
        loading.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.tableHeaderView = UIView()
        
        userRecommendationsTableView.tableHeaderView = UIView()
        userRecommendationsTableView.refreshControl = refreshControl

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.rowHeight = 70
        tableView.separatorInset.left = 65
        tableView.keyboardDismissMode = .onDrag
        tableView.register(SearchInformationTableViewCell.self, forCellReuseIdentifier: "SearchInformationTableViewCell")
        
        userRecommendationsTableView.separatorInset.left = 65
        userRecommendationsTableView.register(RecommendationsTableViewCell.self, forCellReuseIdentifier: "RecommendationsTableViewCell")

        recentSearchesTableView.rowHeight = 70
        recentSearchesTableView.separatorInset.left = 65
        recentSearchesTableView.keyboardDismissMode = .onDrag
        recentSearchesTableView.register(RecentSearchesTableViewCell.self, forCellReuseIdentifier: "RecentSearchesTableViewCell")
        
    }
    
    private func addOnRecentSearchesTableViewHeader() {
        recentSearchesTableViewHeaderList = [recentSearchesTitleLabel, recentSearchDeleteAllButton]
        
        for uiView in recentSearchesTableViewHeaderList {
            recentSearchesTableViewHeader.addSubview(uiView)
        }
    }
    
    private func recentSearchesTableViewHeaderLayout() {
        recentSearchesTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.centerY.equalToSuperview()
        }
        
        recentSearchDeleteAllButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
    }
    
    private func navigationBarLayout() {
        let button = UIButton()
        
        button.setTitle("검색", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        button.titleLabel?.textAlignment = .left
        
        let leftStackView = UIStackView.init(arrangedSubviews: [button])
        let leftStackBarButtonItem = UIBarButtonItem(customView: leftStackView)

        navigationItem.leftBarButtonItem = leftStackBarButtonItem
        
        let backBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(backButtonAction))
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    @objc private func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    private func uiViewUpdate() {
        fetchAllUsersProfiles { error in
            self.loading.startAnimating()
            if let error = error {
                print("Error fetching all users profiles:", error.localizedDescription)
            } else {
                print("All users profiles fetched successfully")
                DispatchQueue.main.async {
                    // 테이블 뷰를 업데이트
                    self.userRecommendationsTableView.reloadData()
                    self.userRecommendationsTableView.layoutIfNeeded()
                    self.recentSearchesTableView.reloadData()
                    self.recentSearchesTableView.layoutIfNeeded()
                }
                self.loading.stopAnimating()
            }
        }
    }
    
    private func addOnTagets() {
        recentSearchDeleteAllButton.addTarget(self, action: #selector(recentSearchDeleteAllButtonAction), for: .touchUpInside)
    }
    
    @objc func recentSearchDeleteAllButtonAction() {
        let alertController = UIAlertController(title: "모든 검색 기록 삭제", message: "모든 검색 기록을 삭제하시겠습니까?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            let loading = UIActivityIndicatorView()
            
            self.recentSearchesTableViewHeader.addSubview(loading)
            
            loading.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(-14)
                make.centerY.equalToSuperview()
            }
            
            UIView.animate(withDuration: 0.15) {
                self.recentSearchDeleteAllButton.alpha = 0
            }
            loading.startAnimating()
            deleteAllRecentSearchesRecords() { error in
                
                if let error = error {
                    // 에러 처리
                } else {
                    print("Recent search record delete all complete.")
                    DispatchQueue.main.async {
                        SharedRecentSearchesRecordModel.nomarl.removeAll()
                        SharedProfileModel.recentSearchesRecordProfiles.removeAll()
                        
                        DispatchQueue.main.async {
                            loading.stopAnimating()
                            
                            UIView.animate(withDuration: 0.15) {
                                self.recentSearchDeleteAllButton.alpha = 1
                            }
                            
                            DispatchQueue.main.async {
                                self.recentSearchesTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
        
        alertController.addAction(confirmAction)
        
        present(alertController, animated: true, completion: nil)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == userRecommendationsTableView {
            return SharedProfileModel.recommendationsProfiles.count
            
        } else if tableView == self.tableView {
            return SharedProfileModel.searchUsersProfiles.count
            
        } else if tableView == recentSearchesTableView {
            return SharedRecentSearchesRecordModel.nomarl.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchInformationTableViewCell", for: indexPath) as! SearchInformationTableViewCell
                        
            cell.profileNameLabel.text = SharedProfileModel.searchUsersProfiles[indexPath.row].profileName
            cell.userNameLabel.text = SharedProfileModel.searchUsersProfiles[indexPath.row].userName
            cell.profileImageView.image = SharedProfileModel.searchUsersProfiles[indexPath.row].profileImage
            
            if SharedProfileModel.searchUsersProfiles[indexPath.row].socialValidation! {
                if let image = UIImage(systemName: "checkmark.seal.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 10, weight: .light)) {
                    cell.socialValidationImageView.image = image
                    cell.socialValidationImageView.isHidden = false
                }
            } else {
                cell.socialValidationImageView.isHidden = true
            }
            
            return cell
            
        } else if tableView == userRecommendationsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendationsTableViewCell", for: indexPath) as! RecommendationsTableViewCell
            
            cell.profileNameLabel.text = SharedProfileModel.recommendationsProfiles[indexPath.row].profileName
            cell.userNameLabel.text = SharedProfileModel.recommendationsProfiles[indexPath.row].userName
            cell.profileImageView.image = SharedProfileModel.recommendationsProfiles[indexPath.row].profileImage
            cell.followLabel.text = "팔로워 \(SharedProfileModel.recommendationsProfiles[indexPath.row].followerDigits ?? 0)"
            
            if SharedProfileModel.recommendationsProfiles[indexPath.row].socialValidation! {
                if let image = UIImage(systemName: "checkmark.seal.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 10, weight: .light)) {
                    cell.socialValidationImageView.image = image
                    cell.socialValidationImageView.isHidden = false
                }
            } else {
                cell.socialValidationImageView.isHidden = true
            }
            
            return cell
            
        } else if tableView == recentSearchesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchesTableViewCell", for: indexPath) as! RecentSearchesTableViewCell
            
            cell.delegate = self
            
            if SharedRecentSearchesRecordModel.nomarl[indexPath.row].searchesType == "post" {
                cell.postSearchSetting()
                cell.postSearchLabel.text = SharedRecentSearchesRecordModel.nomarl[indexPath.row].searchesData
            } else {
                cell.userSsearchSetting()
                let userID =  SharedRecentSearchesRecordModel.nomarl[indexPath.row].searchesData
                
                if userID == SharedProfileModel.myProfile.userID {
                    cell.profileNameLabel.text = SharedProfileModel.myProfile.profileName
                    cell.userNameLabel.text = SharedProfileModel.myProfile.userName
                    cell.profileImageView.image = SharedProfileModel.myProfile.profileImage
                    cell.followLabel.text = "팔로워 \(SharedProfileModel.myProfile.followerDigits ?? 0)"
                    
                    if SharedProfileModel.myProfile.socialValidation! {
                        if let image = UIImage(systemName: "checkmark.seal.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 10, weight: .light)) {
                            cell.socialValidationImageView.image = image
                            cell.socialValidationImageView.isHidden = false
                        }
                    } else {
                        cell.socialValidationImageView.isHidden = true
                    }
                } else {
                    let index = SharedProfileModel.recentSearchesRecordProfiles.firstIndex { $0.userID == userID }
                    
                    if let index = index {
                        cell.profileNameLabel.text = SharedProfileModel.recentSearchesRecordProfiles[index].profileName
                        cell.userNameLabel.text = SharedProfileModel.recentSearchesRecordProfiles[index].userName
                        cell.profileImageView.image = SharedProfileModel.recentSearchesRecordProfiles[index].profileImage
                        cell.followLabel.text = "팔로워 \(SharedProfileModel.recentSearchesRecordProfiles[index].followerDigits ?? 0)"
                        
                        if SharedProfileModel.recentSearchesRecordProfiles[index].socialValidation! {
                            if let image = UIImage(systemName: "checkmark.seal.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 10, weight: .light)) {
                                cell.socialValidationImageView.image = image
                                cell.socialValidationImageView.isHidden = false
                            }
                        } else {
                            cell.socialValidationImageView.isHidden = true
                        }
                    }
                }
            }
            
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func didTapDeleteButton(in cell: RecentSearchesTableViewCell) {
        if let indexPath = recentSearchesTableView.indexPath(for: cell) {
            if let documentID = SharedRecentSearchesRecordModel.nomarl[indexPath.row].recentSearchesRecordID, let searchesType = SharedRecentSearchesRecordModel.nomarl[indexPath.row].searchesType, let searchesData = SharedRecentSearchesRecordModel.nomarl[indexPath.row].searchesData {
                deleteRecentSearchesRecord(documentID: documentID) { error in
                    if let error = error {

                    } else {
                        if searchesType == "user" {
                            if let index = SharedProfileModel.recentSearchesRecordProfiles.firstIndex(where: { $0.userID == searchesData }) {
                                SharedProfileModel.recentSearchesRecordProfiles.remove(at: index)
                                
                                SharedRecentSearchesRecordModel.nomarl.remove(at: indexPath.row)
                                
                                self.recentSearchesTableView.deleteRows(at: [indexPath], with: .fade)
                            }
                        } else if searchesType == "post" {
                            SharedRecentSearchesRecordModel.nomarl.remove(at: indexPath.row)
                            
                            self.recentSearchesTableView.deleteRows(at: [indexPath], with: .fade)
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == self.tableView {
            if SharedProfileModel.searchUsersProfiles[indexPath.row].userID == SharedProfileModel.myProfile.userID {
                let  myProfileVC = MyProfileViewController()
                
                if let searchesData = SharedProfileModel.myProfile.userID {
                    let time = currentDateTimeString()
                    let data = RecentSearchesRecordData(searchesData: searchesData, searchesType: "user", searchTime: time)
                    
                    if (SharedProfileModel.recentSearchesRecordProfiles.first(where: { $0.userID == searchesData }) != nil) {
                        if let index = SharedRecentSearchesRecordModel.nomarl.firstIndex(where: { $0.searchesData == searchesData }), let documentID = SharedRecentSearchesRecordModel.nomarl[index].recentSearchesRecordID {
                            updateRecentSearchesRecord(recentSearchesRecordData: data, documentID: documentID) { error in
                                if let error = error {
                                    
                                } else {
                                    let updatedData = SharedRecentSearchesRecordModel()
                                    updatedData.recentSearchesRecordID = data.recentSearchesRecordID
                                    updatedData.searchTime = data.searchTime
                                    updatedData.searchesData = data.searchesData
                                    updatedData.searchesType = data.searchesType

                                    SharedRecentSearchesRecordModel.nomarl.remove(at: index)
                                    SharedRecentSearchesRecordModel.nomarl.insert(updatedData, at: 0)
                                    print("searchesData update complete")
                                    self.recentSearchesTableView.reloadData()
                                }
                            }
                        }
                    } else {
                        uploadRecentSearchesRecord(recentSearchesRecordData: data) { userData, error in
                            if let error = error {
                                
                            } else {
                                if let userData = userData {
                                    let sharedProfileModel = SharedProfileModel()
                                    let profileData = SharedProfileModel.searchUsersProfiles[indexPath.row]
                                    
                                    sharedProfileModel.profileName = profileData.profileName
                                    sharedProfileModel.userName = profileData.userName
                                    sharedProfileModel.password = profileData.password
                                    sharedProfileModel.myCircleDigits = profileData.myCircleDigits
                                    sharedProfileModel.myInTheCircleDigits = profileData.myInTheCircleDigits
                                    sharedProfileModel.myPostDigits = profileData.myPostDigits
                                    sharedProfileModel.followerDigits = profileData.followerDigits
                                    sharedProfileModel.followingDigits = profileData.followingDigits
                                    sharedProfileModel.socialValidation = profileData.socialValidation
                                    sharedProfileModel.userCategory = profileData.userCategory
                                    sharedProfileModel.introduction = profileData.introduction
                                    sharedProfileModel.email = profileData.email
                                    sharedProfileModel.phoneNumber = profileData.phoneNumber
                                    sharedProfileModel.birth = profileData.birth
                                    sharedProfileModel.gender = profileData.gender
                                    sharedProfileModel.userID = profileData.userID
                                    sharedProfileModel.profileImage = profileData.profileImage
                                    
                                    SharedProfileModel.recentSearchesRecordProfiles.append(sharedProfileModel)
                                    SharedRecentSearchesRecordModel.nomarl.insert(userData, at: 0)
                                    print("searchesData update complete")
                                    self.recentSearchesTableView.reloadData()
                                }
                            }
                        }
                    }
                }
                
                self.navigationController?.pushViewController(myProfileVC, animated: true)
            } else {
                let userProfileVC = UserProfileViewController()
                
                userProfileVC.indexPath = indexPath.row
                userProfileVC.profileModel = SharedProfileModel.searchUsersProfiles
                
                if let searchesData = SharedProfileModel.searchUsersProfiles[indexPath.row].userID {
                    let time = currentDateTimeString()
                    let data = RecentSearchesRecordData(searchesData: searchesData, searchesType: "user", searchTime: time)
                    
                    if (SharedProfileModel.recentSearchesRecordProfiles.first(where: { $0.userID == searchesData }) != nil) {
                        if let index = SharedRecentSearchesRecordModel.nomarl.firstIndex(where: { $0.searchesData == searchesData }), let documentID = SharedRecentSearchesRecordModel.nomarl[index].recentSearchesRecordID {
                            updateRecentSearchesRecord(recentSearchesRecordData: data, documentID: documentID) { error in
                                if let error = error {
                                    
                                } else {
                                    let updatedData = SharedRecentSearchesRecordModel()
                                    updatedData.recentSearchesRecordID = data.recentSearchesRecordID
                                    updatedData.searchTime = data.searchTime
                                    updatedData.searchesData = data.searchesData
                                    updatedData.searchesType = data.searchesType

                                    SharedRecentSearchesRecordModel.nomarl.remove(at: index)
                                    SharedRecentSearchesRecordModel.nomarl.insert(updatedData, at: 0)
                                    print("searchesData update complete")
                                    self.recentSearchesTableView.reloadData()
                                }
                            }
                        }
                    } else {
                        uploadRecentSearchesRecord(recentSearchesRecordData: data) { userData, error in
                            if let error = error {
                                
                            } else {
                                if let userData = userData {
                                    let sharedProfileModel = SharedProfileModel()
                                    let profileData = SharedProfileModel.searchUsersProfiles[indexPath.row]
                                    
                                    sharedProfileModel.profileName = profileData.profileName
                                    sharedProfileModel.userName = profileData.userName
                                    sharedProfileModel.password = profileData.password
                                    sharedProfileModel.myCircleDigits = profileData.myCircleDigits
                                    sharedProfileModel.myInTheCircleDigits = profileData.myInTheCircleDigits
                                    sharedProfileModel.myPostDigits = profileData.myPostDigits
                                    sharedProfileModel.followerDigits = profileData.followerDigits
                                    sharedProfileModel.followingDigits = profileData.followingDigits
                                    sharedProfileModel.socialValidation = profileData.socialValidation
                                    sharedProfileModel.userCategory = profileData.userCategory
                                    sharedProfileModel.introduction = profileData.introduction
                                    sharedProfileModel.email = profileData.email
                                    sharedProfileModel.phoneNumber = profileData.phoneNumber
                                    sharedProfileModel.birth = profileData.birth
                                    sharedProfileModel.gender = profileData.gender
                                    sharedProfileModel.userID = profileData.userID
                                    sharedProfileModel.profileImage = profileData.profileImage

                                    SharedProfileModel.recentSearchesRecordProfiles.append(sharedProfileModel)
                                    SharedRecentSearchesRecordModel.nomarl.insert(userData, at: 0)
                                    print("searchesData update complete")
                                    self.recentSearchesTableView.reloadData()
                                }
                            }
                        }
                    }
                }
                
                self.navigationController?.pushViewController(userProfileVC, animated: true)
            }
        } else if tableView == self.userRecommendationsTableView {
            if SharedProfileModel.recommendationsProfiles[indexPath.row].userID == SharedProfileModel.myProfile.userID {
                let  myProfileVC = MyProfileViewController()
                
                self.navigationController?.pushViewController(myProfileVC, animated: true)
            } else {
                let userProfileVC = UserProfileViewController()
                
                userProfileVC.indexPath = indexPath.row
                userProfileVC.profileModel = SharedProfileModel.recommendationsProfiles

                self.navigationController?.pushViewController(userProfileVC, animated: true)
            }
        } else if tableView == self.recentSearchesTableView {
            if let searchesType = SharedRecentSearchesRecordModel.nomarl[indexPath.row].searchesType {
                if searchesType == "user" {
                    if SharedRecentSearchesRecordModel.nomarl[indexPath.row].searchesData == SharedProfileModel.myProfile.userID {
                        let  myProfileVC = MyProfileViewController()
                        
                        self.navigationController?.pushViewController(myProfileVC, animated: true)
                    } else {
                        let userProfileVC = UserProfileViewController()
                        
                        let userID =  SharedRecentSearchesRecordModel.nomarl[indexPath.row].searchesData
                        let index = SharedProfileModel.recentSearchesRecordProfiles.firstIndex { $0.userID == userID }
                        
                        userProfileVC.indexPath = index
                        userProfileVC.profileModel = SharedProfileModel.recentSearchesRecordProfiles
                        
                        self.navigationController?.pushViewController(userProfileVC, animated: true)
                    }
                    
                    if let searchesData = SharedRecentSearchesRecordModel.nomarl[indexPath.row].searchesData {
                        let time = currentDateTimeString()
                        let data = RecentSearchesRecordData(searchesData: searchesData, searchesType: "user", searchTime: time)
                        
                        if let index = SharedRecentSearchesRecordModel.nomarl.firstIndex(where: { $0.searchesData == searchesData }), let documentID = SharedRecentSearchesRecordModel.nomarl[index].recentSearchesRecordID {
                            updateRecentSearchesRecord(recentSearchesRecordData: data, documentID: documentID) { error in
                                if let error = error {
                                    
                                } else {
                                    let updatedData = SharedRecentSearchesRecordModel()
                                    updatedData.recentSearchesRecordID = data.recentSearchesRecordID
                                    updatedData.searchTime = data.searchTime
                                    updatedData.searchesData = data.searchesData
                                    updatedData.searchesType = data.searchesType
                                    
                                    SharedRecentSearchesRecordModel.nomarl.remove(at: index)
                                    SharedRecentSearchesRecordModel.nomarl.insert(updatedData, at: 0)
                                    print("searchesData update complete")
                                    self.recentSearchesTableView.reloadData()
                                }
                            }
                        }
                    }
                } else if searchesType == "post" {
                    
                }
            }
        }
    }
    
    @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchBar.text?.lowercased().replacingOccurrences(of: " ", with: "") ?? ""
        guard searchText.count > 0 else {
            SharedProfileModel.searchUsersProfiles = []
            recentSearchesTableView.alpha = 1
            tableView.isHidden = true
//            userRecommendationsTableView.isHidden = true
            self.tableView.reloadData()
            return
        }
        
        searchUsers(withPrefix: searchText) { (error) in
            if let error = error {
                print("Error searching users: \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                // 클라이언트 측에서 중복 검색 결과 처리
                var uniqueProfiles: [SharedProfileModel] = []
                var profileIDs: Set<String> = Set()
                for profile in SharedProfileModel.searchUsersProfiles {
                    if !profileIDs.contains(profile.userID!) {
                        uniqueProfiles.append(profile)
                        profileIDs.insert(profile.userID!)
                    }
                }
                SharedProfileModel.searchUsersProfiles = uniqueProfiles
                
                self.tableView.isHidden = false
                self.recentSearchesTableView.alpha = 0
//                self.userRecommendationsTableView.isHidden = true
                self.tableView.reloadData()
            }
        }
    }

    @objc func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if tableView.isHidden {
            self.userRecommendationsTableView.alpha = 0

            UIView.animate(withDuration: 0.35) {
                self.recentSearchesTableView.alpha = 1
                self.tableView.isHidden = true
            }
        }
        
        return true
            
    }
    
    @objc func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.recentSearchesTableView.alpha = 0

        UIView.animate(withDuration: 0.35) {
            self.userRecommendationsTableView.alpha = 1
            self.tableView.isHidden = true
        }
        
        SharedProfileModel.searchUsersProfiles = []
    }
    
    @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchesData = searchBar.text {
            let time = currentDateTimeString()
            let data = RecentSearchesRecordData(searchesData: searchesData, searchesType: "post", searchTime: time)
            
            if (SharedRecentSearchesRecordModel.nomarl.first(where: { $0.searchesData == searchBar.text }) != nil) {
                if let index = SharedRecentSearchesRecordModel.nomarl.firstIndex(where: { $0.searchesData == searchBar.text }) {
                    if let documentID = SharedRecentSearchesRecordModel.nomarl[index].recentSearchesRecordID {
                        updateRecentSearchesRecord(recentSearchesRecordData: data, documentID: documentID) { error in
                            if let error = error {
                                
                            } else {
                                let updatedData = SharedRecentSearchesRecordModel()
                                updatedData.recentSearchesRecordID = data.recentSearchesRecordID
                                updatedData.searchTime = data.searchTime
                                updatedData.searchesData = data.searchesData
                                updatedData.searchesType = data.searchesType

                                SharedRecentSearchesRecordModel.nomarl.remove(at: index)
                                SharedRecentSearchesRecordModel.nomarl.insert(updatedData, at: 0)
                                print("searchesData update complete")
                                self.recentSearchesTableView.reloadData()
                            }
                        }
                    }
                }
            } else {
                uploadRecentSearchesRecord(recentSearchesRecordData: data) { userData, error in
                    if let error = error {
                        
                    } else {
                        if let userData = userData {
                            SharedRecentSearchesRecordModel.nomarl.insert(userData, at: 0)
                            print("searchesData upload complete")
                            self.recentSearchesTableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    @objc func refreshData() {
        fetchAllUsersProfiles { error in
            self.refreshControl.beginRefreshing()
            if let error = error {
                print("Error fetching all users profiles:", error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    // 테이블 뷰를 업데이트
                    self.refreshControl.endRefreshing()
                    self.userRecommendationsTableView.reloadData()
                    self.userRecommendationsTableView.layoutIfNeeded()
                }
            }
        }
    }
}
