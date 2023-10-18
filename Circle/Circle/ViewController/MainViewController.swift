//
//  MainViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/12/23.
//

import UIKit
import SnapKit
import UPCarouselFlowLayout

class MainViewController: UIViewController {
    
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
        view.backgroundColor = .black
    }
        
}
