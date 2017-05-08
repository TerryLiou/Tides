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

struct TidesDataArray {

    static var data: [TidesData] = []
    static var amountOfData = Int()

}

struct WeatherDateAPI {
    
    let startTime: Date
    let endTime: Date
    let weatherImage: UIImage
    let rainfall: String
    let temperature: String
    let windDiraction: String
    let windSpeed: String
    let humidity: String
    
    init(startTime: Date, endTime: Date, weatherImage: UIImage, rainfall: String, temperature: String, windDiraction: String, windSpeed: String, humidity: String) {
        
        self.startTime = startTime
        self.endTime = endTime
        self.weatherImage = weatherImage
        self.rainfall = rainfall
        self.temperature = temperature
        self.windDiraction = windDiraction
        self.windSpeed = windSpeed
        self.humidity = humidity
    }
}
