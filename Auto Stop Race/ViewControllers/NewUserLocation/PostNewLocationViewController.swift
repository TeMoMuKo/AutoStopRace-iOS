//
//  NewUserLocation.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 24.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import MapKit
import CoreLocation
import GoogleMaps
import Eureka

protocol PostNewLocationViewControllerDelegate: class {
    
}

class PostNewLocationViewController: FormViewControllerWithBackButton, CLLocationManagerDelegate {
    var viewModel: PostNewLocationViewModel!
    
    var locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    
    var isFormValid = false
    
    convenience init(viewModel: PostNewLocationViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarTitle()
        isAuthorizedtoGetUserLocation()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        setUpForms()
    }
    
    func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("title_post_location", comment: "")
    }
    
    func isAuthorizedtoGetUserLocation() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation

        let coordinations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
    
        geocoder.reverseGeocodeLocation(userLocation, completionHandler: { placemarks, error in
            if let addressDict = placemarks?[0].addressDictionary {
                if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
                    self.form.rowBy(tag: "location_row")?.title = formattedAddress.joined(separator: ", ")
                    self.form.rowBy(tag: "location_row")?.reload()
                    self.form.sectionBy(tag: "location_section")?.footer?.title = "\(coordinations.dms.latitude), \(coordinations.dms.longitude)"
                    self.form.sectionBy(tag: "location_section")?.reload()
                    self.form.rowBy(tag: "add_location_button_row")?.disabled = false
                    self.form.rowBy(tag: "add_location_button_row")?.updateCell()

                }
            } else {
                self.form.rowBy(tag: "location_row")?.title = "\(coordinations.dms.latitude), \(coordinations.dms.longitude)"
                self.form.rowBy(tag: "location_row")?.reload()
            }
        })

        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.form.rowBy(tag: "location_row")?.title = NSLocalizedString("location_fail", comment: "")
        self.form.rowBy(tag: "location_row")?.reload()
    }

    func setUpForms() {
        
        ImageRow.defaultCellUpdate = { cell, row in
            cell.accessoryView?.layer.cornerRadius = 17
            cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        }
        
        form +++
            Section(header: NSLocalizedString("msg_your_location", comment: ""), footer: "") {
                $0.tag = "location_section"
            }
                <<< LabelRow("location_row"){
                    $0.title = NSLocalizedString("msg_establishing_approximate_location", comment: "")
                }
            
            +++ Section(NSLocalizedString("hint_message", comment: ""))
                <<< TextAreaRow() {
                    $0.textAreaHeight = .dynamic(initialTextViewHeight: 110)
                    $0.add(rule: RuleMaxLength(maxLength: 160))
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = .red
                    }
                }

            +++ Section()
                <<< ImageRow(){
                    $0.title = NSLocalizedString("add_photo_title", comment: "")
                }
            
            +++ Section()
                <<< ButtonRow("add_location_button_row") {
                        $0.title = NSLocalizedString("add_location_button_title", comment: "")
                    }
                    .onCellSelection { [weak self] (cell, row) in
                        self?.showAlert()
                    }
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "OnCellSelection", message: "Button Row Action", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true)
        
    }
}
