//
//  ProfileCell.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 20/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell, CVCell {
    static let cellIdentifier: String = "ProfileCellIdentifier"
    @IBOutlet weak var photoImgV: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var occupationLbl: UILabel!
    @IBOutlet weak var summaryLbl: UILabel!
    
    // Fill cell UI with info's data on assignment
    var info: CellInfo? {
        didSet {
            guard  let profile = info as? ProfileCellInfo else {
                return
            }
            if let photoUrlStr = profile.photoPath,
                let photoUrl = URL(string: photoUrlStr) {
                do {
                    self.photoImgV.image = UIImage(data: try Data(contentsOf: photoUrl))
                } catch {
                    self.photoImgV.image = UIImage(named: "photo_placeholder")
                    print("Exception caught: \(error)")
                }
                self.photoImgV.removeLoadingView()
            }
            self.nameLbl.text = profile.name
            self.occupationLbl.text = profile.label
            self.summaryLbl.text = profile.summary
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.photoImgV.showLoadingView()
    }
}
