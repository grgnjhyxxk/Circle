//
//  SearchLocationViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 11/16/23.
//

import UIKit
import MapKit
import SnapKit

protocol SearchViewControllerDelegate: AnyObject {
    func didSelectLocation(_ location: String)
}

class SearchViewController: UIViewController {
    weak var delegate: SearchViewControllerDelegate?

    private var searchCompleter = MKLocalSearchCompleter() /// 검색을 도와주는 변수
    private var searchResults = [MKLocalSearchCompletion]() /// 검색 결과를 담는 변수
    private var viewList: [UIView] = []
    private var topViewList: [UIView] = []
    
    let searchController: UISearchController = UserMainView.postView.SearchLocationView().searchController()
    
    let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addOnView()
        viewLayout()
        navigationBarLayout()
        setupSearchCompleter()
        
        searchController.searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func addOnView() {
        viewList = [tableView]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }
    
    func viewLayout() {
        view.backgroundColor = UIColor.black
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.black
        tableView.register(SearchLocationTableViewCell.self, forCellReuseIdentifier: "SearchLocationTableViewCell")
    }
    
    func navigationBarLayout() {
        let cancelBarButton = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(cancelButtonAction))
        let saveBarButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: nil)
        
        cancelBarButton.tintColor = UIColor.white
        saveBarButton.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItem = saveBarButton
        navigationItem.title = "위치"
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.showsCancelButton = false
    }

    func setupSearchCompleter() {
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address /// resultTypes은 검색 유형인데 address는 주소를 의미
    }
    
    func addTagets() {
        
    }
    
    @objc func touchupCancelButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func cancelButtonAction() {
        dismiss(animated: true)
    }
}

extension SearchViewController: UITableViewDelegate {
    /// 검색 결과 선택 시에 (취소/추가)버튼이 있는 VC이 보여야 함
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedResult = searchResults[indexPath.row]
        let selectedString = selectedResult.title
        // 이제 selectedString을 활용하여 원하는 작업을 수행할 수 있습니다.
        print("사용자가 선택한 검색 결과:", selectedString)
        
        if let cell = tableView.cellForRow(at: indexPath) as? SearchLocationTableViewCell {
            cell.checkButton.isHidden = false
            delegate?.didSelectLocation(selectedString)
            searchController.dismiss(animated: true)
            dismiss(animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchController.searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchLocationTableViewCell", for: indexPath) as? SearchLocationTableViewCell
        else { return UITableViewCell() }
        cell.countryLabel.text = searchResults[indexPath.row].title
        cell.backgroundColor = .clear

        if searchController.searchBar.text != nil {
            // Assuming searchResults[indexPath.row].title is a String
            let title = searchResults[indexPath.row].title
            let highlightText = "YourHighlightText"

            let attributedString = NSMutableAttributedString(string: title)
            let range = (title as NSString).range(of: highlightText, options: .caseInsensitive)
            attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: range)

            cell.countryLabel.attributedText = attributedString

        }
        
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    // 검색창의 text가 변하는 경우에 searchBar가 delegate에게 알리는데 사용하는 함수
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // searchText를 queryFragment로 넘겨준다.
        searchCompleter.queryFragment = searchText
    }
}

extension SearchViewController: MKLocalSearchCompleterDelegate {
    // 자동완성 완료 시에 결과를 받는 함수
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // completer.results를 통해 검색한 결과를 searchResults에 담아줍니다
        searchResults = completer.results
        tableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // 에러 확인
        print(error.localizedDescription)
    }
}
