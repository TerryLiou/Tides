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
    let normalCalendar = Calendar.current
    let formatter = DateFormatter()

    override func awakeFromNib() {

        super.awakeFromNib()

    }

    func configCell(IndexPath indexPath: IndexPath) {

        moonPhase.image = UIImage(named: String(indexPath.row))

        let showedDate = normalCalendar.date(byAdding: .day, value: indexPath.row, to: Constant.firstDay!)!

        formatter.dateFormat = "MM/dd"

        let showedDateString = formatter.string(from: showedDate)

        date.text = showedDateString
    }

}
