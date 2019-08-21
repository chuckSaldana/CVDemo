//
//  SkillCell.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 20/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit

class SkillCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    
    var skill: CellInfo? {
        didSet {
            guard  let skill = skill as? SkillCellInfo else {
                return
            }
            self.nameLbl.text = skill.name
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
