//
//  CompetitionsViewController.swift
//  Auto Stop Race
//
//  Created by Bartłomiej Korpus on 13/04/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import UIKit
import Networking

class CompetitionsViewController: UIViewControllerWithMenu {
    
    @IBOutlet weak var competitionsTableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var apiService: ApiServiceType!
    
    private var competitions: [Competition] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTitle()
        setupTableView()
        loadData()
    }
    
    private func setupTitle() {
        let titleLabel = navigationItem.titleView as! UILabel
        titleLabel.text = NSLocalizedString("title_competitions", comment: "")
    }
    
    private func setupTableView() {
        competitionsTableView.register(UINib(nibName: "CompetitionCell", bundle: nil), forCellReuseIdentifier: "CompetitionCell")
        competitionsTableView.delegate = self
        competitionsTableView.dataSource = self
        competitionsTableView.rowHeight = UITableView.automaticDimension
        competitionsTableView.allowsSelection = false
        competitionsTableView.estimatedRowHeight = 100
        competitionsTableView.tableFooterView = UIView()
    }
    
    private func loadData() {
        indicator.startAnimating()
        
        hideMessage()
        
        apiService.fetchCompetitions { result in
            switch result {
            case .success(let competitions):
                self.competitions = competitions
                if competitions.count == 0 {
                    DispatchQueue.main.async {
                        self.showMessage(text: NSLocalizedString("no_competitions", comment: ""))
                    }
                }
            case .failure(let error):
                self.competitions = []
                print(error)
                DispatchQueue.main.async {
                    self.showMessage(text: NSLocalizedString("error_404", comment: ""))
                }
            }
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.competitionsTableView.reloadData()
                
            }
            
        }
    }
    
    private func showMessage(text: String) {
        messageLabel.isHidden = false
        messageLabel.text = text
    }
    
    private func hideMessage() {
        messageLabel.isHidden = true
    }
}

extension CompetitionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompetitionCell", for: indexPath) as! CompetitionCell
        cell.model = competitions[indexPath.item]
        return cell
    }
    
}
