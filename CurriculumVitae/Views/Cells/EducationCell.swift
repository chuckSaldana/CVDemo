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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
