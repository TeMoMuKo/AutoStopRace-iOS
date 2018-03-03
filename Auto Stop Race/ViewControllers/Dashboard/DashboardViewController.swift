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
    func loginButtonTapped()
    func contactButtonTapped()
}

class DashboardViewController: UIViewControllerWithMenu {
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("dashboard_login_button", comment: ""), for: .normal)
        button.theme.blueWhiteUltraLight()
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let contactButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("dashboard_contact_button", comment: ""), for: .normal)
        button.theme.whiteBlueUltraLight()
        button.addTarget(self, action: #selector(contactButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var backgroundView: UIView!
    var backgroundImageLogo: UIView!
    
    var viewModel: DashboardViewModel!
    
    convenience init(viewModel: DashboardViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        setupNavigationBarTitle()
        setupBackgroundImage()
        setupButtons()
        setupConstraints()
    }
    
    private func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("app_name", comment: "")
    }
    
    private func setupBackgroundImage() {
        let backgroundImage = UIImageView(image: UIImage(named: "bg"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.frame = view.frame
        
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 174 ))
        view.addSubview(backgroundView)
        
        backgroundImageLogo = UIImageView(image: UIImage(named: "logo_asr_fazana"))
        backgroundImageLogo.contentMode = .scaleAspectFit
        
        view.addSubview(backgroundImage)
        view.addSubview(backgroundImageLogo)
    }
    
    private func setupButtons() {
        view.addSubview(loginButton)
        view.addSubview(contactButton)
        
        view.addConstraintsWithFormat(format: "H:|-32-[v0]-32-|", views: loginButton)
        view.addConstraintsWithFormat(format: "H:|-32-[v0]-32-|", views: contactButton)
        view.addConstraintsWithFormat(format: "V:[v0(64)]-16-[v1(64)]-32-|", views: loginButton, contactButton)
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view)
            make.bottom.equalTo(loginButton.snp.top)
        }
        
        backgroundImageLogo.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(backgroundView.center)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
        }
    }
    
    @objc func loginButtonTapped() {
        viewModel.loginButtonTapped()
    }
    
    @objc func contactButtonTapped() {
        viewModel.contactButtonTapped()
    }
}
