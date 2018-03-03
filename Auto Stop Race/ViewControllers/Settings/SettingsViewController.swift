//
//  SettingsViewController.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 22.03.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import SnapKit

enum SettingsIndex: Int {
    case logout
    
    static let settingsNames = [ logout: "pref_logout" ]
    
    func settingsName() -> String {
        if let settingsName = SettingsIndex.settingsNames[self] {
            return settingsName
        } else {
            return ""
        }
    }
}

protocol SettingsViewControllerDelegate: class {
    func logoutButtonTapped()
}

class SettingsViewController: UIViewControllerWithMenu, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        
    var settingsCell: UITableViewCell = UITableViewCell()
    
    private var delegate: SettingsViewControllerDelegate?
    private let serviceProvider: ServiceProviderType

    init( delegate: SettingsViewControllerDelegate, provider: ServiceProviderType) {
        self.delegate = delegate
        self.serviceProvider = provider
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarTitle()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        setupConstraints()
    }
    
    func setupNavigationBarTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("title_settings", comment: "")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingsCell: UITableViewCell = UITableViewCell()
        
        if let settingsIndex = SettingsIndex(rawValue: indexPath.row) {
            settingsCell.textLabel?.text = NSLocalizedString( settingsIndex.settingsName(), comment: "")
        }
        
        return settingsCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("pref_main_settings", comment: "")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if SettingsIndex(rawValue: indexPath.row) == .logout {
            handleLogOutTap()
        }
    }
    
    func handleLogOutTap() {
        let alert = UIAlertController(title: NSLocalizedString("msg_logout_question", comment: ""), message: NSLocalizedString("msg_logout_info", comment: ""), preferredStyle: UIAlertControllerStyle.alert)

        alert.addAction(UIAlertAction(title: NSLocalizedString("msg_logout", comment: ""), style: UIAlertActionStyle.destructive, handler: {[unowned self] _ in
            self.delegate?.logoutButtonTapped()
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("msg_cancel", comment: ""), style: UIAlertActionStyle.cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(view)
            make.edges.equalTo(view)
        }
    }
}
