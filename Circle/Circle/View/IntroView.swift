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
        
        let image = UIImage(systemName: "arrowtriangle.up")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .ultraLight))
        
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 1, bottom: 4, right: 0)

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
        bigCircleView.backgroundColor = .black
        bigCircleView.layer.cornerRadius = 40
        
        bigCircleView.layer.borderWidth = 1.5
        bigCircleView.layer.borderColor = UIColor.white.withAlphaComponent(0.75).cgColor
        
        addSubview(bigCircleView)

        let radius: CGFloat = 70
        let angleStep = CGFloat(2 * Double.pi / 8)

        for i in 0..<8 {
            let angle = CGFloat(i) * angleStep
            let smallCircleView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
            smallCircleView.backgroundColor = colors[i]
            smallCircleView.layer.cornerRadius = 9
            
            smallCircleView.layer.borderWidth = 1.5
            smallCircleView.layer.borderColor = UIColor.white.withAlphaComponent(0.75).cgColor
            
            smallCircleView.center = CGPoint(x: bigCircleView.center.x + radius * cos(angle), y: bigCircleView.center.y + radius * sin(angle))
            addSubview(smallCircleView)
            smallCircleViews.append(smallCircleView)
        }
    }
}
