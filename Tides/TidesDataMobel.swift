//
//  TidesDataMobel.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/3/22.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation
import MapKit

struct TidesData {
    let date: String
    let location: String
    let order: Int
    let time: String
    let type: String
    let tide: String
    let height: Int
    let stationID: String
    let areaID: String
    init(date: String, location: String, order: Int,
         time: String, type: String, tide: String,
         height: Int, stationID: String, areaID: String) {
        self.date = date
        self.location = location
        self.order = order
        self.time = time
        self.type = type
        self.tide = tide
        self.height = height
        self.stationID = stationID
        self.areaID = areaID
    }
}

struct TidesDataAPI {

    let date: String
    let location: String
    let order: Int
    let time: Date
    let type: String
    let tide: String
    let height: Int
    init(date: String, location: String, order: Int,
         time: Date, type: String, tide: String,
         height: Int) {
        self.date = date
        self.location = location
        self.order = order
        self.time = time
        self.type = type
        self.tide = tide
        self.height = height
    }
}
struct TidesDataFirebase {

    let date: String
    let location: String
    let order: Int
    let time: String
    let type: String
    let tide: String
    let height: Int
    let stationID: String
    init(date: String, location: String, order: Int,
         time: String, type: String, tide: String,
         height: Int, stationID: String) {
        self.date = date
        self.location = location
        self.order = order
        self.time = time
        self.type = type
        self.tide = tide
        self.height = height
        self.stationID = stationID

    }
}

struct TidesDataArray {

    static var data: [TidesData] = []
    static var amountOfData = Int()
    static let cityOrder = [ Constant.Taipei.mandarin,
                             Constant.Keelung.mandarin,
                             Constant.Taoyuan.mandarin,
                             Constant.Hsinchu.mandarin,
                             Constant.HsinchuCity.mandarin,
                             Constant.Miaoli.mandarin,
                             Constant.Changhua.mandarin,
                             Constant.Taichung.mandarin,
                             Constant.Yunlin.mandarin ]
}
