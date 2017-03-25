//
//  Extensions.swift
//  CalendarPopUp
//
//  Created by Atakishiyev Orazdurdy on 11/16/16.
//  Copyright © 2016 Veriloft. All rights reserved.
//

import UIKit

//
// Get humanDate
// Turkmen month
//

func GetHumanDate(month: Int) -> String {
    let monthArr: [Int: String] =
        [ 01: "Ýanwar",
          02: "Fewral",
          03: "Mart",
          04: "Aprel",
          05: "Maý",
          06: "Iýun",
          07: "Iýul",
          08: "Awgust",
          09: "Sentýabr",
          10: "Oktýabr",
          11: "Noýabr",
          12: "Dekabr"]
    return monthArr[month]!
}

func GetChineseMonth(month: Int) -> String {
    let monthString: [Int: String] =
        [ 01: "1月",
          02: "2月",
          03: "3月",
          04: "4月",
          05: "5月",
          06: "6月",
          07: "7月",
          08: "8月",
          09: "9月",
          10: "10月",
          11: "11月",
          12: "12月"]
    return monthString[month]!
}

func GetWeekday(weekday: Int) -> String {
    let weekdayString: [Int: String] =
        [ 1: "日", 2: "一", 3: "二", 4: "三", 5: "四", 6: "五", 7: "六"]
    return weekdayString[weekday]!
}

extension Date {

    //period -> .WeekOfYear, .Day
    func rangeOfPeriod(period: Calendar.Component) -> (Date, Date) {

        var startDate = Date()
        var interval: TimeInterval = 0
        let _ = Calendar.current.dateInterval(of: period, start: &startDate, interval: &interval, for: self)
        let endDate = startDate.addingTimeInterval(interval - 1)

        return (startDate, endDate)
    }

    func calcStartAndEndOfDay() -> (Date, Date) {
        return rangeOfPeriod(period: .day)
    }

    func calcStartAndEndOfWeek() -> (Date, Date) {
        return rangeOfPeriod(period: .weekday)
    }

    func calcStartAndEndOfMonth() -> (Date, Date) {
        return rangeOfPeriod(period: .month)
    }

    func getSpecificDate(interval: Int) -> Date {
        var timeInterval = DateComponents()
        timeInterval.day = interval
        return Calendar.current.date(byAdding: timeInterval, to: self)!
    }

    func getStart() -> Date {
        let (start, _) = calcStartAndEndOfDay()
        return start
    }

    func getEnd() -> Date {
        let (_, end) = calcStartAndEndOfDay()
        return end
    }
// swiftlint:disable variable_name
    func isBigger(to: Date) -> Bool {
        return Calendar.current.compare(self, to: to, toGranularity: .day) == .orderedDescending ? true : false
    }

    func isSmaller(to: Date) -> Bool {
        return Calendar.current.compare(self, to: to, toGranularity: .day) == .orderedAscending ? true : false
    }

    func isEqual(to: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: to)
    }

    func isElement(of: [Date]) -> Bool {
        for element in of {
            if self.isEqual(to: element) {
                return true
            }
        }
        return false
    }

    func getElement(of: [Date]) -> Date {
        for element in of {
            if self.isEqual(to: element) {
                return element
            }
        }
        return Date()
    }
// swiftlint:enable variable_name
}

class AnimationView: UIView {
    func animateWithFlipEffect(withCompletionHandler completionHandler:(() -> Void)?) {
        AnimationClass.flipAnimation(self, completion: completionHandler)
    }
    func animateWithBounceEffect(withCompletionHandler completionHandler:(() -> Void)?) {
        let viewAnimation = AnimationClass.BounceEffect()
        viewAnimation(self) { _ in
            completionHandler?()
        }
    }
    func animateWithFadeEffect(withCompletionHandler completionHandler:(() -> Void)?) {
        let viewAnimation = AnimationClass.fadeOutEffect()
        viewAnimation(self) { _ in
            completionHandler?()
        }
    }
}

extension UIColor {

    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }

}
