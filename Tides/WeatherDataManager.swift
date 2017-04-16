//
//  WeatherDataManager.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/15.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation

enum GotWeatherError: Error {

    
}
class WeatherDataManager {

    static let shared = WeatherDataManager()

    typealias GotWindData = (WindModel?, Error?) -> Void

    func getWindData(town: String, completionHandler: @escaping GotWindData) {

        
    }
}
