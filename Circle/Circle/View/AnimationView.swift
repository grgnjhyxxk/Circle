//
//  AnimationView.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/16/23.
//

import UIKit

class SpinningCirclesView: UIView {

    var bigCircleView: UIView!
    var smallCircleViews: [UIView] = []
    
    var colors: [UIColor] = [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.purple, UIColor.black, UIColor.white]
    
    var bigCircleSize: CGFloat = 80
    var smallCircleSize: CGFloat = 18
    var radius: CGFloat = 70
    
    func setCircleSizes(bigCircleSize: CGFloat, smallCircleSize: CGFloat, radius: CGFloat) {
        self.bigCircleSize = bigCircleSize
        self.smallCircleSize = smallCircleSize
        self.radius = radius
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupViews() {
        bigCircleView = UIView(frame: CGRect(x: 0, y: 0, width: bigCircleSize, height: bigCircleSize))
        bigCircleView.center = center
        bigCircleView.backgroundColor = UIColor.clear
        bigCircleView.layer.cornerRadius = bigCircleSize / 2
        
        bigCircleView.layer.borderWidth = 1
        bigCircleView.layer.borderColor = UIColor.white.withAlphaComponent(1).cgColor
        
        addSubview(bigCircleView)

        let radius: CGFloat = radius
        let angleStep = CGFloat(2 * Double.pi / 8)

        for i in 0..<8 {
            let angle = CGFloat(i) * angleStep
            let smallCircleView = UIView(frame: CGRect(x: 0, y: 0, width: smallCircleSize, height: smallCircleSize))
            smallCircleView.backgroundColor = UIColor.white
            smallCircleView.layer.cornerRadius = smallCircleSize / 2
            
            smallCircleView.layer.borderWidth = 1
            smallCircleView.layer.borderColor = UIColor.white.withAlphaComponent(1).cgColor
            
            smallCircleView.center = CGPoint(x: bigCircleView.center.x + radius * cos(angle), y: bigCircleView.center.y + radius * sin(angle))
            addSubview(smallCircleView)
            smallCircleViews.append(smallCircleView)
        }
    }
}

extension SpinningCirclesView {
    func startAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.values = [0, CGFloat.pi / 4, CGFloat.pi / 2, CGFloat.pi * 3 / 4, CGFloat.pi, CGFloat.pi * 5 / 4, CGFloat.pi * 3 / 2, CGFloat.pi * 7 / 4, CGFloat.pi * 2]
        animation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
        animation.duration = 10.0
        animation.repeatCount = .infinity

        layer.add(animation, forKey: nil)

        for (index, smallCircle) in smallCircleViews.enumerated() {
            let smallAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
            smallAnimation.values = animation.values
            smallAnimation.keyTimes = animation.keyTimes
            smallAnimation.duration = animation.duration
            smallAnimation.repeatCount = .infinity
            smallAnimation.beginTime = CACurrentMediaTime() + Double(index) * 0.125

            smallCircle.layer.add(smallAnimation, forKey: nil)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func appDidEnterBackground() {
        layer.removeAnimation(forKey: "rotationAnimation")
        for smallCircle in smallCircleViews {
            smallCircle.layer.removeAnimation(forKey: "rotationAnimation")
        }
    }
    
    @objc func appWillEnterForeground() {
        startAnimation()
    }
}

class AnimationView {
    func shakeView(_ view: UIView) {
        let shake = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shake.timingFunction = CAMediaTimingFunction(name: .easeOut)
        shake.values = [-8, 8, -8, 8, -4, 4, -2, 2, 0]
        shake.duration = 0.7
        view.layer.add(shake, forKey: nil)
    }
}
