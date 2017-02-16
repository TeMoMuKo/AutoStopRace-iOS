//
//  DashboardViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    let menuViewController = MenuViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupNavigationBarButtons()
        
        view.backgroundColor = UIColor.white
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        navigationItem.titleView = titleLabel
        titleLabel.text = NSLocalizedString("app_name", comment: "")
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
    }
    
    func setupNavigationBarButtons() {
        let menuImage = UIImage(named: "menu_icon")?.withRenderingMode(.alwaysOriginal)
        let menuBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.leftBarButtonItems = [menuBarButtonItem]
    }
    
    func handleMenu() {
        menuViewController.showMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
