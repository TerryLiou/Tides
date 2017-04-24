//
//  dateManager.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/24.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation

class DateManager {

    static let shared = DateManager()

    let chineseCalendar = Calendar(identifier: .chinese)
    let normalCalendar = Calendar.current
    let formatter = DateFormatter()
    let currentDate = Date()

    func getFirstDay() {

        formatter.dateStyle = .short
        formatter.calendar = chineseCalendar

        let chineseDay = chineseCalendar.component(.day, from: currentDate)

        if chineseDay >= 16 && chineseDay <= 30 {

            let indexRow = chineseDay - 16

            let firstDay = normalCalendar.date(byAdding: .day, value: -indexRow, to: currentDate)

            Constant.firstDay = firstDay!

        } else {

            let indexRow = chineseDay + 14

            let firstDay = normalCalendar.date(byAdding: .day, value: -indexRow, to: currentDate)

            Constant.firstDay = firstDay!

        }
    }
}
