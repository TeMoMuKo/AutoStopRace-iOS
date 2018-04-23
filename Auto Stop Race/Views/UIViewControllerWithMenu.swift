//
//  UIViewControllerWithMenu.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 19.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit

class UIViewControllerWithMenu: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    func setupViews() {
        setupNavigationBar()
        setupNavigationMenuButton()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title = ""

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: self.navigationController!.view.frame.height))
        titleLabel.clipsToBounds = true
        navigationItem.titleView = titleLabel
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
    }
    
    func setupNavigationMenuButton() {
        let menuImage = UIImage(named: "menu_icon")?.withRenderingMode(.alwaysOriginal)
        let menuBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.leftBarButtonItems = [menuBarButtonItem]
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        let swipeBackGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleMenu))
        swipeBackGestureRecognizer.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeBackGestureRecognizer)
    }

    @objc func handleMenu() {
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name(rawValue: "showMenu"),
                object: nil,
                userInfo: nil)
    }
}
