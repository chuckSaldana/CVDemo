//
//  WorkCell.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 20/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit

class WorkCell: UITableViewCell {

    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var datesLbl: UILabel!
    
    var work: Role? {
        didSet {
            self.companyLbl.text = work?.company
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-dd-MM"
            var dateText = ""
            if let dateStart = work?.date_start {
                let dateStartString = dateFormatter.string(from: dateStart)
                dateText = dateText + "From: \(dateStartString)"
            }
            if let dateEnd = work?.date_end {
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
