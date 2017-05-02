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
    let currentDate = Date()
    let todayIndexRow = (Constant.todayMoonCellIndexPath?.row)!

    override func awakeFromNib() {

        super.awakeFromNib()

    }

    func configCell(IndexPath indexPathRow: Int) -> UICollectionViewCell {

        if Constant.chineseMonthRange == "1" {

            moonPhase.image = UIImage(named: String(indexPathRow))
            
        } else {

            moonPhase.image = UIImage(named: String(indexPathRow + 1))

        }

        moonPhase.layer.cornerRadius = moonPhase.frame.height / 2
        moonPhase.clipsToBounds = true

        if indexPathRow < todayIndexRow {

            let showedDate = normalCalendar.date(byAdding: .day, value: indexPathRow, to: Constant.firstDay!)!

            date.text = Date.getTodayDateOfStringAndDate("MM/dd", showedDate)

        } else if indexPathRow == todayIndexRow {

            date.text = "今天"

        } else {

            let offSetDay = indexPathRow - todayIndexRow

            let showedDate = normalCalendar.date(byAdding: .day, value: offSetDay, to: currentDate)!
            
            date.text = Date.getTodayDateOfStringAndDate("MM/dd", showedDate)

        }

        return self

    }

}
