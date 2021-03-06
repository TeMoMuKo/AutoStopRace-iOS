//
//  AboutViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 19.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import SnapKit

class AboutViewController: UIViewControllerWithMenu {
    
    var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("app_name", comment: "")
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        return label
    }()
    
    var appVersionLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("app_version", comment: "")
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)
        return label
    }()
    
    var authorInfoLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("about_app", comment: "")
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)
        return label
    }()
    
    var rateAppTitleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("msg_rate_app_question", comment: "")
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)
        return label
    }()

    var rateAppSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("msg_rate_app", comment: "")
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.light)
        return label
    }()
    
    var rateAppButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("action_rate", comment: ""), for: .normal)
        button.theme.blueWhiteUltraLight()
        button.addTarget(self, action: #selector(rateAppButtonTapped), for: .touchUpInside)
        return button
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupNavigationBarTitle()
        setupShareBarButton()
        setupStackView()
        setupConstraints()
    }

    private func setupBackground() {
        view.backgroundColor = .white
    }
    
    func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("title_about", comment: "")
    }
    
    func setupStackView() {
        stackView.addArrangedSubview(appNameLabel)
        stackView.addArrangedSubview(appVersionLabel)
        stackView.addArrangedSubview(authorInfoLabel)
        stackView.addArrangedSubview(rateAppTitleLabel)
        stackView.addArrangedSubview(rateAppSubtitleLabel)
        stackView.addArrangedSubview(rateAppButton)
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        view.layoutIfNeeded()
    }

    func setupShareBarButton() {
        let menuImage = UIImage(named: "ic_share_white")?.withRenderingMode(.alwaysOriginal)
        let menuBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleShareTap))
        navigationItem.rightBarButtonItems = [menuBarButtonItem]
    }

    @objc func handleShareTap() {
        guard let name = NSURL(string: AboutConfig.appStoreShareUrl) else { return }
        let objectsToShare = [name]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        authorInfoLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(stackView)
            make.right.equalTo(stackView)
            make.height.equalTo(150)
        }
        
        stackView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(scrollView).offset(32)
            make.left.equalTo(scrollView).offset(32)
            make.right.equalTo(scrollView).offset(-32)
            make.bottom.equalTo(scrollView).offset(-32)
            make.width.equalTo(scrollView).offset(-64)
        }
        
        rateAppButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(64)
            make.left.equalTo(stackView)
            make.right.equalTo(stackView)
        }
    }
    
    @objc func rateAppButtonTapped() {
        if let url = URL(string: AboutConfig.appStoreRateUrl),
            UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
        } else {
            showAlert(title: NSLocalizedString("app_store_error_title", comment: ""), message: "")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
    }
}
