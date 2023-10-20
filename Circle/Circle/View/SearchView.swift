//
//  SearchView.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/20/23.
//

import UIKit

class SearchView: UIView {
    
    func searchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        
        searchBar.barTintColor = UIColor(white: 1, alpha: 0.75)
        searchBar.backgroundImage = UIImage()
        searchBar.layer.cornerRadius = 15
        searchBar.clipsToBounds = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "검색"
        
        let searchIcon = UIImage(systemName: "magnifyingglass")
        let imageView = UIImageView(image: searchIcon)
        imageView.contentMode = .center
        imageView.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        imageView.tintColor = UIColor.placeholderText
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.leftView = imageView
            textField.leftViewMode = .always
        }
        
        return searchBar
    }

}


