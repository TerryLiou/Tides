//
//  WeatherViewController.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/4.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit
import Crashlytics

class WeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //MARK: - Property

    @IBOutlet weak var mainWeatherImage: UIImageView!
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var rainFall: UILabel!
    @IBOutlet weak var windDiractionImage: UIImageView!
    @IBOutlet weak var windStatus: UILabel!
    @IBOutlet weak var humitity: UILabel!
    @IBOutlet weak var mianTemperature: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    let layout = UICollectionViewFlowLayout()
    let currentDate = Date()
    let normalCalendar = Calendar.current
    var rotatedAngle: Float = 0.0

    //MARK: - Life Cycle

    override func viewDidLoad() {

        super.viewDidLoad()
        setUpCellView()
        setUpInformation(byWeatherData: Constant.initWertherData!)
        self.navigationItem.title = Constant.selectedStationNameFromMapView

    }

    func setUpInformation(byWeatherData data: WeatherDateAPI) {

        dateLabel.text = Date.getTodayDateOfString("yyyy-MM-dd")
        dateLabel.textColor = Constant.ColorCode.oceanBoatBlue
        rainFall.text = data.rainfall
        windStatus.text = data.windSpeed
        humitity.text = data.humidity
        mianTemperature.text = data.temperature + "˚C"

        if data.status.characters.contains("雨") {
                
            mainWeatherImage.image = #imageLiteral(resourceName: "largeStorm")

        } else if data.status.characters.contains("雷") {

            mainWeatherImage.image = #imageLiteral(resourceName: "largeThunderRain")

        } else if data.status.characters.contains("雲") && data.status.characters.contains("晴"){
                
            mainWeatherImage.image = #imageLiteral(resourceName: "largeClouded")
                
        } else if data.status.characters.contains("晴") {
                
            mainWeatherImage.image = #imageLiteral(resourceName: "largeSun")
                
        } else {
                
            mainWeatherImage.image = #imageLiteral(resourceName: "largeCloudy")
        }

        windDiractionImage.transform = windDiractionImage.transform.rotated(by: CGFloat(-rotatedAngle))

        if data.windDiraction.characters.contains("東") && data.windDiraction.characters.contains("北") {

            windDiractionImage.transform = windDiractionImage.transform.rotated(by: CGFloat(Constant.CompassByPi.en))

            rotatedAngle = Constant.CompassByPi.en

        } else if data.windDiraction.characters.contains("東") && data.windDiraction.characters.contains("南") {
        
            windDiractionImage.transform = windDiractionImage.transform.rotated(by: CGFloat(Constant.CompassByPi.es))

            rotatedAngle = Constant.CompassByPi.es

        } else if data.windDiraction.characters.contains("西") && data.windDiraction.characters.contains("北") {

            windDiractionImage.transform = windDiractionImage.transform.rotated(by: CGFloat(Constant.CompassByPi.wn))

            rotatedAngle = Constant.CompassByPi.wn

        } else if data.windDiraction.characters.contains("西") && data.windDiraction.characters.contains("南") {

            windDiractionImage.transform = windDiractionImage.transform.rotated(by: CGFloat(Constant.CompassByPi.ws))

            rotatedAngle = Constant.CompassByPi.ws

        } else if data.windDiraction.characters.contains("東") {

            windDiractionImage.transform = windDiractionImage.transform.rotated(by: CGFloat(Constant.CompassByPi.e))

            rotatedAngle = Constant.CompassByPi.e

        } else if data.windDiraction.characters.contains("南") {

            windDiractionImage.transform = windDiractionImage.transform.rotated(by: CGFloat(Constant.CompassByPi.s))

            rotatedAngle = Constant.CompassByPi.s

        } else if data.windDiraction.characters.contains("西") {

            windDiractionImage.transform = windDiractionImage.transform.rotated(by: CGFloat(Constant.CompassByPi.w))

            rotatedAngle = Constant.CompassByPi.w

        } else {

            rotatedAngle = 0.0
            return

        }
    }

    func setUpCellView() {

        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        weatherCollectionView.backgroundColor = Constant.ColorCode.oceanBoatBlue

        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 110)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        weatherCollectionView.collectionViewLayout = layout

        let weatherCollectionViewCell = UINib.init(nibName: "WeatherCollectionViewCell", bundle: nil)
        weatherCollectionView.register(weatherCollectionViewCell, forCellWithReuseIdentifier: "WeatherCollectionViewCell")

    }

    //MARK: - CollectionView DataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 24

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        // swiftlint:enable force_cast

        cell.backgroundColor = Constant.ColorCode.oceanBoatBlue

        return cell.setUpCellView(indexPath.row)
    }

    //MARK: - CollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // Force Case: Date from calendar by currentDate always successed.
        let cellMoment = normalCalendar.date(byAdding: .hour, value: indexPath.row, to: currentDate)!

        for weatherData in Constant.wertherDatas {
            
            if cellMoment >= weatherData.startTime && cellMoment <= weatherData.endTime {

                self.setUpInformation(byWeatherData: weatherData)
                dateLabel.text = Date.getTodayDateOfStringAndDate("yyyy-MM-dd", cellMoment)

            }
        }
    }
}
