//
//  CustomMarker.swift
//  GMapsPractice
//
//  Created by يعرب المصطفى on 4/19/18.
//  Copyright © 2018 yarob. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class CustomMarker: GMSCircle {
    static var count = 0
    var markerIndex:Int!
    var type = 0
    var volunteers: [Volunteer] = []
    
    override init()
    {
        super.init()
        self.markerIndex = CustomMarker.count
        CustomMarker.count+=1
    }
}
