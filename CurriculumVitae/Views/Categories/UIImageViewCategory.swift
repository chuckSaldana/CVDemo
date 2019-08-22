//
//  UIImageViewCategory.swift
//  CurriculumVitae
//
//  Created by Apocalapsus on 21/08/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    static let loadinViewTag = 9999
    func showLoadingView() {
        DispatchQueue.main.async {
            let activityView = UIActivityIndicatorView(style: .gray)
            activityView.tag = UIImageView.loadinViewTag
            activityView.startAnimating()
            activityView.center = self.center
            self.addSubview(activityView)
        }
    }
    
    func removeLoadingView() {
        DispatchQueue.main.async {
            let activityView = self.viewWithTag(UIImageView.loadinViewTag)
            activityView?.removeFromSuperview()
        }
    }
}
