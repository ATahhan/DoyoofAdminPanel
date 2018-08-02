//
//  MainButton.swift
//  ClasseraSP
//
//  Created by Ammar AlTahhan on 03/06/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import UIKit

class MainButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 8
        layer.backgroundColor = UIColor.secondaryGreen.cgColor
        setTitleColor(.white, for: .normal)
        setTitleColor(.greyContent, for: .selected)
        
        addTarget(self, action: #selector(buttonAction), for: .touchDown)
        addTarget(self, action: #selector(unbuttonAction), for: UIControlEvents.touchDragExit)
        addTarget(self, action: #selector(unbuttonAction), for: UIControlEvents.touchDragOutside)
        addTarget(self, action: #selector(unbuttonAction), for: UIControlEvents.touchUpOutside)
        addTarget(self, action: #selector(unbuttonAction), for: UIControlEvents.touchUpInside)
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .transitionCurlDown, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (_) in
            
        }
    }
    
    @objc func unbuttonAction(sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .transitionCurlDown, animations: {
            self.transform = .identity
        })
    }

    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
