//
//  DashboardViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

protocol DashboardViewControllerDelegate: class {
    func menuSelected()
}

class DashboardViewController: UIViewControllerWithMenu {
    var loginButton: UIButton!
    var backgroundView: UIView!
    var backgroundImageLogo: UIView!
    
    var viewModel: DashboardViewModel!
    
    convenience init(viewModel: DashboardViewModel) {
        self.init()
        
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle()

        setupBackgroundImage()
        setupButtons()
        view.backgroundColor = UIColor.white
        setupConstraints()
    }
    
    func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("app_name", comment: "")
    }
    
    func setupBackgroundImage() {
        let backgroundImage = UIImageView.init(image: UIImage(named: "bg"))
        backgroundImage.contentMode = .scaleAspectFill

        backgroundImage.frame = view.frame
        
        backgroundView = UIView(frame: CGRect.init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 174 ))
        view.addSubview(backgroundView)
        
        backgroundImageLogo = UIImageView.init(image: UIImage(named: "logo_asr")?.scaled(toWidth: view.bounds.width))
        backgroundImageLogo.contentMode = .scaleAspectFit
        
        view.addSubview(backgroundImage)
        view.addSubview(backgroundImageLogo)
    }
    
    func setupButtons() {
        loginButton = UIButton()
        loginButton.layer.cornerRadius = 5
        loginButton.setTitle(NSLocalizedString("dashboard_login_button", comment: ""), for: .normal)
        loginButton.backgroundColor = UIColor.blueMenu
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.titleLabel!.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightUltraLight)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        let contactButton = UIButton()
        contactButton.layer.cornerRadius = 5
        contactButton.setTitle(NSLocalizedString("dashboard_contact_button", comment: ""), for: .normal)
        contactButton.setTitleColor(UIColor.blueMenu, for: .normal)
        contactButton.titleLabel!.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightUltraLight)
        contactButton.backgroundColor = UIColor.white
        contactButton.addTarget(self, action: #selector(contactButtonTapped), for: .touchUpInside)
        
        view.addSubview(loginButton)
        view.addSubview(contactButton)
        
        view.addConstraintsWithFormat(format: "H:|-32-[v0]-32-|", views: loginButton)
        view.addConstraintsWithFormat(format: "H:|-32-[v0]-32-|", views: contactButton)

        view.addConstraintsWithFormat(format: "V:[v0(64)]-16-[v1(64)]-32-|", views: loginButton, contactButton)
    }
    
    func setupConstraints() {
        backgroundView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view)
            make.bottom.equalTo(loginButton.snp.top)
        }
        
        backgroundImageLogo.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(backgroundView.center)
        }
    }
    
    func loginButtonTapped() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let appCoordinator = appDelegate.coordinator as! AppCoordinator
        appCoordinator.loginButtonTapped()
    }
    
    func contactButtonTapped() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let appCoordinator = appDelegate.coordinator as! AppCoordinator
        appCoordinator.contactButtonTapped()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
