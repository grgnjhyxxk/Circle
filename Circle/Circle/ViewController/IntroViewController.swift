//
//  ViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/11/23.
//

import UIKit
import SnapKit

class IntroViewController: UIViewController {
    
    private var viewList: [UIView] = []
    
    private var spinningCirclesView = SpinningCirclesView()
    
    private var startButton: UIButton = IntroView().startButton()
    private var introMainTitleLabel: UILabel = IntroView().introMainTitleLabel()
    private var introSubTitleLabel: UILabel = IntroView().introSubTitleLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addOnView()
        viewLayout()
        spinningCirclesView.startAnimation()
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spinningCirclesView.startAnimation()
    }
    
    private func addOnView() {
        viewList = [spinningCirclesView, startButton, introMainTitleLabel, introSubTitleLabel]
        
        for uiView in viewList {
            view.addSubview(uiView)
        }
    }
    
    private func viewLayout() {
        view.backgroundColor = .black

        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(300)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        spinningCirclesView.setCircleSizes(bigCircleSize: 80, smallCircleSize: 18, radius: 70)

        spinningCirclesView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(285)
        }
        
        introMainTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(spinningCirclesView.snp.bottom).offset(100)
        }
        
        introSubTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(introMainTitleLabel.snp.bottom).offset(5)
        }
    }
    
    private func addTargets() {
        startButton.addTarget(self, action: #selector(startButtonTouchAction), for: .touchUpInside)
    }
    
    @objc private func startButtonTouchAction() {
        let viewController = MainViewController()
        
        if let navigationController = self.view.window?.rootViewController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}

