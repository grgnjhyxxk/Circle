//
//  TabBarController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/18/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    let addViewControllerNavigationButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("커스텀 탭바가 로드되었습니다.")
        configureLayout()
    }
    
    func configureLayout() {
        self.tabBar.tintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.75)
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.backgroundColor = UIColor.clear
        
        let firstViewController = MainViewController()
        let secondViewController = MainViewController()
        let thirdViewController = MainViewController()
        
        firstViewController.tabBarItem.selectedImage = UIImage(systemName: "circle.hexagongrid.fill")
        firstViewController.tabBarItem.image = UIImage(systemName: "circle.hexagongrid")
        
        secondViewController.tabBarItem.selectedImage = UIImage(systemName: "alarm.fill")
        secondViewController.tabBarItem.image = UIImage(systemName: "alarm")
        
        thirdViewController.tabBarItem.selectedImage = UIImage(systemName: "staroflife.fill")
        thirdViewController.tabBarItem.image = UIImage(systemName: "staroflife.fill")
        
        viewControllers = [firstViewController, secondViewController, thirdViewController]
    }
}
