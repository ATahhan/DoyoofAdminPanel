//
//  CustomizableLabel.swift
//  SDB
//
//  Created by يعرب المصطفى on 6/25/18.
//  Copyright © 2018 yarob. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableLabel: UILabel {
    
    ////////////////////CORNER RADIUS////////////////
    var shadowRadiusSteps:Float = 20.0
    @IBInspectable var cornerRad:CGFloat = 0
        {
        didSet{
            self.layer.cornerRadius = cornerRad
        }
    }
    //make sure to make the lable clips to bounds in order to apply the affect of the corner radius
    
    
    
    
    ///////////////SHADOW//////////////////
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
    
    
    @IBInspectable var shadowRadius:CGFloat = 0
        {
        didSet{
            layer.shadowRadius = shadowRadius
        }
    }
    
    
    
    /////////////////////BORDER//////////////////
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
    
    
    @IBInspectable var isCircled:Bool = false
        {
        didSet{
            if isCircled
            {
                self.layer.cornerRadius = self.frame.height/2
            }else
            {
                self.layer.cornerRadius = 0
            }
            
        }
    }

}
