//
//  BasicPostViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 11/5/23.
//

import UIKit
import SnapKit

class BasicPostViewController: UIViewController {
    var viewList: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarLayout()
        addOnView()
        viewLayout()
    }
    
    func addOnView() {
        viewList = []
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }
    
    func viewLayout() {
        
    }
    
    func navigationBarLayout() {
        
    }
}
