//
//  MainViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/12/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    private var viewList: [UIView] = []
    private var contentViewList: [UIView] = []
    
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()
    
    private var vivivi: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addOnView()
        viewLayout()
        addOnContentView()
        contentViewLayout()
        
        scrollView.backgroundColor = UIColor.black
        contentView.backgroundColor = UIColor.black
    }

    private func addOnView() {
        viewList = [scrollView]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
        
        scrollView.addSubview(contentView)
    }

    private func viewLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(1000)
        }
    }
    
    private func addOnContentView() {
        contentViewList = [vivivi]
        
        for uiView in contentViewList {
            contentView.addSubview(uiView)
        }
    }
    
    private func contentViewLayout() {
    }
}

