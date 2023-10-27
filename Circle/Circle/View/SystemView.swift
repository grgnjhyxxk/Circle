//
//  SystemView.swift
//  Circle
//
//  Created by Jaehyeok Lim on 10/19/23.
//

import UIKit

class SystemView: UIView {
    
    func errorTextLabel() -> UILabel {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textColor = UIColor.red
//        label.font = UIFont.systemFont(ofSize: 12.5)
        label.font = UIFont.systemFont(ofSize: 13.5, weight: .light)
        label.isHidden = true
        
        return label
    }
    
    func activityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .medium)
        
        indicator.hidesWhenStopped = true
        
        return indicator
    }
    
    class LoadingView {
        static var overlayView = UIView()
        static var activityIndicator = UIActivityIndicatorView()
        
        class func show() {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let window = windowScene.windows.first {
                    overlayView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
                    overlayView.backgroundColor = UIColor(white: 0, alpha: 0.5)
                    
                    activityIndicator.style = .large
                    activityIndicator.center = overlayView.center
                    
                    overlayView.addSubview(activityIndicator)
                    window.addSubview(overlayView)
                    
                    activityIndicator.startAnimating()
                }
            }
        }
        
        class func hide() {
            activityIndicator.stopAnimating()
            overlayView.removeFromSuperview()
        }
    }
}
