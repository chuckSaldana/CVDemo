//
//  InterestCell.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 21/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit

class InterestCell: UITableViewCell, CVCell {
    static let cellIdentifier: String = "InterestCellIdentifier"
    @IBOutlet weak var nameLbl: UILabel!
    
    // Fill cell UI with info's data on assignment
    var info: CellInfo? {
        didSet {
            guard  let interest = info as? InterestCellInfo else {
                return
            }
            self.nameLbl.text = interest.name
        }
    }
}
