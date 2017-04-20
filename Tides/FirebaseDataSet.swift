//
//  FirebaseDataSet.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/3/22.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation
import Firebase

class FirebaseDataManager {

    static let shared = FirebaseDataManager()

    let reference = FIRDatabase.database().reference().child("records")
    let locationRefer = FIRDatabase.database().reference().child("locations")

    func getTidesData(byDate: String, stationName: String, completionHandler: @escaping (_ tidesData: [TidesData], _ tidesDataCount: Int) -> Void) {

        locationRefer.queryOrdered(byChild: "name").queryEqual(toValue: stationName).observeSingleEvent(of: .value, with: { snapshot in

            for child in snapshot.children {
                
                guard let town = child as? FIRDataSnapshot else { return }
                
                self.reference.child(town.key).queryOrdered(byChild: Constant.TideProperty.date).queryEqual(toValue: byDate).observeSingleEvent(of: .value, with: { snapshot in

                    var tidesData = [TidesData]()
                    let tidesDataCount: Int?

                    for item in snapshot.children {

                        guard let snap = item as? FIRDataSnapshot else { return }

                        guard let result = self.getData(snapshot: snap) else { return }

                        tidesData.append(result)

                    }

                    tidesData.sort { $0.order < $1.order }
                    tidesDataCount = tidesData.count

                    completionHandler(tidesData, tidesDataCount!)
                })
            }
        })
    }

    func getStationIDByStationName(byDate: String, stationName: String, completionHandler: @escaping (_ tidesName: String) -> Void) {

        reference.queryOrdered(byChild: Constant.TideProperty.location).queryEqual(toValue: stationName).observeSingleEvent(of: .value, with: { snapshot in

            var tidesData = [TidesData]()

            for item in snapshot.children {

                guard let snap = item as? FIRDataSnapshot else { return }

                guard let result = self.getData(snapshot: snap) else { return }

                if result.date == byDate {

                    tidesData.append(result)

                }
            }

            completionHandler(tidesData[0].stationID)
        })
    }

    func getData(snapshot: FIRDataSnapshot) -> TidesData? {

        guard let snapValue = snapshot.value as? [String: Any] else { return nil }
        guard let date = snapValue[Constant.TideProperty.date] as? String else { return nil }
        guard let height = snapValue[Constant.TideProperty.height] as? Int else { return nil }
        guard let location = snapValue[Constant.TideProperty.location] as? String else { return nil }
        guard let order = snapValue[Constant.TideProperty.order] as? Int else { return nil }
        guard let tide = snapValue[Constant.TideProperty.tide] as? String else { return nil }
        guard let time = snapValue[Constant.TideProperty.time] as? String else { return nil }
        guard let type = snapValue[Constant.TideProperty.type] as? String else { return nil }
        guard let stationID = snapValue[Constant.TideProperty.stationID] as? String else { return nil }
        let index = stationID.index(stationID.startIndex, offsetBy: 4)
        let areaID = stationID.substring(to: index)

        let tidesData = TidesData(date: date, location: location, order: order, time: time, type: type, tide: tide, height: height, stationID: stationID, areaID: areaID)

        return tidesData
    }
}
