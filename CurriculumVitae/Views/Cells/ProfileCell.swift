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
    
    var curriculum: Curriculum? {
        didSet {
            if let photoUrlStr = curriculum?.photo_path,
                let photoUrl = URL(string: photoUrlStr) {
                do {
                    self.photoImgV.image = UIImage(data: try Data(contentsOf: photoUrl))
                } catch {
                    print("Exception caught: \(error)")
                }
            }
            self.nameLbl.text = curriculum?.name
            self.occupationLbl.text = curriculum?.label
            self.summaryLbl.text = curriculum?.summary
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
