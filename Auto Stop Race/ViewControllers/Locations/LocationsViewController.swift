//
//  LocationsViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 18.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import GoogleMaps

class LocationsViewController: UIViewControllerWithMenu{
    var viewModel: LocationsViewModel!

    let locationsSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = UIColor.blueMenu
        return searchBar
    }()
    
    var mapView: GMSMapView!
    
    convenience init(viewModel: LocationsViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGMSServices()
        setupNavigationBarTitle()
        setupSearchBar()
        setupKeyboard()
        setupConstraints()
    }
    
    func setupGMSServices() {
        var keys: NSDictionary?
        
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        if let dict = keys {
            let GMSServicesAPIKey = dict["GMSServicesAPIKey"] as? String
            GMSServices.provideAPIKey(GMSServicesAPIKey!)
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(GMSConfig.initialLatitude), longitude: CLLocationDegrees(GMSConfig.initialLongitude), zoom: Float(GMSConfig.initialZoom))
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view.addSubview(mapView)
    }

    
    func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("title_teams", comment: "")
    }
    
    func setupSearchBar() {
        let textfield:UITextField = locationsSearchBar.value(forKey:"searchField") as! UITextField
        
        let attributedString = NSAttributedString(string: NSLocalizedString("hint_enter_team_number", comment: ""), attributes: [NSForegroundColorAttributeName : UIColor.lightGray])
        
        textfield.attributedPlaceholder = attributedString
        
        view.addSubview(locationsSearchBar)
    }
    
    func setupKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        
        if let window = UIApplication.shared.keyWindow {
            window.addGestureRecognizer(tap)
        }
    }
    
    
    func setupConstraints() {
        locationsSearchBar.snp.makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(view)
            make.height.equalTo(self.navigationController!.navigationBar.frame.height)
        }
        
        mapView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(locationsSearchBar.snp.bottom)
            make.left.bottom.right.equalTo(view)
        }
    }
    func dismissKeyboard() {
        locationsSearchBar.resignFirstResponder()
    }

}
