//
//  PlaceHolderAnimation.swift
//  CAGradientLayer
//
//  Created by Thanh Nguyen Xuan on 9/14/18.
//  Copyright © 2018 Thanh Nguyen. All rights reserved.
//

import UIKit

var gradientLayerKey = "gradientLayer"
var overlayViewKey = "overlayView"

extension UIColor {

    class func backgroundGray() -> UIColor {
        return UIColor(red: 246.0 / 255, green: 247 / 255, blue: 248 / 255, alpha: 1)
    }

    class func lightGray() -> UIColor {
        return UIColor(red: 238.0 / 255, green: 238 / 255, blue: 238 / 255, alpha: 1)
    }

    class func darkGray() -> UIColor {
        return UIColor(red: 221.0 / 255, green: 221 / 255, blue: 221 / 255, alpha: 1)
    }

}

class OverlayView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        // Set màu cho context và đổ màu trắng toàn bộ view
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(bounds)
        // Set blend mode và màu trong suốt để chuẩn bị 'đục lỗ'
        context?.setBlendMode(.clear)
        context?.setFillColor(UIColor.clear.cgColor)
        // Tìm tất cả các subview của contentView, trừ chính overlay view và đổ màu trong suốt
        superview?.subviews.forEach({
            if $0 != self {
                context?.fill($0.frame)
            }
        })
    }

}

extension UIView {

    func startAnimationLoading() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor.backgroundGray().cgColor,
            UIColor.lightGray().cgColor,
            UIColor.darkGray().cgColor,
            UIColor.lightGray().cgColor,
            UIColor.backgroundGray().cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: -0.85, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.15, y: 0)
        gradientLayer.locations = [-0.85, -0.85, 0, 0.15, 1.15]
        // Khởi tạo CABasicAnimation với keyPath muốn animate là `locations`
        let animation = CABasicAnimation(keyPath: "locations")
        // Giá trị `locations` bắt đầu animate
        animation.fromValue = gradientLayer.locations
        // Giá trị `locations` kết thúc animate
        animation.toValue = [0, 1, 1, 1.05, 1.15]
        // Lặp animation vô hạn
        animation.repeatCount = .infinity
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.duration = 1
        // Add animation cho gradient layer
        gradientLayer.add(animation, forKey: "what.ever.it.take")
        layer.addSublayer(gradientLayer)
        addOverlayView()
        objc_setAssociatedObject(self, &gradientLayerKey, gradientLayer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func stopAnimationLoading() {
        let overlayView = objc_getAssociatedObject(self, &overlayViewKey) as? OverlayView
        let gradientLayer = objc_getAssociatedObject(self, &gradientLayerKey) as? CAGradientLayer
        overlayView?.removeFromSuperview()
        gradientLayer?.removeFromSuperlayer()
    }

    private func addOverlayView() {
        let overlayView = OverlayView()
        overlayView.frame = bounds
        overlayView.backgroundColor = .clear
        addSubview(overlayView)
        objc_setAssociatedObject(self, &overlayViewKey, overlayView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

}
