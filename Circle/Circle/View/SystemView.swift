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
        label.font = UIFont.systemFont(ofSize: 12.5)
        
        return label
    }
}
