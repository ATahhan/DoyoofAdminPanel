//
//  Bus.swift
//  GMapsPractice
//
//  Created by يعرب المصطفى on 4/19/18.
//  Copyright © 2018 yarob. All rights reserved.
//

import Foundation
import UIKit

class Bus:Location
{
    var driverName:String?
    var busStatus:String?
    
    init(lat:Double?,long:Double?,type:Int?,profilePic:UIImage?,driverName:String,busStatus:String)
    {
        self.driverName = driverName
        self.busStatus = busStatus
        super.init(lat: lat, long: long, profilePic: profilePic)
    }
}
