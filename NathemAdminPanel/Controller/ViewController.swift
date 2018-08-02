//
//  ViewController.swift
//  GMapsPractice
//
//  Created by يعرب المصطفى on 4/15/18.
//  Copyright © 2018 yarob. All rights reserved.
//

//AIzaSyAJDoDaV8hGsLbxDj8bfDJ-nlNw79rrlzY

import UIKit
import GoogleMaps
import GooglePlaces


class ViewController: UIViewController
{

    
    @IBOutlet weak var map: GMSMapView!
    
    var nearestStation:Location!
    
    var locations = [Location]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        map.delegate = self
        setLocations()
        loadMap()
        

    }
    @IBAction func homeBtnPressed(_ sender: Any) {
        goToLoginPage()
    }
    
    private func goToLoginPage()
    {
        
        //self.present(newViewController, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
     
     هو اللات
     * باص أصفر
     26.314914, 50.146641
     26.314474, 50.145363
     26.313376, 50.144650
     26.311594, 50.145320
     26.308605, 50.145554
     
     26.313170, 50.140498
     26.313612, 50.142071
     26.314125, 50.144237
     26.310474, 50.145332
     26.306383, 50.147693
     
         المول : 26.314890, 50.146640
         بداية الباص الأزرق : 26.313194, 50.140496
         المطعم : 26.309853, 50.143933
         مبنى 59 : 26.308735, 50.145323
         مبنى 24 : 26.306190, 50.147883
     */
    
    private var busImage = "bus-icon"
    private func setLocations()
    {
        //yellow buses:
        locations.append(Bus(lat: 26.311425, long: 50.148478, type: 0, profilePic: UIImage(named: busImage), driverName: "Ahmad", busStatus: "متوقف"))
        
        locations.append(Bus(lat: 26.314914, long: 50.146641, type: 0, profilePic: UIImage(named: busImage), driverName: "Omar", busStatus: "متوقف"))
        
        locations.append(Bus(lat: 26.314474, long: 50.145363, type: 0, profilePic: UIImage(named: busImage), driverName: "Abdulla", busStatus: "متوقف"))
        
        locations.append(Bus(lat: 26.313376, long: 50.144650, type: 0, profilePic: UIImage(named: busImage), driverName: "Salem", busStatus: "متوقف"))
        
        locations.append(Bus(lat: 26.311594, long: 50.145320, type: 0, profilePic: UIImage(named: busImage), driverName: "Sultan", busStatus: "متوقف"))
        
        locations.append(Bus(lat: 26.308605, long: 50.145554, type: 0, profilePic: UIImage(named: busImage), driverName: "Khaled", busStatus: "متوقف"))
        
        //blue buses
        
        
        locations.append(Bus(lat: 26.313002, long: 50.149680, type: 1, profilePic: UIImage(named: busImage), driverName: "خالد سالم", busStatus: "متوقف"))
        
        locations.append(Bus(lat: 26.313170, long: 50.140498, type: 1, profilePic: UIImage(named: busImage), driverName: "خالد سالم", busStatus: "متوقف"))
        
        locations.append(Bus(lat: 26.313612, long: 50.142071, type: 1, profilePic: UIImage(named: busImage), driverName: "خالد سالم", busStatus: "متوقف"))
        
        locations.append(Bus(lat: 26.314125, long: 50.144237, type: 1, profilePic: UIImage(named: busImage), driverName: "خالد سالم", busStatus: "متوقف"))
        
        locations.append(Bus(lat: 26.310474, long: 50.145332, type: 1, profilePic: UIImage(named: busImage), driverName: "خالد سالم", busStatus: "متوقف"))
        
        locations.append(Bus(lat: 26.306383, long: 50.147693, type: 1, profilePic: UIImage(named: busImage), driverName: "خالد سالم", busStatus: "متوقف"))
        
        
        //stations
        
        /*26.313170, 50.140498
         26.313612, 50.142071
         26.314125, 50.144237
         26.310474, 50.145332
         26.306383, 50.147693
         
          : 26.314890, 50.146640
          : 26.313194, 50.140496
          : 26.309853, 50.143933
          : 26.308735, 50.145323
        24 : 26.306190, 50.147883
         */
        nearestStation = Station(lat: 26.3148894, long: 50.1473080, type: 3, profilePic: UIImage(named: "bus-stop"), stationName: "محطة المول", busesNum: 2, length:"112m")
        locations.append(nearestStation)
        
        
        locations.append(Station(lat: 26.314890, long: 50.146640, type: 3, profilePic: UIImage(named: "bus-stop"), stationName: "محطة المول", busesNum: 2, length:"112m"))
        
        locations.append(Station(lat: 26.313194, long: 50.140496, type: 3, profilePic: UIImage(named: "bus-stop"), stationName: "محطة المول", busesNum: 2, length:"112m"))
        
        locations.append(Station(lat: 26.309853, long: 50.143933, type: 3, profilePic: UIImage(named: "bus-stop"), stationName: "محطة المطعم", busesNum: 2, length:"112m"))
        
        locations.append(Station(lat: 26.308735, long: 50.145323, type: 3, profilePic: UIImage(named: "bus-stop"), stationName: "محطة مبنى ٥٩", busesNum: 2, length:"112m"))
        
        locations.append(Station(lat: 26.306190, long: 50.147883, type: 3, profilePic: UIImage(named: "bus-stop"), stationName: "محطة مبنى ٢٤", busesNum: 2, length:"112m"))
    }
    
    func loadMap()
    {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 26.313002, longitude: 50.149680, zoom: 15.0)
        //let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        map.camera = camera
        
        // Creates a marker in the center of the map.
        for location in locations
        {
            createMarker(fromLocation:location)
        }
        
    }
    
    func createMarker(fromLocation location:Location)
    {
//        let marker = CustomMarker()
//        marker.position = CLLocationCoordinate2D(latitude: location.latitude!, longitude: location.longitude!)
//
////        var color = Colors.yellow
//        if(location.type == 0)
//        {
//            marker.icon = UIImage(named: "bus-location-sm1")
//        }else if location.type == 1
//        {
//            color = Colors.blue
//            marker.icon = UIImage(named: "bus-location-sm2")
//
//        }else //it's a station
//        {
//            marker.icon = UIImage(named: "station-location-sm")
//        }
//        //marker.icon = UIImage(named:"locationIcon")
//        marker.map = map
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func nearestStationClicked(_ sender: Any)
    {
//        let camera = GMSCameraPosition.camera(withLatitude: nearestStation.latitude!, longitude: nearestStation.longitude!, zoom: 17.0)
//        map.animate(to: camera)
    }
    
    
    //reusable: dpendencies: PopupDialog library
    func showMessage(title: String, message: String) {
//        let title = title
//        let message = message
//        let image = UIImage(named: "pexels-photo-103290")
        
        // Add buttons to dialog
        // Alternatively, you can use popup.addButton(buttonOne)
        // to add a single button
    }
    
    @IBAction func askForBusClicked(_ sender: UIButton)
    {
        showMessage(title: "تم", message: "تم طلب باص لأقرب محطة لك")
    }
}


extension ViewController:GMSMapViewDelegate
{
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool
    {
//        if let marker = marker as? CustomMarker
//        {
//            var index = marker.markerIndex % locations.count
//            var location = locations[index]
//            self.detailsView.setView(location: location)
//
//        }
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
    }
    
    
}

//extension ViewController: CLLocationManagerDelegate
//{
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
//    {
//        let location = locations.last!
//        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
//    }
//}

