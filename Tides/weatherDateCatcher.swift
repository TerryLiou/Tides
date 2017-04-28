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
                        
                        print(characterIndex)
                        
                        var status = ""
                        var rainfall = ""
                        var temperature = ""
                        var windDiraction = ""
                        var windSpeed = ""
                        var humidity = ""

                        if characterIndex.count == 6 {

                            for i in 0 ..< characterIndex.count {

                                switch i {

                                case 0:

                                    let startIndex = elementValue.startIndex
                                    let endIndex = elementValue.index(startIndex, offsetBy: characterIndex[0])
                                    let range = startIndex ..< endIndex

                                    status = elementValue.substring(with: range)
                                    print(status)

                                case 1:

                                    let startIndex = elementValue.index(elementValue.startIndex,
                                                                        offsetBy: characterIndex[0] + 7)
                                    let endIndex = elementValue.index(elementValue.startIndex, offsetBy: characterIndex[1])
                                    let range = startIndex ..< endIndex

                                    rainfall = elementValue.substring(with: range)

                                case 2:

                                    let startIndex = elementValue.index(elementValue.startIndex,
                                                                        offsetBy: characterIndex[1] + 6)
                                    let endIndex = elementValue.index(elementValue.startIndex, offsetBy: characterIndex[2] - 1)
                                    let range = startIndex ..< endIndex

                                    temperature = elementValue.substring(with: range)

                                case 3:

                                    let startIndex = elementValue.index(elementValue.startIndex,
                                                                        offsetBy: characterIndex[3] + 2)
                                    let endIndex = elementValue.index(elementValue.startIndex, offsetBy: characterIndex[3] + 5)
                                    let range = startIndex ..< endIndex

                                    windDiraction = elementValue.substring(with: range)

                                case 4:

                                    let startIndex = elementValue.index(elementValue.startIndex,
                                                                        offsetBy: characterIndex[3] + 6)
                                    let endIndex = elementValue.index(elementValue.startIndex, offsetBy: characterIndex[4])
                                    let range = startIndex ..< endIndex

                                    windSpeed = elementValue.substring(with: range)

                                case 5:

                                    let startIndex = elementValue.index(elementValue.startIndex,
                                                                        offsetBy: characterIndex[5] - 3)
                                    let endIndex = elementValue.index(elementValue.startIndex, offsetBy: characterIndex[5])
                                    let range = startIndex ..< endIndex

                                    humidity = elementValue.substring(with: range)

                                default: break

                                }
                            }

                        } else {

                            for i in 0 ..< characterIndex.count {

                                switch i {

                                case 0:

                                    let startIndex = elementValue.startIndex
                                    let endIndex = elementValue.index(startIndex, offsetBy: characterIndex[0])
                                    let range = startIndex ..< endIndex

                                    status = elementValue.substring(with: range)

                                case 1:

                                    let startIndex = elementValue.index(elementValue.startIndex,
                                                                        offsetBy: characterIndex[0] + 6)
                                    let endIndex = elementValue.index(elementValue.startIndex, offsetBy: characterIndex[1] - 1)
                                    let range = startIndex ..< endIndex

                                    temperature = elementValue.substring(with: range)

                                case 2:

                                    let startIndex = elementValue.index(elementValue.startIndex,
                                                                        offsetBy: characterIndex[2] + 2)
                                    let endIndex = elementValue.index(elementValue.startIndex, offsetBy: characterIndex[2] + 5)
                                    let range = startIndex ..< endIndex

                                    windDiraction = elementValue.substring(with: range)

                                case 3:

                                    let startIndex = elementValue.index(elementValue.startIndex,
                                                                        offsetBy: characterIndex[2] + 6)
                                    let endIndex = elementValue.index(elementValue.startIndex, offsetBy: characterIndex[3])
                                    let range = startIndex ..< endIndex

                                    windSpeed = elementValue.substring(with: range)

                                case 4:

                                    let startIndex = elementValue.index(elementValue.startIndex,
                                                                        offsetBy: characterIndex[4] - 3)
                                    let endIndex = elementValue.index(elementValue.startIndex, offsetBy: characterIndex[4])
                                    let range = startIndex ..< endIndex

                                    humidity = elementValue.substring(with: range)

                                default: break

                                }
                                
                            }

                            rainfall = "--%"
                        }
                        
                        let weatherData = WeatherDateAPI(startTime: startTime!, endTime: endTime!, status: status, rainfall: rainfall, temperature: temperature, windDiraction: windDiraction, windSpeed: windSpeed, humidity: humidity)

                        weatherDatas.append(weatherData)

                    }

                    weatherDatas.sort(by: { $0.startTime.compare($1.startTime) == .orderedAscending})

                }
            }

            completion(weatherDatas)

        }
    }
}
