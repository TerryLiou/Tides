//
//  MapSearchController.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/3/29.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation
import MapKit

class MapSearchController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()



    override func viewDidLoad() {

        super.viewDidLoad()
        addAnnotations()
        configLocationManager()

    }

    override func viewDidDisappear(_ animated: Bool) {

        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()
        
    }

    func configLocationManager() {
    
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer

        if CLLocationManager.authorizationStatus() == .notDetermined {

            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()

        } else if CLLocationManager.authorizationStatus() == .denied {

            let alertController = UIAlertController(title: "定位權限已關閉",
                                                    message: "如果要變更權限，請至設定 > 隱私權 > 定位服務 開啟",
                                                    preferredStyle: .alert)

            let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)

            alertController.addAction(okAction)

            self.present(alertController, animated: true, completion: nil)

        } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {

            locationManager.startUpdatingLocation()

        }
        locationManager.distanceFilter = CLLocationDistance(10)
    }






    func addAnnotations() {

        var annotations = [Annotation]()

        for i in 0 ..< TidesStation.coordinate.count {

            let stationLocationPin = Annotation.init(title: TidesStation.title[i],
                                                     subtitle: TidesStation.subtitle[i],
                                                     coordinate: TidesStation.coordinate[i])

            annotations.append(stationLocationPin)

        }

        mapView.addAnnotations(annotations)
        mapView.showsUserLocation = true
    }
}
