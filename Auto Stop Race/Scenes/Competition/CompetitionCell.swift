//
//  CompetitionCell.swift
//  Auto Stop Race
//
//  Created by Bartłomiej Korpus on 13/04/2019.
//  Copyright © 2019 Torianin. All rights reserved.
//

import UIKit
import Networking

class CompetitionCell: UITableViewCell {

    @IBOutlet weak var competitionName: UILabel!
    @IBOutlet weak var competitionDescription: UILabel!
    
    var model: Competition? {
        didSet {
            competitionName.text = model?.name
            competitionDescription.text = model?.description
            competitionName.sizeToFit()
        }
    }
    
}
