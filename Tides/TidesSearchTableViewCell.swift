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
    @IBOutlet weak var distance: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = Constant.ColorCode.greenBlue1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
