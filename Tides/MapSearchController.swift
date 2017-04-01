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

        let userCoordinate = locations[0]

        if userCoordinate.coordinate.latitude != 0.0 {

            DistanceCalculation().getNearestStation(mapView: mapView, userLocation: userCoordinate.coordinate) { (tidesForMap) in

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
            mapView.selectAnnotation(tidesForMap[i], animated: true)

        }

        mapView.showsUserLocation = true
        mapView.userLocation.title = "我的位置"
    }

    // MARK: - MapViewDelegate

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if let annotation = annotation as? Annotations {

            let identifier = "pin"
            var view: MKPinAnnotationView

            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {

                dequeuedView.annotation = annotation
                view = dequeuedView

            } else {

                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = false
//                view.calloutOffset = CGPoint(x: -5, y: 5)
//                view.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure) as UIView
//                let button = UIButton.init(type: .detailDisclosure)
//                view.rightCalloutAccessoryView = button

            }
            return view
        }
        return nil
    }

//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//
//        print("test")
//
//    }

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
        calloutView.distance.text = "\(tideAnnotation.distance)"
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)

    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self) {
            for subview in view.subviews {
                subview.removeFromSuperview()
            }
        }
    }
}
