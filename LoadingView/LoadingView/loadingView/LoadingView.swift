//
//  LoadingView.swift
//  LoadingView
//
//  Created by chuangchuang wang on 2018/4/3.
//  Copyright © 2018年 chuangchuang wang. All rights reserved.
//

import UIKit

let CycleColorRed = UIColor(hexString: "#bb0a30")
let CycleColorWhite = UIColor(hexString: "#ffffff")
let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

class LoadingView: UIView {
    var lineWidth: CGFloat = 2.0
    var lineColors: [UIColor] = [CycleColorRed]
    private var progressLayer: CAShapeLayer = CAShapeLayer()
    private let animationGroup = CAAnimationGroup()
    private let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    
    init(frame: CGRect, lineWidth width: CGFloat, lineColors colors: [UIColor]) {
        super.init(frame: frame)
        self.lineWidth = width
        self.lineColors = colors
        self.setUp()
    }
    
    fileprivate func setUp() {
        assert(self.lineWidth > 0, "line width must be greater than zero")
        assert(self.lineColors.isEmpty == false, "line colors should be set")
        
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = 2 * CGFloat.pi
        rotateAnimation.repeatCount = HUGE
        rotateAnimation.duration = 3.0
        rotateAnimation.beginTime = 0.0
        //rotateAnimation.fillMode = kCAFillModeForwards
        rotateAnimation.isRemovedOnCompletion = false
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.0
        strokeEndAnimation.toValue = 1.0
        strokeEndAnimation.duration = 1.0
        strokeEndAnimation.beginTime = 0.0
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = 0.0
        strokeStartAnimation.toValue = 1.0
        strokeStartAnimation.duration = 1.0
        strokeStartAnimation.beginTime = 1.0
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        animationGroup.duration = 2.0
        animationGroup.repeatCount = HUGE
        //animationGroup.fillMode = kCAFillModeForwards
        animationGroup.isRemovedOnCompletion = false
        animationGroup.animations = [strokeEndAnimation, strokeStartAnimation]
        
        let rect = CGRect(x: self.lineWidth, y: self.lineWidth, width: self.frame.size.width - 2 * self.lineWidth, height: self.frame.size.height - 2 * self.lineWidth)
        let path = UIBezierPath(ovalIn: rect)
        self.progressLayer.lineWidth = self.lineWidth
        self.progressLayer.lineCap = kCALineCapRound
        self.progressLayer.strokeColor = self.lineColors.first?.cgColor
        self.progressLayer.fillColor = UIColor.clear.cgColor
        self.progressLayer.strokeStart = 0.0
        self.progressLayer.strokeEnd = 1.0
        self.progressLayer.path = path.cgPath
    }
    
    func startAnimation() {
        self.progressLayer.add(animationGroup, forKey: "strokeAnim")
        self.layer.addSublayer(self.progressLayer)
        self.layer.add(rotateAnimation, forKey: "rotationAnimation")
        self.progressLayer.isHidden = false
    }
    
    func endAnimation() {
        self.progressLayer.isHidden = true
        self.progressLayer.removeAnimation(forKey: "strokeAnim")
        self.progressLayer.removeFromSuperlayer()
        self.layer.removeAnimation(forKey: "rotationAnimation")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
