//
//  Appearance.swift
//  ClasseraSP
//
//  Created by Ammar AlTahhan on 18/05/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import DZNEmptyDataSet

struct Appearance {
    static func setGlobalAppearance() {
        UIApplication.shared.statusBarStyle = .lightContent
        
        UINavigationBar.appearance().backgroundColor = .mainBlue
        UINavigationBar.appearance().tintColor = .whiteContent
        UINavigationBar.appearance().barTintColor = .mainBlue
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.whiteContent
        ]
        if #available(iOS 11.0, *) {
            UINavigationBar.appearance().largeTitleTextAttributes = [
                NSAttributedStringKey.foregroundColor: UIColor.whiteContent
            ]
            UINavigationBar.appearance().prefersLargeTitles = true
        }
        
        UITabBar.appearance().tintColor = .whiteContent
        UITabBar.appearance().barTintColor = .mainBlue
        UITabBar.appearance().unselectedItemTintColor = .greyContent
        
        
    }
}

extension UIViewController {
    func setCurvedGradientNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        let gradient = CAGradientLayer()
        let originalHeight = UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height
        let originalWidth = UIApplication.shared.statusBarFrame.width
        gradient.frame = CGRect(x: 0, y: 0, width: originalWidth, height: originalHeight)
        gradient.locations = [0.0,1.0]
        gradient.startPoint = CGPoint(x: gradient.frame.size.width*0.4, y: gradient.frame.size.height*0.9)
        gradient.endPoint = CGPoint(x: gradient.frame.size.width, y: gradient.frame.size.height * -0.5)
        gradient.colors = [UIColor.mainBlue.cgColor, UIColor.mainLightBlue.cgColor]
        
        let curvedLayer = CAShapeLayer()
        let curvedHeight: CGFloat = 150
        curvedLayer.frame = CGRect(x: 0, y: originalHeight, width: originalWidth, height: curvedHeight)
        curvedLayer.backgroundColor = UIColor.mainBlue.cgColor
        let curvedPath = UIBezierPath()
        curvedPath.move(to: CGPoint(x: 0, y: 80))
        curvedPath.addCurve(to: CGPoint(x: originalWidth, y: curvedHeight), controlPoint1: CGPoint(x: (originalWidth/2)-80, y: 120), controlPoint2: CGPoint(x: originalWidth, y: curvedHeight))
        curvedPath.addLine(to: CGPoint(x: originalWidth, y: -2))
        curvedPath.addLine(to: CGPoint(x: 0, y: -2))
        curvedPath.close()
        let mask = CAShapeLayer()
        mask.path = curvedPath.cgPath
        curvedLayer.mask = mask
        
        view.layer.addSublayer(gradient)
//        view.layer.insertSublayer(curvedLayer, at: 0)
    }
    
    func setGradientNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        let gradient = CAGradientLayer()
        let originalHeight = UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height
        let originalWidth = UIApplication.shared.statusBarFrame.width
        gradient.frame = CGRect(x: 0, y: 0, width: originalWidth, height: originalHeight)
        gradient.locations = [0.0,1.0]
        gradient.startPoint = CGPoint(x: gradient.frame.size.width*0.4, y: gradient.frame.size.height*0.9)
        gradient.endPoint = CGPoint(x: gradient.frame.size.width, y: gradient.frame.size.height * -0.5)
        gradient.colors = [UIColor.mainBlue.cgColor, UIColor.mainLightBlue.cgColor]
        
        view.layer.insertSublayer(gradient, at: 0)
//        self.view.layer.addSublayer(gradient)
    }
    
    func removeCurvedGradientNavigationBar() {
        
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat, withShadowRadius shadowRadius: CGFloat, shadowOffset: CGSize = CGSize.zero, shadowColor: CGColor = UIColor(red:0, green:0, blue:0, alpha:1).cgColor, shadowOpacity: Float) {
        let fillColor = backgroundColor
        backgroundColor = .clear
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomRight, .bottomLeft], cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.fillColor = fillColor?.cgColor
        
        mask.shadowOffset = shadowOffset
        mask.shadowColor = shadowColor
        mask.shadowOpacity = shadowOpacity
        mask.shadowRadius = radius
        mask.shadowPath = path.cgPath
        
        layer.insertSublayer(mask, at: 0)
    }
    
    func unroundCorners() {
        self.layer.mask = nil
    }
    
    func addCurvedShadowPath(shadowHeight: CGFloat = 10) {
        let shadowPath = CGMutablePath()
        shadowPath.move(to: CGPoint(x: layer.shadowRadius,
                                    y: shadowHeight))
        shadowPath.addLine(to: CGPoint(x: layer.shadowRadius,
                                       y: -shadowHeight))
        shadowPath.addLine(to: CGPoint(x: layer.bounds.width - layer.shadowRadius,
                                       y: -shadowHeight))
        shadowPath.addLine(to: CGPoint(x: layer.bounds.width - layer.shadowRadius,
                                       y: shadowHeight))
        
        shadowPath.addQuadCurve(to: CGPoint(x: layer.shadowRadius,
                                            y: shadowHeight),
                                control: CGPoint(x: layer.bounds.width / 2,
                                                 y: -shadowHeight))
        
        layer.shadowPath = shadowPath
    }
    
    func animateScaleDownUp(_ duration: TimeInterval = 0.25, _ delay: TimeInterval = 0, _ damping: CGFloat = 0.9, _ initialVelocity: CGFloat = 0, _ options: UIViewAnimationOptions = .curveLinear, _ completion: @escaping ()->Void?) {
        self.animateScaleDown(duration, delay, damping, initialVelocity, options) { () -> Void? in
            self.animateIdentity(duration, delay, damping, initialVelocity, options, { () -> Void? in
                completion()
            })
        }
    }
    
    func animateScaleDown(_ duration: TimeInterval = 0.25, _ delay: TimeInterval = 0, _ damping: CGFloat = 0.9, _ initialVelocity: CGFloat = 0, _ options: UIViewAnimationOptions = .curveLinear, _ completion: @escaping ()->Void?) {
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: initialVelocity, options: options, animations: {
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }) { (_) in
            completion()
        }
    }
    
    func animateIdentity(_ duration: TimeInterval = 0.15, _ delay: TimeInterval = 0, _ damping: CGFloat = 0.6, _ initialVelocity: CGFloat = 0, _ options: UIViewAnimationOptions = .curveLinear, _ completion: @escaping ()->Void?) {
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: initialVelocity, options: options, animations: {
            self.transform = .identity
        }) { (_) in
            completion()
        }
    }
    
    enum Directions {
        case toLeft
        case toRight
        case toTop
        case toBottom
    }
    
    func animateShake(translationX: CGFloat, y: CGFloat, _ duration: TimeInterval = 0.55, _ delay: TimeInterval = 0.40, _ damping: CGFloat = 0.9, _ initialVelocity: CGFloat = 0, _ options: UIViewAnimationOptions = .curveLinear, _ completion: @escaping ()->Void?) {
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: initialVelocity, options: options, animations: {
            self.transform = CGAffineTransform(translationX: translationX, y: y)
        }) { (_) in
            UIView.animate(withDuration: duration-0.15, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: initialVelocity, options: options, animations: {
                self.transform = .identity
            }) { (_) in
                completion()
            }
        }
    }
}

struct AppFontName {
    static let regular = "Lemonada-Regular"
    static let bold = "Lemonada-Bold"
    static let italic = "Lemonada-Light"
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage =
        UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: size)!
    }
    
    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold, size: size)!
    }
    
    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.italic, size: size)!
    }
    
    @objc convenience init(myCoder aDecoder: NSCoder) {
        if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
            if let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String {
                var fontName = ""
                switch fontAttribute {
                case "CTFontRegularUsage":
                    fontName = AppFontName.regular
                case "CTFontEmphasizedUsage", "CTFontBoldUsage":
                    fontName = AppFontName.bold
                case "CTFontObliqueUsage":
                    fontName = AppFontName.italic
                default:
                    fontName = AppFontName.regular
                }
                self.init(name: fontName, size: fontDescriptor.pointSize)!
            }
            else {
                self.init(myCoder: aDecoder)
            }
        }
        else {
            self.init(myCoder: aDecoder)
        }
    }
    
    class func overrideInitialize() {
        if self == UIFont.self {
            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:)))
            method_exchangeImplementations(systemFontMethod!, mySystemFontMethod!)
            
            let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:)))
            method_exchangeImplementations(boldSystemFontMethod!, myBoldSystemFontMethod!)
            
            let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:)))
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:)))
            method_exchangeImplementations(italicSystemFontMethod!, myItalicSystemFontMethod!)
            
            let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))) // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))
            method_exchangeImplementations(initCoderMethod!, myInitCoderMethod!)
        }
    }
}

@IBDesignable class TopAlignedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        if let stringText = text {
            let stringTextAsNSString = stringText as NSString
            let labelStringSize = stringTextAsNSString.boundingRect(with: CGSize(width: self.frame.width,height: CGFloat.greatestFiniteMagnitude),
                                                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                                    attributes: [NSAttributedStringKey.font: font],
                                                                    context: nil).size
            super.drawText(in: CGRect(x:0,y: 0,width: self.frame.width, height:ceil(labelStringSize.height)))
        } else {
            super.drawText(in: rect)
        }
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.borderWidth = 0
        layer.borderColor = UIColor.black.cgColor
    }
}
