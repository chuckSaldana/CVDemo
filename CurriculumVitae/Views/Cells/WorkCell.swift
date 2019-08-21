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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
