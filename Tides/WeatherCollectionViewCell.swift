//
//  WeatherCollectionViewCell.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/5.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var momentLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempertureLabel: UILabel!

    let currentDate = Date()
    let testCalendar = Calendar.current
    let formetter = DateFormatter()

    override func awakeFromNib() {

        super.awakeFromNib()

    }

    func setUpCellView(_ rowNumber: Int) -> WeatherCollectionViewCell {

        // Force Case: Date from calendar by currentDate always successed.
        let cellMoment = testCalendar.date(byAdding: .hour, value: rowNumber, to: currentDate)!

        for weatherData in Constant.wertherDatas {

            if cellMoment >= weatherData.startTime && cellMoment <= weatherData.endTime {

                formetter.dateFormat = "HH:00"

                if rowNumber == 0 {

                    momentLabel.text = "現在"
                } else if formetter.string(from: cellMoment) == "00:00" {

                    formetter.dateFormat = "MM/dd"

                    momentLabel.text = formetter.string(from: cellMoment)

                } else {

                    momentLabel.text = formetter.string(from: cellMoment)
    
                }

                tempertureLabel.text = weatherData.temperature + "°C"
                
                if weatherData.status.characters.contains("雨") {
                    
                    weatherImage.image = #imageLiteral(resourceName: "storm")
                    
                } else if weatherData.status.characters.contains("雲") && weatherData.status.characters.contains("晴"){
                    
                    weatherImage.image = #imageLiteral(resourceName: "clouded")
                    
                } else if weatherData.status.characters.contains("晴") {
                    
                    weatherImage.image = #imageLiteral(resourceName: "sun")
                    
                } else {
                    
                    weatherImage.image = #imageLiteral(resourceName: "cloud")
                }
            }
        }

        return self
    }
}
