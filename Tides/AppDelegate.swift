//
//  AppDelegate.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/3/20.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit
import Firebase
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let formatter = DateFormatter()

    let currentDate = Date()

    override init() {

        FIRApp.configure()

    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        setUpAppInitionalData()

        Fabric.with([Crashlytics.self])

        return true

    }

    func setUpAppInitionalData() {

        let vc = UIViewController()

        let lunchImageView = UIImageView(frame: vc.view.bounds)

        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)

        let chartVC = storyBoard.instantiateViewController(withIdentifier: "TabBarController")

        formatter.dateFormat = "yyyy-MM-dd"

        let today = formatter.string(from: currentDate)
        
        Constant.selectedDateFromCalenderView = today

        lunchImageView.contentMode = .scaleAspectFill

        lunchImageView.image = #imageLiteral(resourceName: "tidesBackgroud")
        
        vc.view.addSubview(lunchImageView)

        window?.rootViewController = vc

        if Reachability.isConnectedToNetwork() == true {

            FirebaseDataManager.shared.getTidesData(byDate: Constant.selectedDateFromCalenderView, stationName: Constant.selectedStationNameFromMapView) { (tidesData, tidesDataCount) in
            
                TidesDataArray.data = tidesData
                TidesDataArray.amountOfData = tidesDataCount
            
                guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
                delegate.window?.rootViewController = chartVC
            
            }
        
            WeatherDataCatcher.shared.getWeatherFromAPI { (weatherDatas) in
            
                Constant.wertherDatas = weatherDatas
            
                Constant.initWertherData = weatherDatas[0]
            
            }

            // get chinese Month situation
            DateManager.shared.getFirstDay()

        } else {

            guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            delegate.window?.rootViewController = chartVC

        }
    }
}
