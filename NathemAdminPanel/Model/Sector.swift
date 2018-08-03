//
//  Sector.swift
//  NathemAdminPanel
//
//  Created by Ammar AlTahhan on 02/08/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import Foundation

struct Sector {
    var id: String
    var name: String
    var lat: Double
    var long: Double
    var radius: Double
    var volunteers: [Volunteer]
}
