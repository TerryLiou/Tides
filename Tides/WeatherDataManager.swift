//
//  WeatherDataManager.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/15.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation
import Alamofire

enum GotWeatherError: Error {

}
class WeatherDataManager {

    static let shared = WeatherDataManager()
    let dateFormatter = DateFormatter()

    typealias GotWindData = (WindModel?, Error?) -> Void

    func getWindData(town: String/* , completionHandler: @escaping GotWindData */) {

        let headers: HTTPHeaders = [
            "Authorization": "CWB-22828482-7018-4F93-BE0F-663A5B4738A8"
        ]
        let townCode = town.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let tidesType = "潮差,1日潮汐".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = "http://opendata.cwb.gov.tw/api/v1/rest/datastore/F-A0021-001?locationName=" + townCode! + "&elementName=" + tidesType! + "&sort=validtime"

        Alamofire.request(url, headers: headers).responseJSON { response in

            if response.result.isSuccess {

                if let result = response.value as? [String: AnyObject] {

                    guard let records = result["records"] as? [String: AnyObject] else { return }
                    guard let location = records["location"] as? [[String: AnyObject]] else { return }
                    guard let validTime = location[0]["validTime"] as? [[String: AnyObject]] else { return }

                    for daily in validTime {

                        guard let dailyData = daily["weatherElement"] as? [[String: AnyObject]] else { return }

                        guard let tideType = dailyData[0]["elementValue"] as? String else { return }  // 潮差

                        guard let dailyTides = dailyData[1]["time"] as? [[String: AnyObject]]else { return }
                        
                        for dailyTide in dailyTides {

                            guard let dataTime = dailyTide["dataTime"] as? String else { return }

                            self.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            self.dateFormatter.locale = Locale.init(identifier: "zh_Hant_TW")

                            let time = self.dateFormatter.date(from: dataTime) // Date 格式

                            print(<#T##items: Any...##Any#>)
                            guard let tideDetail = dailyTide["parameter"] as? [[String: String]] else { return }

                            let contain = tideDetail.filter({ T -> Bool in

                               return T.count == 2

                            })

                            let lowHeight = contain[0]["parameterValue"] // 潮汐
                            var height: Int

                            for tideData in tideDetail {

                                if tideData["parameterName"] == "潮高(當地)" {

                                    height = Int(tideData["parameterValue"]!)! // 潮高

                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
