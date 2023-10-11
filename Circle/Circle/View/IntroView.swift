//
//  IntroView.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/11/23.
//

import UIKit

class IntroView: UIView {

}

class SpinningCirclesView: UIView {

    var bigCircleView: UIView!
    var smallCircleViews: [UIView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        bigCircleView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        bigCircleView.center = center
        bigCircleView.backgroundColor = .white
        bigCircleView.layer.cornerRadius = 40
        addSubview(bigCircleView)

        let radius: CGFloat = 70
        let angleStep = CGFloat(2 * Double.pi / 8)

        for i in 0..<8 {
            let angle = CGFloat(i) * angleStep
            let smallCircleView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
            smallCircleView.backgroundColor = .white
            smallCircleView.layer.cornerRadius = 9
            smallCircleView.center = CGPoint(x: bigCircleView.center.x + radius * cos(angle), y: bigCircleView.center.y + radius * sin(angle))
            addSubview(smallCircleView)
            smallCircleViews.append(smallCircleView)
        }
    }
}
