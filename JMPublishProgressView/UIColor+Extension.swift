//
//  UIColor+Extension.swift
//  Jimu
//
//  Created by 凌斌 on 2017/12/22.
//  Copyright © 2017年 ubt. All rights reserved.
//

import UIKit

extension UIColor {
    
    
    /// RGB颜色
    ///
    /// - Parameters:
    ///   - red: R
    ///   - green: G
    ///   - blue: B
    ///   - alpha: A
    convenience init(red:Int, green:Int, blue:Int, alpha:CGFloat = 1.0) {
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    
    /// 16进制颜色
    ///
    /// - Parameters:
    ///   - rgb: RGB Int值
    ///   - alpha: 透明度
    convenience init(hex rgb:Int, alpha:CGFloat = 1.0) {
        self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF, alpha: alpha)
    }

    
    /// 随机颜色
    ///
    /// - Parameter randomAlpha: 是否随机透明度,默认false
    /// - Returns: 随机颜色
    public static func random(randomAlpha: Bool = false) -> UIColor {
        let randomRed = CGFloat(Float(arc4random()) / 0xFFFFFFFF)
        let randomGreen = CGFloat(Float(arc4random()) / 0xFFFFFFFF)
        let randomBlue = CGFloat(Float(arc4random()) / 0xFFFFFFFF)
        let alpha = randomAlpha ? CGFloat(Float(arc4random()) / 0xFFFFFFFF) : 1.0
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
    
}
