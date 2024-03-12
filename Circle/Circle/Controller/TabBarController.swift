//
//  TabBarController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/18/23.
//

import UIKit
import SnapKit

class TabBarController: UITabBarController {
    let floatingButton: UIButton = SystemView().floatingButton()
    let addViewControllerNavigationButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(floatingButton)
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureLayout()
    }
    
    func configureLayout() {
        self.tabBar.tintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.35)
        self.tabBar.backgroundColor = UIColor(named: "BackgroundColor")
        self.tabBar.barTintColor = UIColor(named: "BackgroundColor")
        self.tabBar.standardAppearance.backgroundColor = UIColor(named: "BackgroundColor")
        self.tabBar.shadowImage = UIImage()
        self.tabBar.isTranslucent = false
        self.tabBar.clipsToBounds = true
        
        let myProfileViewController = MyProfileViewController()
        let myProfileNavigationController = UINavigationController(rootViewController: myProfileViewController)

        let searchInformationViewController = SearchInformationViewController()
        let searchInformationNavigationController = UINavigationController(rootViewController: searchInformationViewController)

        let mainViewController = MainViewController()
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)

        let reactViewController = MainViewController()
        let reactNavigationController = UINavigationController(rootViewController: reactViewController)
        
        let messageViewController = MainViewController()
        let messagNavigationController = UINavigationController(rootViewController: messageViewController)

        mainNavigationController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        mainNavigationController.tabBarItem.image = UIImage(systemName: "house")
        
        searchInformationNavigationController.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass")
        searchInformationNavigationController.tabBarItem.image = UIImage(systemName: "magnifyingglass")?.withConfiguration(UIImage.SymbolConfiguration(weight: .light))
        
        myProfileNavigationController.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        myProfileNavigationController.tabBarItem.image = UIImage(systemName: "person")
        
        reactNavigationController.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        reactNavigationController.tabBarItem.image = UIImage(systemName: "heart")
        
        messagNavigationController.tabBarItem.selectedImage = UIImage(systemName: "envelope.fill")
        messagNavigationController.tabBarItem.image = UIImage(systemName: "envelope")
        
        viewControllers = [mainNavigationController, searchInformationNavigationController, myProfileNavigationController, reactNavigationController, messagNavigationController]
        
        
        floatingButton.snp.makeConstraints { make in
            make.bottom.equalTo(-100)
            make.trailing.equalTo(-15)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        floatingButton.addTarget(self, action: #selector(floatingButtonAction), for: .touchUpInside)
    }
    
    @objc func floatingButtonAction() {
        let viewController = UINavigationController(rootViewController: PostingViewController())
        
        viewController.modalPresentationStyle = .fullScreen
        
        present(viewController, animated: true)
    }
}
