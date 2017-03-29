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

    func getNearestStation(userLocation: CLLocationCoordinate2D, completionHandler: (_ desendingStation: [TidesForMap])->()) {

        var distanceArray = [TidesForMap]()
        let user = CLLocation.init(latitude: userLocation.latitude, longitude: userLocation.longitude)

        for i in 0 ..< TidesStation.coordinate.count {

            let targetStation = CLLocation.init(latitude: TidesStation.coordinate[i].latitude,
                                                longitude: TidesStation.coordinate[i].longitude)

            let distance = targetStation.distance(from: user)
            let tideForMap = TidesForMap.init(title: TidesStation.title[i],
                                              subtitle: TidesStation.subtitle[i],
                                              coordinate: TidesStation.coordinate[i],
                                              distance: distance)
            distanceArray.append(tideForMap)

        }

        distanceArray.sort {($0.distance < $1.distance)}
        
        completionHandler (distanceArray)

    }
}
