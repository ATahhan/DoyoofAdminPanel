//
//  Extensions.swift
//  ClasseraSP
//
//  Created by Ammar AlTahhan on 16/05/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import DZNEmptyDataSet

enum Roles {
    case unknown
    case successPartner
    case student
}

extension UIImage {
    func withAlphaComponent(_ alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        color.set()
        UIRectFill(rect)
        self.draw(at: CGPoint(x: 0, y: 0), blendMode: CGBlendMode.normal, alpha: 1)
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    func resized(to newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

func getTabbarItems(for role: Roles) -> [UIViewController] {
    var pages: [UIViewController] = []
    let offersNC = UIViewController.instantiateVC("OffersNC")
    let allPartnersNC = UIViewController.instantiateVC("AllPartnersNC")
    let loginVC = UIViewController.instantiateVC("LoginController")
    let scanVC = UIViewController.instantiateVC("ScanningView")
    let scanLogsVC = UIViewController.instantiateVC("ScanningLogs")
    let profile = UIViewController.instantiateVC("PublicProfile")
    switch role {
    case .successPartner:
        pages.append(offersNC)
        pages.append(scanVC)
        pages.append(allPartnersNC)
        pages.append(scanLogsVC)
        pages.append(profile)
    case .student:
        pages.append(offersNC)
        pages.append(allPartnersNC)
        pages.append(profile)
    default: //unknown
        pages.append(offersNC)
        pages.append(allPartnersNC)
        pages.append(loginVC)
    }
    return pages
}

func readRole() -> String? {
    let preferences = UserDefaults.standard
    _ = preferences.object(forKey: "auth")
    _ = preferences.object(forKey: "Uid")
    let roleId = preferences.object(forKey: "role")
    return roleId as? String
}

extension UITabBarController {
    static func instantiateTBC(_ withIdentifier: String, _ fromStoryboardName: String = "New") -> UITabBarController {
        return UIStoryboard(name: fromStoryboardName, bundle: nil).instantiateViewController(withIdentifier: withIdentifier) as! UITabBarController
    }
}

extension UIViewController {
    static func instantiateVC(_ withIdentifier: String, _ fromStoryboardName: String = "New") -> UIViewController {
        return UIStoryboard(name: fromStoryboardName, bundle: nil).instantiateViewController(withIdentifier: withIdentifier)
    }
    
    func showProgressHUD() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }

    func hideProgressHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func showMessage(title: String, message: String, completion: (()->Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default) { (action) -> Void in
            completion?()
        }
        
        alertController.addAction(dismissAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showPromptMessage(title: String, message: String, approveMessage: String = "OK", approveInteractionStyle: UIAlertActionStyle = UIAlertActionStyle.default, completionHandler: @escaping (Bool) -> ()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: approveInteractionStyle) { (action) -> Void in
            completionHandler(true)
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            completionHandler(false)
        }
        
        alertController.addAction(okAction)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UINavigationController {
    func pushViewController(_ withIdentifier: String, _ fromStoryboardName: String = "New") -> UIViewController {
        let viewController = UIStoryboard(name: fromStoryboardName, bundle: nil).instantiateViewController(withIdentifier: withIdentifier)
        self.pushViewController(viewController, animated: true)
        return viewController
    }
}

extension UICollectionView {
    func startAutoScroll(delaySeconds: TimeInterval) {
        var autoScrollCounter = 1
        Timer.scheduledTimer(withTimeInterval: delaySeconds, repeats: true) { (timer) in
            let indexPath = IndexPath(item: Int(autoScrollCounter) % self.numberOfItems(inSection: 0), section: 0)
            self.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            autoScrollCounter += 1
        }
    }
}

extension UIColor {
    class var greyBackground: UIColor {
        //        return UIColor(rgb: 0x5F5F5F)
        return UIColor(rgb: 0x3F3F3F)
    }
    
    class var lightBlueBackground: UIColor {
        return UIColor(rgb: 0xF7F9FA)
    }
    
    class var mainBlue: UIColor {
        return UIColor(rgb: 0x377AB4)
    }
    
    class var mainLightBlue: UIColor {
        return UIColor(rgb: 0x4D88AD)
    }
    
    class var secondaryGreen: UIColor {
        return UIColor(red:0.51, green:0.82, blue:0.51, alpha:1)
    }
    
    class var whiteContent: UIColor {
        return UIColor(rgb: 0xF7F9FA)
    }
    
    class var greyContent: UIColor {
        return UIColor(rgb: 0xB6C9D1 )
    }
    
    class var greenScore: UIColor {
        return UIColor(rgb: 0xafd136)
    }
    
    class var silverScore: UIColor {
        return UIColor(rgb: 0xa6a6a6)
    }
    
    class var goldScore: UIColor {
        return UIColor(rgb: 0xB8860B)
    }
    
    class var platinumScore: UIColor {
        return UIColor(rgb: 0x6a420c)
    }
    
    class var diamondScore: UIColor {
        return UIColor(rgb: 0x730c16)
    }
    
    class var vipScore: UIColor {
        return UIColor(rgb: 0xafd136)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UIView {
    
//    @IBInspectable var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }
//    
//    @IBInspectable var borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//        }
//    }
//    
//    @IBInspectable var borderColor: UIColor? {
//        get {
//            return UIColor(cgColor: layer.borderColor!)
//        }
//        set {
//            layer.borderColor = newValue?.cgColor
//        }
//    }
//    
//    @IBInspectable
//    var shadowRadius: CGFloat {
//        get {
//            return layer.shadowRadius
//        }
//        set {
//            layer.shadowRadius = newValue
//        }
//    }
//    
//    @IBInspectable
//    var shadowOpacity: Float {
//        get {
//            return layer.shadowOpacity
//        }
//        set {
//            layer.shadowOpacity = newValue
//        }
//    }
//    
//    @IBInspectable
//    var shadowOffset: CGSize {
//        get {
//            return layer.shadowOffset
//        }
//        set {
//            layer.shadowOffset = newValue
//        }
//    }
//    
//    @IBInspectable
//    var shadowColor: UIColor? {
//        get {
//            if let color = layer.shadowColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            if let color = newValue {
//                layer.shadowColor = color.cgColor
//            } else {
//                layer.shadowColor = nil
//            }
//        }
//    }
    
    var rootSuperView: UIView {
        var view = self
        while let s = view.superview {
            view = s
        }
        return view
    }
    
    var currentHeightVisibilityPercentage: CGFloat {
        let visibleRect = self.bounds.intersection((superview?.bounds)!)
        let visibleHeight = visibleRect.height
        return visibleHeight/self.frame.height
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
    
    func hasConstraint(withAttribute attribute: NSLayoutAttribute) -> Bool {
        for constraint in self.constraints {
            if constraint.firstAttribute == attribute || constraint.secondAttribute == attribute {
                return true
            }
        }
        return false
    }
    
    func getConstraint(withAttribute attribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        for constraint in self.constraints {
            if constraint.firstAttribute == attribute || constraint.secondAttribute == attribute {
                return constraint
            }
        }
        return nil
    }
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
    func setClearButtonTintColor(_ color: UIColor) {
        let clearButton = self.value(forKey: "clearButton") as! UIButton
        clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton.tintColor = color
    }
}

extension UIImageView {
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func loadImageWithUrl (url: String) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: url),
                         options: [.transition(.fade(0.5))],
                         progressBlock: nil,
                         completionHandler: nil)
    }
    
    func loadImageWithUrl (url: String, placeholder: UIImage) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: url), placeholder: #imageLiteral(resourceName: "user"), options: [.transition(.fade(0.5))], progressBlock: nil, completionHandler: nil)
    }
    
    func loadImageWithUrl (url: String, _ completionHandler: @escaping (_ image: UIImage)->Void) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: url), options: [.transition(.fade(0.5))], progressBlock: nil) { (image, _, _, _) in
            guard let image = image else { return }
            completionHandler(image)
        }
    }
    
    func addEnlargability() {
        let imageView = self
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        
        let transition = CATransition()
        //        transition.type = kCATransitionReveal
        transition.type = kCATransitionPush
        //        transition.subtype = kCATransitionFade
        transition.subtype = kCATransitionReveal
        transition.duration = 0.2
        rootSuperView.layer.add(transition, forKey: "transition")
        
        rootSuperView.addSubview(newImageView)
        parentViewController?.navigationController?.isNavigationBarHidden = true
        parentViewController?.tabBarController?.tabBar.isHidden = true
        
        UIApplication.shared.isStatusBarHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        parentViewController?.navigationController?.isNavigationBarHidden = false
        parentViewController?.tabBarController?.tabBar.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            sender.view?.alpha = 0
        }) { (_) in
            sender.view?.removeFromSuperview()
            UIApplication.shared.isStatusBarHidden = false
        }
    }
    
    func fill(withColor color: UIColor) {
        self.image = self.image!.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}

class TextField: UITextField {
    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
}


extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    var coordinatesTupled: (String, String) {
        if self == "nil" {
            return ("nil","nil")
        }
        let subs = self.components(separatedBy: ", ")
        return (String(subs[0]), String(subs[1]))
    }
    
    var lastUrlSubDirectory: String? {
        guard let lastSlashIndex = self.range(of: "/", options: .backwards)?.lowerBound else { return nil }
        return self.substring(from: self.index(after: lastSlashIndex))
    }
}

extension CGRect {
    func shrinkedCGRect(by pixels: CGFloat) -> CGRect {
        return CGRect(x: minX, y: minY, width: width-pixels, height: height-pixels)
    }
}

extension UIApplication {
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if let url = URL(string: url) {
                if application.canOpenURL(url) {
                    application.open(url, options: [:], completionHandler: nil)
                    return
                }
            }
        }
    }
}

