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
    let currentDate = Date()

    override func awakeFromNib() {

        super.awakeFromNib()

    }

    func configCell(IndexPath indexPathRow: Int) -> UICollectionViewCell {

        moonPhase.image = UIImage(named: String(indexPathRow))

        let showedDate = normalCalendar.date(byAdding: .day, value: indexPathRow, to: Constant.firstDay!)!

        formatter.dateFormat = "MM/dd"

        let showedDateString = formatter.string(from: showedDate)

        let todayDateString = formatter.string(from: currentDate)

        if todayDateString == showedDateString {

            date.text = "今天"

        } else {

            date.text = showedDateString

        }

        return self

    }

}
