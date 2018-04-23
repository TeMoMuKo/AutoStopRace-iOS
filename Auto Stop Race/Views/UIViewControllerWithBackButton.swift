//
//  UIViewControllerWithBackButton.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 20.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit

class UIViewControllerWithBackButton: UIViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews() {
        setupNavigationBar()
        setupNavigationMenuButton()
    }
    
    func setupNavigationBar() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: navigationController!.view.frame.height))
        titleLabel.clipsToBounds = true
        navigationItem.titleView = titleLabel
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
    }
    
    func setupNavigationMenuButton() {
        let menuImage = UIImage(named: "ic_keyboard_backspace_white")?.withRenderingMode(.alwaysOriginal)
        let menuBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(popBack))
        navigationItem.leftBarButtonItem = menuBarButtonItem

        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    @objc func popBack() {
        _ = navigationController?.popViewController(animated: false)
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

