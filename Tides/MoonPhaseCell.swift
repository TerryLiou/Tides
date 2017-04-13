//
//  MoonPhaseCell.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/13.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit

class MoonPhaseCell: UICollectionViewCell {

    @IBOutlet weak var moonPhase: UIImageView!
    @IBOutlet weak var date: UILabel!

    override func awakeFromNib() {

        super.awakeFromNib()

    }

    func configCell(IndexPath indexPath: IndexPath) {

        moonPhase.image = UIImage(named: String(indexPath.row))
        date.text = "12/31"
    }

}
