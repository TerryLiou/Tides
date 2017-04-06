//
//  WeatherCollectionViewCell.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/5.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var momentLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempertureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
