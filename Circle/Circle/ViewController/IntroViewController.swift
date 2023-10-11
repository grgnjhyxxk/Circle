//
//  ViewController.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/11/23.
//

import UIKit

class IntroViewController: UIViewController {
    
    var spinningCirclesView: SpinningCirclesView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black

        spinningCirclesView = SpinningCirclesView(frame: view.bounds)
        view.addSubview(spinningCirclesView)

        startAnimation()
    }

    func startAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.values = [0, CGFloat.pi / 4, CGFloat.pi / 2, CGFloat.pi * 3 / 4, CGFloat.pi, CGFloat.pi * 5 / 4, CGFloat.pi * 3 / 2, CGFloat.pi * 7 / 4, CGFloat.pi * 2]
        animation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
        animation.duration = 5.0
        animation.repeatCount = .infinity

       view.layer.add(animation, forKey: nil)

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

