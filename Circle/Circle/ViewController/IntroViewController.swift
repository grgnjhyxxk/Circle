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
        startAnimation()
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
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

    
    private func startAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.values = [0, CGFloat.pi / 4, CGFloat.pi / 2, CGFloat.pi * 3 / 4, CGFloat.pi, CGFloat.pi * 5 / 4, CGFloat.pi * 3 / 2, CGFloat.pi * 7 / 4, CGFloat.pi * 2]
        animation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
        animation.duration = 10.0
        animation.repeatCount = .infinity

        spinningCirclesView.layer.add(animation, forKey: nil)

        for (index, smallCircle) in spinningCirclesView.smallCircleViews.enumerated() {
            let smallAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
            smallAnimation.values = animation.values
            smallAnimation.keyTimes = animation.keyTimes
            smallAnimation.duration = animation.duration
            smallAnimation.repeatCount = .infinity
            smallAnimation.beginTime = CACurrentMediaTime() + Double(index) * 0.125
            
            smallCircle.layer.add(smallAnimation, forKey: nil)
        }
    }
}

