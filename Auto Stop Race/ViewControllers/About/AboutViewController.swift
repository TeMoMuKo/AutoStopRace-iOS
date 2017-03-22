//
//  AboutViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 19.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class AboutViewController: UIViewControllerWithMenu {
    
    var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("app_name", comment: "")
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFontWeightBold)
        return label
    }()
    
    var appVersionLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("app_version", comment: "")
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightLight)
        return label
    }()
    
    var authorInfoLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("about_app", comment: "")
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightLight)
        return label
    }()
    
    
    var rateAppTitleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("msg_rate_app_question", comment: "")
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightLight)
        return label
    }()
    
    
    var rateAppSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("msg_rate_app", comment: "")
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFontWeightLight)
        return label
    }()
    
    var rateAppButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.setTitle(NSLocalizedString("action_rate", comment: ""), for: .normal)
        button.backgroundColor = UIColor.blueMenu
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightUltraLight)
        button.addTarget(self, action: #selector(rateAppButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var separator: UIView = {
        let separator = UIView(frame: CGRect.init())
        separator.backgroundColor = UIColor.gray
        return separator
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
        setupNavigationBarTitle()
        setupStackView()
        setupConstraints()
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
        setupShareBarButton()
        self.view.layoutIfNeeded()

    }
    
    
    func setupShareBarButton() {
        let menuImage = UIImage(named: "ic_share_white")?.withRenderingMode(.alwaysOriginal)
        let menuBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleShareTap))
        navigationItem.rightBarButtonItems = [menuBarButtonItem]
    }
    
    // TODO Change YOUR_APP_ID_HERE

    func handleShareTap() {
        if let name = NSURL(string: "https://itunes.apple.com/us/app/myapp/idYOUR_APP_ID_HERE?ls=1&mt=8") {
            let objectsToShare = [name]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func setupConstraints() {
        
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
    
    // TODO Change YOUR_APP_ID_HERE
    
    func rateAppButtonTapped() {
        let openAppStoreForRating = "itms-apps://itunes.apple.com/gb/app/idYOUR_APP_ID_HERE?action=write-review&mt=8"
        if UIApplication.shared.canOpenURL(URL(string: openAppStoreForRating)!) {
            UIApplication.shared.openURL(URL(string: openAppStoreForRating)!)
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
