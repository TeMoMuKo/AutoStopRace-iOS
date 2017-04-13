//
//  UIViewControllerWithMenu.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 19.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit

class UIViewControllerWithMenu: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
 
        setupViews()
    }
    
    func setupViews() {
        setupNavigationBar()
        setupNavigationMenuButton()
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""

        let titleLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: self.navigationController!.view.frame.height))
        titleLabel.clipsToBounds = true
        navigationItem.titleView = titleLabel
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
    }
    
    func setupNavigationMenuButton() {
        let menuImage = UIImage(named: "menu_icon")?.withRenderingMode(.alwaysOriginal)
        let menuBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.leftBarButtonItems = [menuBarButtonItem]
        
    }

    func handleMenu() {
        let nc = NotificationCenter.default
        nc.post(name:Notification.Name(rawValue: "showMenu"),
                object: nil,
                userInfo:nil)
    }
}