//
//  EditPorfileViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/24/23.
//

import UIKit
import SnapKit

class EditPorfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        navigationBarLayout()
    }
    
    func navigationBarLayout() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonAction))
        
        backButton.tintColor = UIColor.white
        
        navigationItem.leftBarButtonItem = backButton
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
}
