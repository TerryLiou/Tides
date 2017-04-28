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

        var chineseMonth = chineseCalendar.component(.month, from: currentDate)

        let year = normalCalendar.component(.year, from: currentDate)

        let hexYearCode = Constant.hexYear.yearCode[String(year)]!

        var binaryYearCode = String(Int(hexYearCode, radix: 16)!, radix: 2)
        
        var dayOfMonth = binaryYearCode.substring(with: binaryYearCode.startIndex ..< binaryYearCode.getIndexFromEnd(to: -4))

        let binaryExtraMonth = binaryYearCode.substring(with: binaryYearCode.getIndexFromEnd(to: -4) ..< binaryYearCode.endIndex)

        if binaryYearCode.characters.count == 15 {   // if binaryYearCode count is 15, means first month is small month.

            dayOfMonth = "0" + dayOfMonth

        }

        // if less 4 bit isn't "0000" or "1111" means this year have extra month
        if binaryExtraMonth != "0000" && binaryExtraMonth != "1111" {

            let extraMonth = Int(binaryExtraMonth, radix: 2)!
                
            let nextYear = year + 1

            let hexNextYearCode = Constant.hexYear.yearCode[String(nextYear)]!

            let binaryNextYearCode = String(Int(hexNextYearCode, radix: 16)!, radix: 2)

            let dayOfExtraMonth = binaryNextYearCode.substring(with: binaryNextYearCode.getIndexFromEnd(to: -4) ..< binaryNextYearCode.endIndex)

            if dayOfExtraMonth == "1111" {

                dayOfMonth.insert(contentsOf: "1".characters, at: dayOfMonth.getIndexFromStart(to: extraMonth))

            } else {

                dayOfMonth.insert(contentsOf: "0".characters, at: dayOfMonth.getIndexFromStart(to: extraMonth))

            }
        }

        // extra month will appear twice, when that heppen. The indexRow need +1
        formatter.dateStyle = .medium
    
        let mediumDateString = formatter.string(from: currentDate)
        
        for i in 0 ..< mediumDateString.characters.count {
            
            if mediumDateString.characters[mediumDateString.getIndexFromStart(to: i)] == "閏" {
                
                chineseMonth += 1

            }
        }

        if chineseDay >= 17 {

            let indexRow = chineseDay - 17

            let firstDay = normalCalendar.date(byAdding: .day, value: -indexRow, to: currentDate)

            Constant.firstDay = firstDay!
            Constant.firstDayMoonCellIndexPath = IndexPath(row: indexRow, section: 0)

        } else {

            if dayOfMonth.characters[dayOfMonth.getIndexFromStart(to: chineseMonth - 1)] == "1" {

                let indexRow = chineseDay + 13
                let firstDay = normalCalendar.date(byAdding: .day, value: -indexRow, to: currentDate)
                
                Constant.firstDay = firstDay!
                Constant.firstDayMoonCellIndexPath = IndexPath(row: indexRow, section: 0)

            } else {

                let indexRow = chineseDay + 12
                let firstDay = normalCalendar.date(byAdding: .day, value: -indexRow, to: currentDate)
                
                Constant.firstDay = firstDay!
                Constant.firstDayMoonCellIndexPath = IndexPath(row: indexRow, section: 0)

            }
        }
    }
}

extension String {

    func getIndexFromStart(to index: Int) -> Index {

        return self.index(startIndex, offsetBy: index)

    }

    func getIndexFromEnd(to index: Int) -> Index {

        return self.index(endIndex, offsetBy: index)

    }
}
