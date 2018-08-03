//
//  CustomizableTextField.swift
//  SDB
//
//  Created by يعرب المصطفى on 6/24/18.
//  Copyright © 2018 yarob. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableTextField: UITextField {
    
    var shadowRadiusSteps:Float = 100.0
    @IBInspectable var cornerRad:CGFloat = 0
        {
        didSet{
            self.layer.cornerRadius = cornerRad
        }
    }
    
    
    
    
    @IBInspectable var yShadow:CGFloat = 0
        {
        didSet{
            layer.shadowOffset = CGSize(width: xShadow, height: yShadow)
        }
    }
    
    @IBInspectable var xShadow:CGFloat = 0
        {
        didSet{
            layer.shadowOffset = CGSize(width: xShadow, height: yShadow)
        }
    }
    
    @IBInspectable var shadowOpacity:Float = 0
        {
        didSet{
            layer.shadowOpacity = shadowOpacity/shadowRadiusSteps
            
        }
    }
    
    
    @IBInspectable var shadowColor:UIColor = UIColor.black
        {
        didSet{
            layer.shadowColor = shadowColor.cgColor
            
        }
    }
    
    
    @IBInspectable var shadowRadius:CGFloat = 0
        {
        didSet{
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 0
        {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor:UIColor = UIColor.black
        {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
