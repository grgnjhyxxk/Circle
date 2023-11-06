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
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ddd")
        configureLayout()
    }
    
    func configureLayout() {
        self.tabBar.tintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.75)
        self.tabBar.backgroundColor = UIColor.black.withAlphaComponent(0.75)

        let myProfileViewController = MyProfileViewController()
        let myProfileNavigationController = UINavigationController(rootViewController: myProfileViewController)

        let searchInformationViewController = SearchInformationViewController()
        let searchInformationNavigationController = UINavigationController(rootViewController: searchInformationViewController)

        let mainViewController = MainViewController()
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)

        let circlesViewController = MainViewController()
        let circleNavigationController = UINavigationController(rootViewController: circlesViewController)
        
        circleNavigationController.tabBarItem.selectedImage = UIImage(systemName: "person.2.fill")
        circleNavigationController.tabBarItem.image = UIImage(systemName: "person.2")

        searchInformationNavigationController.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass")
        searchInformationNavigationController.tabBarItem.image = UIImage(systemName: "magnifyingglass")?.withConfiguration(UIImage.SymbolConfiguration(weight: .light))

        mainNavigationController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        mainNavigationController.tabBarItem.image = UIImage(systemName: "house")

        viewControllers = [mainNavigationController, searchInformationNavigationController, circleNavigationController, myProfileNavigationController]

        if let profileImage = SharedProfileModel.myProfile.profileImage {
            let circularImage = profileImage.circularImage(size: CGSize(width: 10, height: 10)) // 원형 이미지 생성
            let selectedCircularImage = profileImage.circularImage(size: CGSize(width: 10, height: 10), borderWidth: 0.2, borderColor: UIColor.white) // border 추가

            myProfileNavigationController.tabBarItem.selectedImage = selectedCircularImage.withRenderingMode(.alwaysOriginal) // 선택된 이미지 설정
            myProfileNavigationController.tabBarItem.image = circularImage.withRenderingMode(.alwaysOriginal) // 비선택된 이미지 설정
        }
    }
}

extension UIImage {
    func circularImage(size: CGSize, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) -> UIImage {
        let scale = UIScreen.main.scale
        let radius = size.width / 2 * scale
        let borderWidth = borderWidth * scale
        let totalSize = CGSize(width: size.width * scale, height: size.height * scale)

        UIGraphicsBeginImageContextWithOptions(totalSize, false, 0)
        let context = UIGraphicsGetCurrentContext()!

        let circlePath = UIBezierPath(
            roundedRect: CGRect(x: borderWidth, y: borderWidth, width: totalSize.width - borderWidth * 2, height: totalSize.height - borderWidth * 2),
            cornerRadius: radius
        )
        context.addPath(circlePath.cgPath)
        context.clip()

        let rect = CGRect(x: 0, y: 0, width: totalSize.width, height: totalSize.height)
        draw(in: rect)

        if borderWidth > 0 {
            borderColor.setStroke()
            circlePath.lineWidth = borderWidth * 2
            circlePath.stroke()
        }

        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
