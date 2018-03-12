//
//  JMPublishProgressView.swift
//  Jimu
//
//  Created by CXY on 2018/3/10.
//  Copyright © 2018年 ubt. All rights reserved.
//

import UIKit

extension Double {
    var angle2Radian: CGFloat {
        return CGFloat(self/180.0*Double.pi)
    }
}

private let ProgressLineWidth = CGFloat(15)

class JMPublishProgressView: UIView {
    
    private lazy var path: UIBezierPath = {
        let radius = (bounds.width-2*ProgressLineWidth)/2.0
        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.width/2, y: bounds.height/2), radius: CGFloat(radius), startAngle: -360.0.angle2Radian, endAngle: 0.0.angle2Radian, clockwise: true) // 构建圆形
        return path
    }()
    
    private lazy var trackLayer: CAShapeLayer = {
        let trackLayer = CAShapeLayer()
        trackLayer.frame = bounds
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = strokeColor.cgColor
        trackLayer.opacity = 0.25
        trackLayer.lineCap = kCALineCapRound
        trackLayer.lineWidth = ProgressLineWidth
        trackLayer.path = path.cgPath
        return trackLayer
    }()
    
    private lazy var progressLayer: CAShapeLayer = {
        let progressLayer = CAShapeLayer()
        progressLayer.frame = bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.red.cgColor //这个一定不能用clearColor，然显示不出来
        progressLayer.lineCap = kCALineCapRound
        progressLayer.lineWidth = ProgressLineWidth
        progressLayer.path = path.cgPath
        progressLayer.strokeEnd = 0.0
        return progressLayer
    }()
    
    private lazy var gradientLayer: CALayer = {
        //生成渐变色
        let gradientLayer = CALayer()
        
        //左侧渐变色
        let leftLayer = CAGradientLayer()
        leftLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width / 2, height: self.bounds.size.height);  // 分段设置渐变色
        leftLayer.locations = [0.3, 0.9, 1]
        leftLayer.colors = [UIColor(hex: 0x277DF0).cgColor, UIColor(hex: 0x32CAD5).cgColor]
        gradientLayer.addSublayer(leftLayer)
        
        //右侧渐变色
        let rightLayer = CAGradientLayer()
        rightLayer.frame = CGRect(x: self.bounds.size.width / 2, y: 0, width: self.bounds.size.width / 2, height: self.bounds.size.height);
        rightLayer.locations = [0.3, 0.9, 1];
        rightLayer.colors = [UIColor(hex: 0x277DF0).cgColor, UIColor(hex: 0x32CAD5).cgColor]
        gradientLayer.addSublayer(rightLayer)
        
        gradientLayer.mask = progressLayer  //用progressLayer来截取渐变层
        return gradientLayer
    }()
    
    private var strokeColor = UIColor.clear
    
    private var _progress = CGFloat(0.0)
    
    var progress: CGFloat {
        return _progress
    }
    
    func setProgress(_ precent: CGFloat, animated: Bool) {
        if precent < 0 || precent > 1 {
            return
        }
        _progress = precent
        CATransaction.begin()
        CATransaction.setDisableActions(!animated)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
        CATransaction.setAnimationDuration(0.5)
        progressLayer.strokeEnd = precent
        CATransaction.commit()
    }
    
    func startAnimation() {
        setProgress(1.0, animated: true)
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.rotation"
        animation.values = [-360.0.angle2Radian, 0.0.angle2Radian]
        animation.autoreverses = true
        animation.repeatCount = MAXFLOAT
        animation.duration = 0.5
        layer.add(animation, forKey: "DeleteAppShake")
    }
    
    func stopAnimation() {
        layer.removeAllAnimations()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addLayers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addLayers()
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        addLayers()
    }
    
    private func addLayers() {
//        strokeColor = UIColor.green

        layer.addSublayer(trackLayer)
        layer.addSublayer(gradientLayer)
    }

}
