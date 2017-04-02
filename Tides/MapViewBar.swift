//
//  MapViewBar.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/2.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation
import UIKit

class MapViewBar: UIView {

    let satelliteButton = UIButton()
    let suitableSpanButton = UIButton()
    let chartViewButton = UIButton()

    override func awakeFromNib() {
    }

    func configButton() {

        satelliteButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        satelliteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                  constant: 30)
        satelliteButton.widthAnchor.constraint(equalToConstant: 32)
        satelliteButton.heightAnchor.constraint(equalToConstant: 32)
        let satellite = #imageLiteral(resourceName: "satellite").withRenderingMode(.alwaysOriginal)
        satelliteButton.setImage(satellite, for: .normal)
    }
}
