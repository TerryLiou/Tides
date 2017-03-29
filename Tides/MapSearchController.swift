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

    override func viewDidLoad() {

        super.viewDidLoad()
        addAnnotations()

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

    }
}
