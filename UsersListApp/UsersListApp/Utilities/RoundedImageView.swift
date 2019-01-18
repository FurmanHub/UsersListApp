//
//  RoundedImageView.swift
//  UsersListApp
//
//  Created by Fedya on 1/17/19.
//  Copyright © 2019 Fedya. All rights reserved.
//

import Foundation
import UIKit

class RoundedImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.width / 2.0
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
