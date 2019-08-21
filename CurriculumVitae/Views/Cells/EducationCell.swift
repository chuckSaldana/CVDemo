//
//  EducationCell.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 20/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit

class EducationCell: UITableViewCell {

    @IBOutlet weak var institutionLbl: UILabel!
    @IBOutlet weak var degreeLbl: UILabel!
    @IBOutlet weak var datesLbl: UILabel!
    
    var education: CellInfo? {
        didSet {
            guard  let education = education as? EducationCellInfo else {
                return
            }
            self.institutionLbl.text = education.institution
            self.degreeLbl.text = education.degree
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-dd-MM"
            var dateText = ""
            if let dateStart = education.dateStart {
                let dateStartString = dateFormatter.string(from: dateStart)
                dateText = dateText + "From: \(dateStartString)"
            }
            if let dateEnd = education.dateEnd {
                let dateEndString = dateFormatter.string(from: dateEnd)
                dateText = dateText + "to: \(dateEndString)"
            } else {
                dateText = dateText + "to: Current"
            }
            self.datesLbl.text = dateText
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
