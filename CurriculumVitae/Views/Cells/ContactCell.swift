//
//  ContactCell.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 20/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell, CVCell {
    static let cellIdentifier: String = "ContactCellIdentifier"
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    // Fill cell UI with info's data on assignment
    var info: CellInfo? {
        didSet {
            guard  let contact = info as? ContactCellInfo else {
                return
            }
            self.emailLbl.text = contact.email
            self.phoneLbl.text = contact.phone
            self.websiteLbl.text = contact.website
            self.locationLbl.text = contact.location
        }
    }
}
