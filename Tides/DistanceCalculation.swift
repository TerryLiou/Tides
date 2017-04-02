//
//  DistanceCalculation.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/3/30.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation
import MapKit

struct DistanceCalculation {

    static func getNearestStation(mapView: MKMapView,
                                  userLocation: CLLocationCoordinate2D,
                                  completionHandler: @escaping (_ distanceArray: [Annotations]) -> Void) {

        var distanceArray = [Annotations]()
        let user = CLLocation.init(latitude: userLocation.latitude, longitude: userLocation.longitude)

        for i in 0 ..< TidesStation.coordinate.count {

            let targetStation = CLLocation.init(latitude: TidesStation.coordinate[i].latitude,
                                                longitude: TidesStation.coordinate[i].longitude)

            let distance = targetStation.distance(from: user)
            let tideForMap = Annotations.init(title: TidesStation.title[i],
                                              subtitle: TidesStation.subtitle[i],
                                              coordinate: TidesStation.coordinate[i],
                                              distance: distance,
                                              stationID: TidesStation.stationID[i])
            distanceArray.append(tideForMap)

        }

        distanceArray.sort {($0.distance < $1.distance)}

        let centerLocation = CLLocationCoordinate2DMake((userLocation.latitude + distanceArray[0].coordinate.latitude)/2, (userLocation.longitude + distanceArray[0].coordinate.longitude)/2)

        let span = MKCoordinateSpanMake(abs(userLocation.latitude - distanceArray[0].coordinate.latitude) * 2.0,
                                        abs(userLocation.longitude - distanceArray[0].coordinate.longitude) * 2.0)

        let region = MKCoordinateRegion(center: centerLocation, span: span)

        mapView.setRegion(region, animated: true)

        completionHandler (distanceArray)
    }

    static func getSuitableSpan(mapView: MKMapView,
                                userLocation: CLLocationCoordinate2D,
                                targetLocation: CLLocationCoordinate2D) {

        let centerLocation = CLLocationCoordinate2DMake((userLocation.latitude + targetLocation.latitude)/2,
                                                        (userLocation.longitude + targetLocation.longitude)/2)

        let span = MKCoordinateSpanMake(abs(userLocation.latitude - targetLocation.latitude) * 2.0,
                                        abs(userLocation.longitude - targetLocation.longitude) * 2.0)

        let region = MKCoordinateRegion(center: centerLocation, span: span)

        mapView.setRegion(region, animated: true)

    }
}
