//
//  AboutViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 19.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: UIViewControllerWithMenu {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarTitle()
    }
    
    func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("title_about", comment: "")
    }
}
