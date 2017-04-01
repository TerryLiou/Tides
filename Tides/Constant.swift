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

    static var selectedAreaIDFromMapView: String?

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

    struct Taipei {
        static let mandarin = "新北市"
        static let areaID = "5000"
    }

    struct Keelung {
        static let mandarin = "基隆市"
        static let areaID = "0017"
    }

    struct Taoyuan {
        static let mandarin = "桃園縣"
        static let areaID = "0003"
    }

    struct Hsinchu {
        static let mandarin = "新竹縣"
        static let areaID = "0004"
    }

    struct HsinchuCity {
        static let mandarin = "新竹市"
        static let areaID = "0018"
    }

    struct Miaoli {
        static let mandarin = "苗栗縣"
        static let areaID = "0005"
    }

    struct Taichung {
        static let mandarin = "台中市"
        static let areaID = "6000"
    }

    struct Changhua {
        static let mandarin = "彰化縣"
        static let areaID = "0007"
    }

    struct Yunlin {
        static let mandarin = "雲林縣"
        static let areaID = "0009"
    }
}
