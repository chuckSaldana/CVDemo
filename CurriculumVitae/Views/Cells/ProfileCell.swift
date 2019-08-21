//
//  ProfileCell.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 20/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var photoImgV: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var occupationLbl: UILabel!
    @IBOutlet weak var summaryLbl: UILabel!
    
    var profile: CellInfo? {
        didSet {
            guard  let profile = profile as? ProfileCellInfo else {
                return
            }
            if let photoUrlStr = profile.photoPath,
                let photoUrl = URL(string: photoUrlStr) {
                do {
                    self.photoImgV.image = UIImage(data: try Data(contentsOf: photoUrl))
                } catch {
                    print("Exception caught: \(error)")
                }
            }
            self.nameLbl.text = profile.name
            self.occupationLbl.text = profile.label
            self.summaryLbl.text = profile.summary
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
