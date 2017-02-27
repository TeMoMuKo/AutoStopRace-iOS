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

class LocationsViewController: UIViewControllerWithMenu{
    var viewModel: LocationsViewModel!

    let locationsSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = UIColor.blueMenu
        return searchBar
    }()
    
    convenience init(viewModel: LocationsViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(locationsSearchBar)

        setupNavigationBarTitle()
        setupConstraints()
        setupSearchBar()
        setupKeyboard()
    }
    
    func setupConstraints() {
        locationsSearchBar.snp.makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(view)
            make.height.equalTo(self.navigationController!.navigationBar.frame.height)
        }
    }
    
    func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("title_teams", comment: "")
    }
    
    func setupSearchBar() {
        let textfield:UITextField = locationsSearchBar.value(forKey:"searchField") as! UITextField
        
        let attributedString = NSAttributedString(string: NSLocalizedString("hint_enter_team_number", comment: ""), attributes: [NSForegroundColorAttributeName : UIColor.lightGray])
        
        textfield.attributedPlaceholder = attributedString
    }
    
    func setupKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        
        if let window = UIApplication.shared.keyWindow {
            window.addGestureRecognizer(tap)
        }
    }
    
    func dismissKeyboard() {
        locationsSearchBar.resignFirstResponder()
    }
}
