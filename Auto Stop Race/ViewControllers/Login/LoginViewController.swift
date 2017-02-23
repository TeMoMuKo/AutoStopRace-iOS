//
//  LoginViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 19.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol LoginViewControllerDelegate: class {
    func loginButtonTapped()
    
}

class LoginViewController: UIViewControllerWithBackButton {
    
    var viewModel: LoginViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarTitle()
        setupHelpBarButton()
    }
    
    convenience init(viewModel: LoginViewModel) {
        self.init()
        
        self.viewModel = viewModel
    }
    
    func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("title_login", comment: "")
    }
    
    func setupHelpBarButton() {
        let menuImage = UIImage(named: "ic_help_outline_white")?.withRenderingMode(.alwaysOriginal)
        let menuBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleHelpTap))
        navigationItem.rightBarButtonItems = [menuBarButtonItem]
    }
    
    func handleHelpTap() {
        let alert = UIAlertController(title: NSLocalizedString("menu_help", comment: ""), message:NSLocalizedString("msg_login_info", comment: "") , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
