//
//  Location.swift
//  GMapsPractice
//
//  Created by يعرب المصطفى on 4/22/18.
//  Copyright © 2018 yarob. All rights reserved.
//

import Foundation
import UIKit
class Location
{
    var latitude:Double?
    var longitude:Double?
    var profilePic:UIImage?
    
    init(lat:Double?,long:Double?,profilePic:UIImage?)
    {
        self.latitude = lat
        self.longitude = long
        self.profilePic = profilePic
    }
}
