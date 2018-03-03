//
//  NewUserLocation.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 24.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation
import GoogleMaps
import Eureka

protocol PostNewLocationViewControllerDelegate: class {
    func backToLocationsScreen()
}

class PostNewLocationViewController: FormViewControllerWithBackButton, CLLocationManagerDelegate {
    var viewModel: PostNewLocationViewModel!
    
    var locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    
    var isFormValid = false
    
    var latitude: Double?
    var longitude: Double?
    var message: String?
    var image: String?
    
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
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] as CLLocation
        latitude = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        let coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
    
        geocoder.reverseGeocodeLocation(userLocation, completionHandler: { placemarks, _ in
            if let addressDict = placemarks?[0].addressDictionary {
                if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
                    self.form.rowBy(tag: "location_row")?.title = formattedAddress.joined(separator: ", ")
                    self.form.rowBy(tag: "location_row")?.reload()
                    self.form.sectionBy(tag: "location_section")?.footer?.title = "\(coordinate.dms.latitude), \(coordinate.dms.longitude)"
                    self.form.sectionBy(tag: "location_section")?.reload()
                    self.form.rowBy(tag: "add_location_button_row")?.disabled = false
                    self.form.rowBy(tag: "add_location_button_row")?.updateCell()

                }
            } else {
                self.form.rowBy(tag: "location_row")?.title = "\(coordinate.dms.latitude), \(coordinate.dms.longitude)"
                self.form.rowBy(tag: "location_row")?.reload()
            }
            
            let sendSection: Section? = self.form.sectionBy(tag: "send_location_section")
            sendSection?.hidden = false
            sendSection?.evaluateHidden()
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
                <<< LabelRow("location_row") {
                    $0.title = NSLocalizedString("msg_establishing_approximate_location", comment: "")
                }
            
            +++ Section(NSLocalizedString("hint_message", comment: ""))
                <<< TextAreaRow("message_row") {
                    $0.textAreaHeight = .dynamic(initialTextViewHeight: 110)
                    $0.add(rule: RuleMaxLength(maxLength: 160))
                    $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { _, row in
                    if !row.isValid {
                        let message = row.value! as NSString
                        row.value = message.substring(with: NSRange(location: 0, length: 159))
                    }
                }

            +++ Section()
                <<< ImageRow("image_row") {
                    $0.title = NSLocalizedString("add_photo_title", comment: "")
                }
            
            +++ Section({
                $0.hidden = true
                $0.tag = "send_location_section"
            })
                <<< ButtonRow("add_location_button_row") {
                        $0.title = NSLocalizedString("add_location_button_title", comment: "")
                    }
                    .onCellSelection { [weak self] _, row in
                        row.hidden = true
                        row.evaluateHidden()
                        self?.postNewLocation()
                    }
    }
    
    func postNewLocation() {
        let newLocation = CreateLocationRecordRequest()
        newLocation.latitude = latitude!
        newLocation.longitude = longitude!
        
        let messageRow: TextAreaRow? = form.rowBy(tag: "message_row")
        
        if messageRow?.value != "" {
            newLocation.message = messageRow?.value ?? ""
        }
        
        let imageRow: ImageRow? = form.rowBy(tag: "image_row")
        if let image = imageRow?.value {
            let imageData: Data = UIImageJPEGRepresentation(image.normalizedImage(), 0.25)!
            let base64Image = imageData.base64EncodedString()
            let imageEncoded = "data:image/jpeg;base64,\(base64Image)"
            newLocation.image = imageEncoded
        }
        
        viewModel.saveNewLocationToDatabase(newLocation: newLocation)
    }
}
