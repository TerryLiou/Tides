//
//  AppDelegate.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/3/20.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let formatter = DateFormatter()
    let currentDate = Date()

    override init() {

        FIRApp.configure()

    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let vc = UIViewController()
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let chartVC = storyBoard.instantiateViewController(withIdentifier: "TabBarController")

        formatter.dateFormat = "yyyy-MM-dd"
        
        let today = formatter.string(from: currentDate)
        
        Constant.selectedDateFromCalenderView = today

        vc.view.backgroundColor = UIColor.orange

        window?.rootViewController = vc

        FirebaseDataManager.shared.getTidesData(byDate: Constant.selectedDateFromCalenderView!, stationName: Constant.selectedStationNameFromMapView) { (tidesData, tidesDataCount) in

            TidesDataArray.data = tidesData
            TidesDataArray.amountOfData = tidesDataCount

            guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }

            delegate.window?.rootViewController = chartVC

        }

        WeatherDataCatcher.shared.getWeatherFromAPI { (weatherDatas) in

            Constant.wertherDatas = weatherDatas

            Constant.initWertherData = weatherDatas[0]

        }

        return true

    }
}
