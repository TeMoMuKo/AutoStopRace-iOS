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
        button.layer.cornerRadius = 5
        button.setTitle(NSLocalizedString("dashboard_login_button", comment: ""), for: .normal)
        button.backgroundColor = Theme.Color.blueMenu
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.ultraLight)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let contactButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.setTitle(NSLocalizedString("dashboard_contact_button", comment: ""), for: .normal)
        button.setTitleColor(Theme.Color.blueMenu, for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.ultraLight)
        button.backgroundColor = UIColor.white
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
        
        backgroundImageLogo = UIImageView.init(image: UIImage(named: "logo_asr_fazana"))
        backgroundImageLogo.contentMode = .scaleAspectFit
        
        view.addSubview(backgroundImage)
        view.addSubview(backgroundImageLogo)
    }
    
    func setupButtons() {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
