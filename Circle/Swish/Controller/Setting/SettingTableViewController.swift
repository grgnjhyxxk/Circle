//
//  SettingTableViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/20/23.
//

import UIKit
import SnapKit

class SettingTableViewController: UIViewController {

    private var viewList: [UIView] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addOnView()
        viewLayout()
    }

    private func addOnView() {
        viewList = []
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }

    private func viewLayout() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
    }
}
