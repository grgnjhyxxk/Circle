//
//  SearchInformationViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/20/23.
//

import UIKit
import SnapKit

class SearchInformationViewController: UIViewController {

    private var viewList: [UIView] = []
    
    private let searchBar: UISearchBar = SearchView().searchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addOnView()
        viewLayout()
    }

    private func addOnView() {
        viewList = [searchBar]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }

    private func viewLayout() {
        view.backgroundColor = UIColor.black
        
        searchBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-15)
            make.height.equalTo(40)
        }
    }
}
