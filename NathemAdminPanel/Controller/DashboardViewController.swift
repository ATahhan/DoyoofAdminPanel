//
//  ViewController.swift
//  NathemAdminPanel
//
//  Created by Ammar AlTahhan on 01/08/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import UIKit
import Charts
import GoogleMaps
import GooglePlaces
import Spruce

class DashboardViewController: DemoBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var map: GMSMapView!
    @IBOutlet weak var chartView: PieChartView!
    @IBOutlet weak var volunteersCountLabel: UILabel!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var medicsLabel: UILabel!
    @IBOutlet weak var giudanceLabel: UILabel!
    @IBOutlet weak var translationLabel: UILabel!
    
    let sideMenu: [String] = ["Main", "Secondary", "Profile", "About"]
    var locations: [Location] = []
    var volunteers: [Volunteer] = [] {
        didSet {
            chartDataset = [availableVol, busyVol, unavailableVol]
            volunteersCountLabel.text = String(volunteers.count)
            updateChartData()
        }
    }
    var availableVol: [Volunteer] {
        let tt = volunteers.filter({$0.status == "available"})
        return tt
    }
    var busyVol: [Volunteer] {
        return volunteers.filter({$0.status == "busy"})
    }
    var unavailableVol: [Volunteer] {
        return volunteers.filter({$0.status == "unavailable"})
    }
    private var chartDataset: [[Volunteer]]!
    var animations: [StockAnimation] = [.slide(.up, .moderately), .fadeIn]
    var sortFunction = LinearSortFunction(direction: .topToBottom, interObjectDelay: 0.3)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        map.delegate = self
        UIApplication.shared.isStatusBarHidden = true
        fillLocations()
        loadMap()
        chartDataset = [availableVol, busyVol, unavailableVol]
        
        self.title = "Pie Chart"
        
        self.options = [.toggleValues,
                        .toggleXValues,
                        .togglePercent,
                        .toggleHole,
                        .toggleIcons,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .spin,
                        .drawCenter,
                        .saveToGallery,
                        .toggleData]
        
        self.setup(pieChartView: chartView)
        
        chartView.delegate = self
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.xEntrySpace = 32
        l.yEntrySpace = 6
        l.yOffset = chartView.frame.size.height / 2 - 42
        l.xOffset = 32
        l.font = .systemFont(ofSize: 14, weight: .light)
        //        chartView.legend = l
        
        // entry label styling
        chartView.entryLabelColor = .black
        chartView.entryLabelFont = .systemFont(ofSize: 12, weight: .light)
        
        chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
        
        self.optionTapped(.spin)
        self.updateChartData()
        
        refreshVolunteers()
        setupSpruce()
    }
    
    func refreshVolunteers() {
        API.getVolunteers { (result, err) in
            guard err == nil else { return }
            self.volunteers = result!
        }
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
        startSpruce()
    }
    
    func fillLocations() {
        //21.354652, 39.982782
        locations.append(Location(lat: 21.354652, long: 39.982282, profilePic: #imageLiteral(resourceName: "red_circle")))
        locations.append(Location(lat: 21.352612, long: 39.972282, profilePic: #imageLiteral(resourceName: "red_circle")))
        locations.append(Location(lat: 21.351652, long: 39.989382, profilePic: #imageLiteral(resourceName: "red_circle").resized(to: CGSize(width: 100, height: 100))))
        locations.append(Location(lat: 21.358552, long: 39.990282, profilePic: #imageLiteral(resourceName: "red_circle").resized(to: CGSize(width: 80, height: 80))))
    }
    
    func loadMap() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 21.354652, longitude: 39.982282, zoom: 13.2)
        map.camera = camera
        
        // Creates a marker in the center of the map.
        for location in locations {
            createMarker(fromLocation:location)
        }
    }
    
    func setupSpruce() {
        firstStackView.spruce.prepare(with: animations)
    }
    
    func startSpruce() {
        firstStackView.spruce.animate(animations, animationType: SpringAnimation(duration: 1.4), sortFunction: sortFunction)
    }
    
    func createMarker(fromLocation location:Location) {
        let marker = CustomMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.latitude!, longitude: location.longitude!)
        marker.icon = location.profilePic?.withAlphaComponent(0.2)
        marker.map = map
    }
    
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
        self.setDataCount(3, range: 100)
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
            let value = Double(chartDataset[i % chartDataset.count].count)
            return PieChartDataEntry(value: value,
                                     label: parties[i % parties.count],
                                     icon: #imageLiteral(resourceName: "red_circle"))
        }
        
        let set = PieChartDataSet(values: entries, label: "")
        set.drawIconsEnabled = false
        set.sliceSpace = 2
        
        
        set.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.white)
        
        chartView.data = data
        chartView.highlightValues(nil)
    }
    override func optionTapped(_ option: Option) {
        switch option {
        case .toggleXValues:
            chartView.drawEntryLabelsEnabled = !chartView.drawEntryLabelsEnabled
            chartView.setNeedsDisplay()
            
        case .togglePercent:
            chartView.usePercentValuesEnabled = !chartView.usePercentValuesEnabled
            chartView.setNeedsDisplay()
            
        case .toggleHole:
            chartView.drawHoleEnabled = !chartView.drawHoleEnabled
            chartView.setNeedsDisplay()
            
        case .drawCenter:
            chartView.drawCenterTextEnabled = !chartView.drawCenterTextEnabled
            chartView.setNeedsDisplay()
            
        case .animateX:
            chartView.animate(xAxisDuration: 1.4)
            
        case .animateY:
            chartView.animate(yAxisDuration: 1.4)
            
        case .animateXY:
            chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4)
            
        case .spin:
            chartView.spin(duration: 2,
                           fromAngle: chartView.rotationAngle,
                           toAngle: chartView.rotationAngle + 360,
                           easingOption: .easeInCubic)
            
        default:
            handleOption(option, forChartView: chartView)
        }
    }
    
    func updateSectorInfo(_ volunteers: [Volunteer]) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profilePopover" {
            if let iconView = (sender as? GMSMarker)?.iconView {
                segue.destination.popoverPresentationController?.sourceRect = iconView.bounds
            }
        }
    }

}


extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell") as! SideMenuTableViewCell
        
        cell.title.text = sideMenu[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}


extension DashboardViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        updateSectorInfo((marker as! CustomMarker).volunteers)
        
        return true
    }
}

