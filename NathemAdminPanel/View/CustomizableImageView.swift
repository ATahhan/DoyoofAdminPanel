//
//  CustomizableImageView.swift
//  تطبيق كرام
//
//  Created by يعرب المصطفى on 8/10/16.
//  Copyright © 2016 يعرب المصطفى. All rights reserved.
//

import UIKit
//this class is used to make images with radius or with circular radius
@IBDesignable class CustomizableImageView: UIImageView {
    
    ///////////////ROUNDED CORNERS///////////
    @IBInspectable var cornerRad:CGFloat = 0
        {
            didSet
            {
                self.layer.cornerRadius = cornerRad
        }
    }
    
    @IBInspectable var circled:Bool = false
        {
        didSet{
            self.layer.cornerRadius = self.bounds.width/2
        }
    }
    
    
    
    ///////////////BORDER///////////
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
