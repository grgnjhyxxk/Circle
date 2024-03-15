//
//  MainView.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/12/23.
//

import UIKit

class MainView: UIView {
    func segmentedControlView() -> UIView {
        let view = UIView()
        
        view.backgroundColor = UIColor.black
        
        return view
    }
    
    func createSegmentedControl() -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: ["팔로우 중", "가입 서클"])
        
        segmentedControl.selectedSegmentIndex = 0

        let image = UIImage()
        segmentedControl.setBackgroundImage(image, for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(image, for: .selected, barMetrics: .default)
        segmentedControl.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        segmentedControl.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        
        let normalFont = UIFont.systemFont(ofSize: 16, weight: .medium)
            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: normalFont as Any, NSAttributedString.Key.foregroundColor: UIColor.placeholderText], for: .normal)
        let selectedFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: selectedFont as Any, NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        
        return segmentedControl
    }
}
