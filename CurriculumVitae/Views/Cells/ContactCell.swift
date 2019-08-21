//
//  ContactCell.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 20/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    var contact: CellInfo? {
        didSet {
            guard  let contact = contact as? ContactCellInfo else {
                return
            }
            self.emailLbl.text = contact.email
            self.phoneLbl.text = contact.phone
            self.websiteLbl.text = contact.website
            self.locationLbl.text = "\(contact.city ?? ""), \(contact.state ?? "")"
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
