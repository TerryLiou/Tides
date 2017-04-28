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

        let year = normalCalendar.component(.year, from: currentDate)

        let hexYearCode = Constant.hexYear.yearCode[String(year)]!

        let yearCode = Int(hexYearCode, radix: 16)!

        let binaryYearCode = String(yearCode, radix: 2)

        let startIndex = binaryYearCode.startIndex
        
        let midIndex = binaryYearCode.index(binaryYearCode.endIndex, offsetBy: -4)

        let endIndex = binaryYearCode.endIndex
        
        let dayOfMonth = binaryYearCode.substring(with: startIndex ..< midIndex)

        let binaryExtraMonth = binaryYearCode.substring(with: midIndex ..< endIndex)

        if binaryYearCode.characters.count == 16 {

            if binaryExtraMonth != "0000" || binaryExtraMonth != "1111" {

                let extraMonth = Int(binaryYearCode, radix: 2)
                
                let nextYear = year + 1

                let hexNextYearCode = Constant.hexYear.yearCode[String(nextYear)]!

                let fromIndex = binaryYearCode.index(binaryYearCode.endIndex, offsetBy: -4)
                
                let toIndex = binaryYearCode.endIndex

                let dayOfExtraMonth = binaryYearCode.substring(with: fromIndex ..< toIndex)

                if dayOfExtraMonth == "1111" {

                    
                }
            }
        }

        if chineseDay >= 16 {

            let indexRow = chineseDay - 16

            let firstDay = normalCalendar.date(byAdding: .day, value: -indexRow, to: currentDate)

            Constant.firstDay = firstDay!
            Constant.firstDayMoonCellIndexPath = IndexPath(row: indexRow, section: 0)

        } else {

            let indexRow = chineseDay + 14

            let firstDay = normalCalendar.date(byAdding: .day, value: -indexRow, to: currentDate)

            Constant.firstDay = firstDay!
            Constant.firstDayMoonCellIndexPath = IndexPath(row: indexRow, section: 0)

        }
    }
}

extension String {

    func getIndexFromStart(to index: Int) -> Index {

        return self.index(startIndex, offsetBy: index)

    }

}

















