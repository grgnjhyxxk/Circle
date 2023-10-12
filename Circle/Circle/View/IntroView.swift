//
//  IntroView.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/11/23.
//

import UIKit

class IntroView: UIView {
    
    func startButton() -> UIButton {
        let button = UIButton()
        
        let image = UIImage(systemName: "chevron.left.2")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 25, weight: .ultraLight))
        
//        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 1, bottom: 4, right: 0)

        button.setImage(image, for: .normal)
        button.tintColor = UIColor.white.withAlphaComponent(0.75)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        button.layer.cornerRadius = 25
        
        return button
    }

    
    func introMainTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "Circle"
        label.textColor = UIColor.white
//        label.font = UIFont(name: "NotoSans-ExtraLight", size: 24)
        label.font = UIFont(name: "NotoSans-Thin", size: 24)

        return label
    }
    
    func introSubTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "Tranquility in abundance."
        label.textColor = UIColor.white
        label.font = UIFont(name: "NotoSans-ExtraLight", size: 14)
//        label.font = UIFont(name: "NotoSans-Thin", size: 14.5)
        
        return label
    }
}

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
        bigCircleView.backgroundColor = .black
        bigCircleView.layer.cornerRadius = bigCircleSize / 2
        
        bigCircleView.layer.borderWidth = 1.5
        bigCircleView.layer.borderColor = UIColor.white.withAlphaComponent(0.75).cgColor
        
        addSubview(bigCircleView)

        let radius: CGFloat = radius
        let angleStep = CGFloat(2 * Double.pi / 8)

        for i in 0..<8 {
            let angle = CGFloat(i) * angleStep
            let smallCircleView = UIView(frame: CGRect(x: 0, y: 0, width: smallCircleSize, height: smallCircleSize))
            smallCircleView.backgroundColor = .clear
            smallCircleView.layer.cornerRadius = smallCircleSize / 2
            
            smallCircleView.layer.borderWidth = 1.5
            smallCircleView.layer.borderColor = UIColor.white.withAlphaComponent(0.75).cgColor
            
            smallCircleView.center = CGPoint(x: bigCircleView.center.x + radius * cos(angle), y: bigCircleView.center.y + radius * sin(angle))
            addSubview(smallCircleView)
            smallCircleViews.append(smallCircleView)
        }
    }
}
