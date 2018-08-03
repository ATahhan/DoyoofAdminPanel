//
//  API.swift
//  NathemAdminPanel
//
//  Created by Ammar AlTahhan on 02/08/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class API {
    
    class func getVolunteers(_ completion: @escaping ([Volunteer]?, Error?)->Void) {
        guard let url = URL(string: "https://hajjhackathon.herokuapp.com/api/volunteer") else { return }
        
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .failure(let err):
                completion(nil, err)
            case .success(let value):
                let json = JSON(value)
                var volus: [Volunteer] = []
                for volu in json {
                    volus.append(Volunteer(id: volu.1["idvolunteer"].stringValue, lat: volu.1["lat"].doubleValue, long: volu.1["lng"].doubleValue, status: volu.1["status"].stringValue, name: volu.1["name"].stringValue, natId: volu.1["nationalid"].stringValue, category: volu.1["category"].stringValue))
                }
                completion(volus, nil)
            }
        }
    }
    
    class func getSectors(_ completion: @escaping ([Sector]?, Error?)->Void) {
        guard let url = URL(string: "https://hajjhackathon.herokuapp.com/api/sectorsvolunteers") else { return }
        
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .failure(let err):
                completion(nil, err)
            case .success(let value):
                let json = JSON(value)
                var sectors: [Sector] = []
                for sector in json {
                    var volus: [Volunteer] = []
                    for volu in sector.1["volunteers"] {
                        volus.append(Volunteer(id: volu.1["idvolunteer"].stringValue, lat: volu.1["lat"].doubleValue, long: volu.1["lng"].doubleValue, status: volu.1["status"].stringValue, name: volu.1["name"].stringValue, natId: volu.1["nationalid"].stringValue, category: volu.1["category"].stringValue))
                    }
                    sectors.append(Sector(id: sector.1["idsector"].stringValue, name: sector.1["name"].stringValue, lat: sector.1["lat"].doubleValue, long: sector.1["lng"].doubleValue, radius: sector.1["radius"].doubleValue, volunteers: volus))
                }
                completion(sectors, nil)
            }
        }
    }
    
}
