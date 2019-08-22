//
//  WorkCell.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 20/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit

class WorkCell: UITableViewCell, CVCell {
    static let cellIdentifier: String = "WorkCellIdentifier"
    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var datesLbl: UILabel!
    
    // Fill cell UI with info's data on assignment
    var info: CellInfo? {
        didSet {
            guard  let role = info as? RoleCellInfo else {
                return
            }
            self.companyLbl.text = role.company
            self.datesLbl.text = role.dateRange
        }
    }
}
