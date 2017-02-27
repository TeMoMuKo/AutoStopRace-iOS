//
//  UIViewControllerWithBackButton.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 20.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit

class UIViewControllerWithBackButton: UIViewController, UIGestureRecognizerDelegate {
    
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
        let titleLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: self.navigationController!.view.frame.height))
        titleLabel.clipsToBounds = true
        navigationItem.titleView = titleLabel
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
    }
    
    func setupNavigationMenuButton() {
        let menuImage = UIImage(named: "ic_keyboard_backspace_white")?.withRenderingMode(.alwaysOriginal)
        let menuBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(popBack))
        navigationItem.leftBarButtonItem = menuBarButtonItem
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        let swipeBackGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(popBack))
        swipeBackGestureRecognizer.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeBackGestureRecognizer)
    }
    
    func swipeBackAction(sender: UISwipeGestureRecognizer) {
        let _ = navigationController?.popViewController(animated: false)
    }
    
    func popBack() {
        let _ = navigationController?.popViewController(animated: false)
    }
    
}
