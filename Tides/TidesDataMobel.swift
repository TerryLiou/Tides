//
//  TidesDataMobel.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/3/22.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation

struct TidesData {
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

class TidesDataArray {
    static var data: [TidesData] = []
    static var amountOfData = TidesDataArray.data.count
}
