//
//  SystemView.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/19/23.
//

import UIKit

class SystemView: UIView {
    
    func errorTextLabel() -> UILabel {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textColor = UIColor.red
//        label.font = UIFont.systemFont(ofSize: 12.5)
        label.font = UIFont.systemFont(ofSize: 13.5, weight: .light)
        label.isHidden = true
        
        return label
    }
}
