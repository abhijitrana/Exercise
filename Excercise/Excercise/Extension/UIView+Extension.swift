//
//  UIView+Extension.swift
//  Excercise
//
//  Created by Umesh Verma on 06/11/18.
//  Copyright © 2018 Umesh Verma. All rights reserved.
//

import UIKit
@IBDesignable
extension UIView {
    
    @IBInspectable
    var cornerRadiusExt: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius)
            layer.shadowPath = shadowPath.cgPath
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable
    var borderWidthExt: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColorExt: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadiusExt: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowOffset = CGSize.zero
            layer.shadowRadius = shadowRadiusExt
        }
    }
    
    @IBInspectable
    var shadowOpacityExt:Float {
        get{
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowColorExt:UIColor? {
        get{
            let color = UIColor(cgColor: layer.shadowColor!)
            return color
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
}
