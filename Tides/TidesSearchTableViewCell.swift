//
//  TidesSearchTableViewCell.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/3/26.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit

class TidesSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var tidesStationName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = Constant.ColorCode.prussianBlue
        tidesStationName.textColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
