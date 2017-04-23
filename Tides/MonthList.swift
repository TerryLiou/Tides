//
//  monthList.swift
//  JTAppleCalenderPractice
//
//  Created by 劉洧熏 on 2017/4/22.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation

func getChineseMonth(month: String) -> String {

    let monthString: [String: String] =
        [ "01": "1月",
          "02": "2月",
          "03": "3月",
          "04": "4月",
          "05": "5月",
          "06": "6月",
          "07": "7月",
          "08": "8月",
          "09": "9月",
          "10": "10月",
          "11": "11月",
          "12": "12月"]

    return monthString[month]!

}
