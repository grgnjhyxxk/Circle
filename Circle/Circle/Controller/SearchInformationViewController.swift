//
//  SearchInformationViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/20/23.
//

import UIKit
import SnapKit

class SearchInformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    private var viewList: [UIView] = []
    
    private let searchController = UISearchController()
    private let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addOnView()
        viewLayout()
        tableView.delegate = self
        tableView.dataSource = self
        searchController.searchBar.delegate = self
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
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
        
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.searchTextField.overrideUserInterfaceStyle = .dark
        searchController.searchBar.searchTextField.placeholder = "검색"
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.searchTextField.layer.cornerRadius = 15
        searchController.searchBar.searchTextField.layer.borderWidth = 0.5
        searchController.searchBar.searchTextField.autocapitalizationType = .none
        searchController.searchBar.searchTextField.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        searchController.searchBar.searchTextField.backgroundColor = UIColor.black
        searchController.searchBar.setValue("닫기", forKey: "cancelButtonText")
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.rowHeight = 60
        tableView.register(SearchInformationTableViewCell.self, forCellReuseIdentifier: "SearchInformationTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SharedProfileModel.otherUsersProfiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchInformationTableViewCell", for: indexPath) as! SearchInformationTableViewCell
        
        cell.profileNameLabel.text = SharedProfileModel.otherUsersProfiles[indexPath.row].profileName
        cell.userNameLabel.text = SharedProfileModel.otherUsersProfiles[indexPath.row].userName
        cell.profileImageView.image = SharedProfileModel.otherUsersProfiles[indexPath.row].profileImage
        
        if SharedProfileModel.otherUsersProfiles[indexPath.row].socialValidation! {
            if let image = UIImage(systemName: "checkmark.seal.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 10, weight: .light)) {
                cell.socialValidationImageView.image = image
                cell.socialValidationImageView.isHidden = false
            }
        } else {
            cell.socialValidationImageView.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let userProfileVC = UserProfileViewController()
        
        userProfileVC.indexPath = indexPath.row
        
        let userProfile = SharedProfileModel.otherUsersProfiles[indexPath.row]
        
        if let userID = userProfile.userID {
            retrieveMyPosts(userID: userID) { (error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    self.navigationController?.pushViewController(userProfileVC, animated: true)
                }
            }
        }
    }
    
    @objc func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchBar.text?.lowercased().replacingOccurrences(of: " ", with: "") ?? ""
        guard searchText.count > 0 else {
            SharedProfileModel.otherUsersProfiles = []
            self.tableView.reloadData()
            return
        }
                
        searchUsers(withPrefix: searchText) { (error) in
            if let error = error {
                print("Error searching users: \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    
    @objc func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        tableView.isHidden = false
        return true
    }
    
    @objc func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.isHidden = true
        SharedProfileModel.otherUsersProfiles = []
    }
    
    @objc func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        tableView.isHidden = true
        return true
    }
}
