//
//  EducationCell.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 20/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit

class EducationCell: UITableViewCell, CVCell {
    static let cellIdentifier: String = "EducationCellIdentifier"
    @IBOutlet weak var institutionLbl: UILabel!
    @IBOutlet weak var degreeLbl: UILabel!
    @IBOutlet weak var datesLbl: UILabel!
    
    // Fill cell UI with info's data on assignment
    var info: CellInfo? {
        didSet {
            guard  let education = info as? EducationCellInfo else {
                return
            }
            self.institutionLbl.text = education.institution
            self.degreeLbl.text = education.degree
            self.datesLbl.text = education.dateRange
        }
    }
}
