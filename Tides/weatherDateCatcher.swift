//
//  weatherAPICatcher.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/23.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class WeatherDataCatcher {

    static let shared = WeatherDataCatcher()

    func getWeatherFromAPI(completion: @escaping (_ weatherDates: [WeatherDateAPI]) -> Void) {

        let startIndex = "1".startIndex
        let midIndex = "123".endIndex
        let endIndex = "123456".endIndex
        let cityRange = startIndex ..< midIndex
        let townRange = midIndex ..< endIndex
        let cityName = (Constant.selectedStationNameFromMapView).substring(with: cityRange)
        let townName = (Constant.selectedStationNameFromMapView).substring(with: townRange)
        let cityCodeIndex = LocationList().citys.index { (name) -> Bool in
            name == cityName
        }
        var weatherDatas = [WeatherDateAPI]()
        let dateFormatter = DateFormatter()
        let headers: HTTPHeaders = [
            "Authorization": "CWB-22828482-7018-4F93-BE0F-663A5B4738A8"
        ]

        let townCode = townName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

        let url = "http://opendata.cwb.gov.tw/api/v1/rest/datastore/\(LocationList().citysCode[cityCodeIndex!])?locationName=" + townCode! + "&elementName=WeatherDescription&sort=validtime"

        Alamofire.request(url, headers: headers).responseJSON { response in

            if response.result.isSuccess {

                if let result = response.value as? [String: AnyObject] {

                    guard let records = result["records"] as? [String: AnyObject] else { return }
                    guard let locations = records["locations"] as? [[String: AnyObject]] else { return }
                    guard let location = locations[0]["location"] as? [[String: AnyObject]] else { return }
                    guard let weatherElement = location[0]["weatherElement"] as? [[String: AnyObject]] else { return }
                    guard let times = weatherElement[0]["time"] as? [[String:AnyObject]] else { return }

                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

                    for time in times {

                        guard let startTimeString = time["startTime"] as? String else { return }
                        guard let endTimeString = time["endTime"] as? String else { return }
                        guard let elementValue = time["elementValue"] as? String else { return }

                        let startTime = dateFormatter.date(from: startTimeString)
                        let endTime = dateFormatter.date(from: endTimeString)

                        var count = -1
                        var characterIndex = [Int]()

                        for character in elementValue.characters {

                            count += 1

                            if character == "。" {

                                characterIndex.append(count)

                            }
                        }

                        var weatherImage = UIImage()
                        var rainfall = ""
                        var temperature = ""
                        var windDiraction = ""
                        var windSpeed = ""
                        var humidity = ""

                        if characterIndex.count == 6 {

                            for i in 0 ..< characterIndex.count {

                                switch i {

                                case 0:

                                    let status = elementValue.substring(with: startIndex ..< elementValue.getIndexFromStart(to: characterIndex[0]))

                                    if status.characters.contains("雨") {
                                        
                                        weatherImage = #imageLiteral(resourceName: "largeStorm")
                                        
                                    } else if status.characters.contains("雷") {
                                        
                                        weatherImage = #imageLiteral(resourceName: "largeThunderRain")
                                        
                                    } else if status.characters.contains("雲") && status.characters.contains("晴"){
                                        
                                        weatherImage = #imageLiteral(resourceName: "largeClouded")
                                        
                                    } else if status.characters.contains("晴") {
                                        
                                        weatherImage = #imageLiteral(resourceName: "largeSun")
                                        
                                    } else {
                                        
                                        weatherImage = #imageLiteral(resourceName: "largeCloudy")
                                    }

                                case 1:

                                    rainfall = elementValue.substring(with: elementValue.getIndexFromStart(to: characterIndex[0] + 7) ..< elementValue.getIndexFromStart(to: characterIndex[1]))

                                case 2:

                                    temperature = elementValue.substring(with: elementValue.getIndexFromStart(to: characterIndex[1] + 6) ..< elementValue.getIndexFromStart(to: characterIndex[2] - 1))

                                case 3:

                                    windDiraction = elementValue.substring(with: elementValue.getIndexFromStart(to: characterIndex[3] + 2) ..< elementValue.getIndexFromStart(to: characterIndex[3] + 5))

                                case 4:

                                    windSpeed = elementValue.substring(with: elementValue.getIndexFromStart(to: characterIndex[3] + 6) ..< elementValue.getIndexFromStart(to: characterIndex[4]))

                                case 5:

                                    humidity = elementValue.substring(with: elementValue.getIndexFromStart(to: characterIndex[5] - 3) ..< elementValue.getIndexFromStart(to: characterIndex[5]))

                                default: break

                                }
                            }

                        } else {

                            for i in 0 ..< characterIndex.count {

                                switch i {

                                case 0:

                                    let status = elementValue.substring(with: startIndex ..< elementValue.getIndexFromStart(to: characterIndex[0]))

                                    if status.characters.contains("雨") {

                                        weatherImage = #imageLiteral(resourceName: "largeStorm")

                                    } else if status.characters.contains("雷") {

                                        weatherImage = #imageLiteral(resourceName: "largeThunderRain")

                                    } else if status.characters.contains("雲") && status.characters.contains("晴"){

                                        weatherImage = #imageLiteral(resourceName: "largeClouded")

                                    } else if status.characters.contains("晴") {

                                        weatherImage = #imageLiteral(resourceName: "largeSun")

                                    } else {

                                        weatherImage = #imageLiteral(resourceName: "largeCloudy")

                                    }

                                case 1:

                                    temperature = elementValue.substring(with: elementValue.getIndexFromStart(to: characterIndex[0] + 6) ..< elementValue.getIndexFromStart(to: characterIndex[1] - 1))

                                case 2:

                                    windDiraction = elementValue.substring(with: elementValue.getIndexFromStart(to: characterIndex[2] + 2) ..< elementValue.getIndexFromStart(to: characterIndex[2] + 5))

                                case 3:

                                    windSpeed = elementValue.substring(with: elementValue.getIndexFromStart(to: characterIndex[2] + 6) ..< elementValue.getIndexFromStart(to: characterIndex[3]))

                                case 4:

                                    humidity = elementValue.substring(with: elementValue.getIndexFromStart(to: characterIndex[4] - 3) ..< elementValue.getIndexFromStart(to: characterIndex[4]))

                                default: break

                                }

                            }

                            rainfall = "--%"
                        }

                        let weatherData = WeatherDateAPI(startTime: startTime!, endTime: endTime!, weatherImage: weatherImage, rainfall: rainfall, temperature: temperature, windDiraction: windDiraction, windSpeed: windSpeed, humidity: humidity)

                        weatherDatas.append(weatherData)

                    }

                    weatherDatas.sort(by: { $0.startTime.compare($1.startTime) == .orderedAscending})

                }
            }

            completion(weatherDatas)

        }
    }
}
