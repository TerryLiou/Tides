//
//  Constant.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/3/24.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation
import UIKit

struct Constant {

    static var selectedStationNameFromMapView = "宜蘭縣蘇澳鎮"
    static var selectedDateFromCalenderView: String?
    static var wertherDatas = [WeatherDateAPI]()
    static var initWertherData: WeatherDateAPI?
    static var firstDay: Date?
    static var firstDayMoonCellIndexPath: IndexPath?

    struct ColorCode {

        static let prussianBlue = UIColor.init(red: 44/255, green: 62/255, blue: 80/255, alpha: 1)
        static let oceanBoatBlue = UIColor.init(red: 41/255, green: 128/255, blue: 185/255, alpha: 1)
        static let ballBlue = UIColor.init(red: 51/255, green: 204/255, blue: 204/255, alpha: 1)
        static let antiFlashWhite = UIColor.init(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
        static let greenBlue4 = UIColor.init(red: 1/255, green: 86/255, blue: 104/255, alpha: 1)
        static let greenBlue3 = UIColor.init(red: 6/255, green: 100/255, blue: 140/255, alpha: 1)
        static let greenBlue2 = UIColor.init(red: 15/255, green: 129/255, blue: 199/255, alpha: 1)
        static let greenBlue1 = UIColor.init(red: 13/255, green: 226/255, blue: 234/255, alpha: 1)

    }

    struct CompassByPi {

        static let en = Float.pi / 4
        static let e = Float.pi / 2
        static let es = Float.pi * 3 / 4
        static let s = Float.pi
        static let ws = Float.pi * 5 / 4
        static let w = Float.pi * 3 / 2
        static let wn = -(Float.pi / 4)

    }

    struct TideProperty {

        static let date = "date"
        static let height = "height"
        static let location = "location"
        static let order = "order"
        static let tide = "tide"
        static let time = "time"
        static let type = "type"
        static let stationID = "stationID"
    }

    struct hexYear {

        static let yearCode = ["2017": "5176", "2018": "52bf", "2019": "a930", "2020": "7954",
                               "2021": "6aa0", "2022": "ad50", "2023": "5b52", "2024": "4b60",
                               "2025": "a6e6", "2026": "a4e0", "2027": "d260", "2028": "ea65",
                               "2029": "d530", "2030": "5aa0"]

    }
}
