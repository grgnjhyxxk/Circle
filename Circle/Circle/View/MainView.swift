//
//  MainView.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/12/23.
//

import UIKit

class MainView: UIView {
    
    func MainViewTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "Circle"
        label.textColor = UIColor.white
        label.font = UIFont(name: "NotoSans-Thin", size: 30)
        
        return label
    }
}
