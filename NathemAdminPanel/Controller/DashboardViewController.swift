//
//  ViewController.swift
//  NathemAdminPanel
//
//  Created by Ammar AlTahhan on 01/08/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import UIKit
import Charts
import CoreLocation
import GoogleMaps
import GooglePlaces
import Spruce
import UICountingLabel

enum Places {
    case Muna
    case Arafat
    case Muzdalifah
}

class DashboardViewController: DemoBaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var map: GMSMapView!
    @IBOutlet weak var chartView: PieChartView!
    @IBOutlet weak var volunteersCountLabel: UILabel!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var medicsLabel: UICountingLabel!
    @IBOutlet weak var giudanceLabel: UICountingLabel!
    @IBOutlet weak var translationLabel: UICountingLabel!
    @IBOutlet var backViews: [UIView]!
    @IBOutlet weak var menuButton: UIButton!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    let sideMenu: [String] = ["Dashboard", "List", "Additional Services", "Settings"]
    let icons: [UIImage] = [#imageLiteral(resourceName: "chart"), #imageLiteral(resourceName: "list"), #imageLiteral(resourceName: "menu"), #imageLiteral(resourceName: "settings")]
    let coordinates: [Places: CLLocationCoordinate2D] = [
        .Arafat: CLLocationCoordinate2D(latitude: 21.354605, longitude: 39.982829),
        .Muna: CLLocationCoordinate2D(latitude: 21.413168, longitude: 39.893857),
        .Muzdalifah: CLLocationCoordinate2D(latitude: 21.391781, longitude: 39.912127)
    ]
    var sectors: [Sector] = [] {
        didSet {
            volunteers = sectors.map({$0.volunteers}).reduce([], +)
            updateMap()
        }
    }
    var volunteers: [Volunteer] = [] {
        didSet {
            chartDataset = [availableVol, busyVol, unavailableVol]
            volunteersCountLabel.text = String(volunteers.count)
            updateChartData()
            fillVolunteersMarkers()
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
        return volunteers.filter({$0.status == "notavailable"})
    }
    private var chartDataset: [[Volunteer]]!
    var animations: [StockAnimation] = [.slide(.up, .severely), .fadeIn]
    var sortFunction = LinearSortFunction(direction: .topToBottom, interObjectDelay: 0.3)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        map.delegate = self
        map.alpha = 0
        updateMap()
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
        
        refreshSectors()
        setupSpruce()
        
        medicsLabel.format = "%d"
        giudanceLabel.format = "%d"
        translationLabel.format = "%d"
        medicsLabel.count(from: 0, to: 0)
        giudanceLabel.count(from: 0, to: 0)
        translationLabel.count(from: 0, to: 0)
        medicsLabel.superview?.superview?.superview?.superview?.isHidden = true
        backViews.forEach({$0.isHidden = true})
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
        startSpruce()
    }
    
    func refreshSectors() {
        API.getSectors { (sectors, err) in
            guard err == nil else { return }
            self.sectors = sectors!
        }
    }
    
    func loadMap(at lat: Double = 21.354652, long: Double = 39.982282, zoom: Float = 13.2) {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: zoom)
        map.animate(to: camera)
        
    }
    
    func loadMap(_ location: CLLocationCoordinate2D, _ zoom: Float = 13.2) {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: zoom)
        map.animate(to: camera)
        
    }
    
    func updateMap() {
        map.clear()
        fillVolunteersMarkers()
        // Creates a marker in the center of the map.
        for sector in sectors {
            let marker = CustomMarker(position: CLLocationCoordinate2D(latitude: sector.lat, longitude: sector.long), radius: sector.radius)
            marker.fillColor = UIColor.red.withAlphaComponent(0.2)
            marker.strokeWidth = 0
            marker.map = map
            marker.isTappable = true
            marker.volunteers = sector.volunteers
            
        }
    }
    
    func fillVolunteersMarkers() {
        let positions: [CLLocationCoordinate2D] = [
            CLLocationCoordinate2D(latitude: 21.346616, longitude: 39.975816),
            CLLocationCoordinate2D(latitude: 21.354610, longitude: 39.982654),
            CLLocationCoordinate2D(latitude: 21.352098, longitude: 39.966100),
            CLLocationCoordinate2D(latitude: 21.372452, longitude: 39.983384),
            CLLocationCoordinate2D(latitude: 21.336953, longitude: 39.971893)
        ]
        let names: [String] = ["map", "map_red", "map_orange"]
        for i in 0..<5 {
            let marker = GMSMarker(position: positions[i%positions.count])
            let image = UIImageView(image: UIImage(named: names[i%names.count])?.resized(to: CGSize(width: 25, height: 28)))
            image.contentMode = .scaleAspectFit
            marker.iconView = image
            marker.map = map
            marker.isTappable = false
        }
    }
    
    func setupSpruce() {
        firstStackView.spruce.prepare(with: animations)
    }
    
    func startSpruce() {
        firstStackView.spruce.animate(animations, animationType: SpringAnimation(duration: 1.4), sortFunction: sortFunction) { bool in
            UIView.animate(withDuration: 0.3, animations: {
                self.map.alpha = 1
            })
        }
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
        
        set.colors = [UIColor.green, UIColor.orange, UIColor.lightGray]
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(.systemFont(ofSize: 9, weight: .light))
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
        
        medicsLabel.countFromCurrentValue(to: CGFloat(volunteers.filter({$0.category == "1"}).count), withDuration: 0.3)
        giudanceLabel.countFromCurrentValue(to: CGFloat(volunteers.filter({$0.category == "2"}).count), withDuration: 0.3)
        translationLabel.countFromCurrentValue(to: CGFloat(volunteers.filter({$0.category == "3"}).count), withDuration: 0.3)
        
        if let bool = medicsLabel.superview?.superview?.superview?.superview?.isHidden, bool {
            UIView.animate(withDuration: 0.7) {
                self.backViews.forEach({$0.isHidden = false})
                self.medicsLabel.superview?.superview?.superview?.superview?.isHidden = false
            }
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height), animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profilePopover" {
            if let iconView = (sender as? GMSMarker)?.iconView {
                segue.destination.popoverPresentationController?.sourceRect = iconView.bounds
            }
        } else if segue.identifier == "dropDownSegue", let vc = segue.destination as? DropDownTableViewController {
            vc.delegate = self
            vc.popoverPresentationController?.sourceRect = menuButton.bounds
        }
    }

}

extension DashboardViewController: DropDownDelegate {
    func tableView(didSelectRowAt indexPath: IndexPath) {
        var location: CLLocationCoordinate2D!
        var zoom: Float!
        switch indexPath.row {
        case 0:
            location = coordinates[.Arafat]
            zoom = 13.2
        case 1:
            location = coordinates[.Muna]
            zoom = 13.2
        default:
            location = coordinates[.Muzdalifah]
            zoom = 13.2
        }
        loadMap(location, zoom)
    }
}


extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell") as! SideMenuTableViewCell
        
        cell.title.text = sideMenu[indexPath.row]
        cell.icon.image = icons[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}


extension DashboardViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        updateSectorInfo((overlay as! CustomMarker).volunteers)
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height), animated: true)
    }
}

