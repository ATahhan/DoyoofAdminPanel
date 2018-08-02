//
//  Station.swift
//  GMapsPractice
//
//  Created by يعرب المصطفى on 4/22/18.
//  Copyright © 2018 yarob. All rights reserved.
//

import Foundation
import UIKit

class Station:Location
{
    var name:String?
    var busesNumber:Int?
    var length:String?
    
    init(lat:Double?,long:Double?,type:Int?,profilePic:UIImage?,stationName:String,busesNum:Int?, length:String?)
    {
        self.name = stationName
        self.busesNumber = busesNum
        self.length = length
        super.init(lat: lat, long: long, profilePic: profilePic)
    }
}
