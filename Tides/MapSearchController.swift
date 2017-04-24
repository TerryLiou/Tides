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

    // MARK: - Property

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var containerView: UIView!

    let locationManager = CLLocationManager()
    var userCoordinate = CLLocation()
    var tidesForMap = [Annotations]()

    // MARk: - Life Cycle

    override func viewDidLoad() {

        super.viewDidLoad()
        configLocationManager()
        

    }

    override func viewDidDisappear(_ animated: Bool) {

        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()

    }

    // MRRK: - LocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        self.userCoordinate = locations[0]

        if userCoordinate.coordinate.latitude != 0.0 {

            DistanceCalculation.getNearestStation(mapView: mapView, userLocation: userCoordinate.coordinate) { (tidesForMap) in

                self.tidesForMap = tidesForMap
                self.addAnnotations()
                self.locationManager.stopUpdatingLocation()

            }
        }
    }

    // MARK: - configLocationManager

    func configLocationManager() {

        mapView.delegate = self
        locationManager.delegate = self

        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()

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

        for i in 0 ..< tidesForMap.count {

            mapView.addAnnotation(tidesForMap[i])

        }

        mapView.showsUserLocation = true
        mapView.userLocation.title = "我的位置"

    }

    // MARK: - MapViewDelegate

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if annotation is MKUserLocation {

            return nil

        }

        let identifier = "pin"
        var dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if dequeuedView == nil {

            dequeuedView = AnnotationView(annotation: annotation, reuseIdentifier: identifier)
            dequeuedView?.canShowCallout = false

        } else {

            dequeuedView?.annotation = annotation

        }

        dequeuedView?.image = #imageLiteral(resourceName: "location")
        return dequeuedView

    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        if view.annotation is MKUserLocation {

            return

        }

        guard let tideAnnotation = view.annotation as? Annotations else { return }

        let subview = Bundle.main.loadNibNamed("TideAnnotationView", owner: nil, options: nil)
        // swiftlint:disable force_cast
        let calloutView  = subview?[0] as! TideAnnotationView
        // swiftlint:enable force_cast
        calloutView.title.text = tideAnnotation.title
        calloutView.subtitle.text = tideAnnotation.subtitle
        calloutView.distance.text = "距離：\(Int(tideAnnotation.distance/1000)) 公里"
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.6)
        view.addSubview(calloutView)
        DistanceCalculation.getSuitableSpan(mapView: mapView,
                                            userLocation: userCoordinate.coordinate,
                                            targetLocation:  tideAnnotation.coordinate)

        calloutView.infoButton.addTarget(self, action: #selector(didPressInfo), for: .touchUpInside)

    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {

        if view.isKind(of: AnnotationView.self) {

            for subview in view.subviews {

                subview.removeFromSuperview()

            }
        }
    }

    func didPressInfo(_ send: UIButton) {

        guard let superView = send.superview as? TideAnnotationView else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let areaIDIndex = TidesStation.title.index(of: superView.title.text!)!

        Constant.selectedStationNameFromMapView = TidesStation.stationName[areaIDIndex]

        FirebaseDataManager.shared.getTidesData(byDate: Constant.selectedDateFromCalenderView!, stationName: TidesStation.stationName[areaIDIndex]) { (tidesData, tidesDataCount) in

            TidesDataArray.data = tidesData
            TidesDataArray.amountOfData = tidesDataCount

            appDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")

        }
    }

    // MARK: - IBAction

    @IBAction func switchSatelliteMode(_ sender: Any) {

        if mapView.mapType == .standard {

            mapView.mapType = .satellite

        } else {

            mapView.mapType = .standard

        }
    }

    @IBAction func getSuitableSpan(_ sender: Any) {

        DistanceCalculation.getSuitableSpan(mapView: mapView,
                                            userLocation: userCoordinate.coordinate,
                                            targetLocation:  tidesForMap[0].coordinate)

    }

    @IBAction func returnToChart(_ sender: Any) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        appDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")

    }
}
