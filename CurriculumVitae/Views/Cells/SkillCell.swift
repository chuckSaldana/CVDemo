//
//  SkillCell.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 20/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit

class SkillCell: UITableViewCell, CVCell {
    static let cellIdentifier: String = "SkillCellIdentifier"
    @IBOutlet weak var nameLbl: UILabel!
    
    // Fill cell UI with info's data on assignment
    var info: CellInfo? {
        didSet {
            guard  let skill = info as? SkillCellInfo else {
                return
            }
            self.nameLbl.text = skill.name
        }
    }
}
