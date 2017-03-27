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
    let data = "20170330"
    let location = "新北市林口區"
    let tide = "大潮"
    let order = 3
    let time = ["06:17", "12:15", "18:33"]
    let height = [-142, 146, -162]
    let type = ["乾潮", "滿潮", "乾潮"]
    let reference = FIRDatabase.database().reference().child("records")
    let stationID = "500017"
    func setTidesData() {
        for i in 0 ..< order {
            let data = TidesData(date: self.data, location: location, order: i, time: time[i], type: type[i], tide: tide, height: height[i], stationID: stationID)
            let value = ["date": data.date, "location": data.location, "order": data.order,
                         "time": data.time, "type": data.type, "tide": data.tide, "height": data.height, "stationID": data.stationID] as [String : Any]
            reference.childByAutoId().setValue(value) { (error, _) in
                if error != nil {
                    print(error!)
                    return
                }
                print("success")
            }
        }
    }

    func getTidesData(byChild: String, stationID: String, completionHandler: @escaping (_ tidesData: [TidesData]) -> Void) {

        reference.queryOrdered(byChild: byChild).queryStarting(atValue: stationID).observeSingleEvent(of: .value, with: { snapshot in

            var tidesData = [TidesData]()

            for item in snapshot.children {

                guard let snap = item as? FIRDataSnapshot else { return }

                guard let result = self.getData(snapshot: snap) else { return }

                tidesData.append(result)

            }
            tidesData.sort { $0.order < $1.order }

            completionHandler(tidesData)
        })
    }

    func getTidesAmount(stationID: String, completionHandler: @escaping (_ amountOfTides: Int) -> Void) {
        reference.queryOrdered(byChild: "stationID").queryStarting(atValue: stationID).observeSingleEvent(of: .value, with: { snapshot in
            
            var tidesData = [TidesData]()
            
            for item in snapshot.children {
                
                guard let snap = item as? FIRDataSnapshot else { return }
                
                guard let result = self.getData(snapshot: snap) else { return }
                
                tidesData.append(result)
                
            }
            tidesData.sort { $0.order < $1.order }
            
            var count = 0
            for item in tidesData {
                if item.order == 0 {
                    count += 1
                }
            }

            completionHandler(count)
        })
    }
    func getData(snapshot: FIRDataSnapshot) -> TidesData? {

        guard let snapValue = snapshot.value as? [String: Any] else { return nil }
        guard let data = snapValue["date"] as? String else { return nil }
        guard let height = snapValue["height"] as? Int else { return nil }
        guard let location = snapValue["location"] as? String else { return nil }
        guard let order = snapValue["order"] as? Int else { return nil }
        guard let tide = snapValue["tide"] as? String else { return nil }
        guard let time = snapValue["time"] as? String else { return nil }
        guard let type = snapValue["type"] as? String else { return nil }
        guard let stationID = snapValue["stationID"] as? String else { return nil }

        let tidesData = TidesData(date: data, location: location, order: order, time: time, type: type, tide: tide, height: height, stationID: stationID)

        return tidesData
    }
}
