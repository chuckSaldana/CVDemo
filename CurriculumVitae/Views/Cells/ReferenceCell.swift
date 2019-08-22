//
//  ReferenceCell.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 20/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit

class ReferenceCell: UITableViewCell, CVCell {
    static let cellIdentifier: String = "ReferenceCellIdentifier"
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    
    // Fill cell UI with info's data on assignment
    var info: CellInfo? {
        didSet {
            guard  let reference = info as? ReferenceCellInfo else {
                return
            }
            self.nameLbl.text = reference.name
            self.emailLbl.text = reference.email
            self.phoneLbl.text = reference.phone
        }
    }
}
