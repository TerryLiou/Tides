//
//  FirebaseDataSet.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/3/22.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation
import Firebase

protocol FirebaseManagerDelegate: class {
    func manager(didget: [TidesData])
}

class FirebaseDataManager {
    static let shared = FirebaseDataManager()
    weak var delegate: FirebaseManagerDelegate?
    let data = "20170330"
    let location = "雲林縣口湖鄉"
    let tide = "大潮"
    let order = 4
    let time = ["00:13", "06:34", "12:27", "19:00"]
    let height = [112, -97, 109, -115]
    let type = ["滿潮", "乾潮", "滿潮", "乾潮"]
    let reference = FIRDatabase.database().reference().child("records")
    let stationID = "000919"
    func setTidesData() {
        for i in 0 ..< order {
            let data = TidesDataFirebase(date: self.data, location: location, order: i, time: time[i], type: type[i], tide: tide, height: height[i], stationID: stationID)
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

    func getTidesData(byDate: String, stationID: String, completionHandler: @escaping (_ tidesData: [TidesData]) -> Void) {

        reference.queryOrdered(byChild: Constant.TideProperty.stationID).queryEqual(toValue: stationID).observeSingleEvent(of: .value, with: { snapshot in

            var tidesData = [TidesData]()

            for item in snapshot.children {

                guard let snap = item as? FIRDataSnapshot else { return }

                guard let result = self.getData(snapshot: snap) else { return }

                if result.date == byDate {
                    tidesData.append(result)
                }

            }
            tidesData.sort { $0.order < $1.order }

            completionHandler(tidesData)
        })
    }

    func getTidesAmount(byDate: String) {
        reference.queryOrdered(byChild: Constant.TideProperty.date).queryEqual(toValue: byDate).observeSingleEvent(of: .value, with: { snapshot in

            var tidesData = [TidesData]()

            for item in snapshot.children {

                guard let snap = item as? FIRDataSnapshot else { return }

                guard let result = self.getData(snapshot: snap) else { return }

                tidesData.append(result)

            }

            var seletedTidesData = [TidesData]()
            for item in tidesData {
                if item.order == 0 {
                    seletedTidesData.append(item)
                }
            }
            self.delegate?.manager(didget: seletedTidesData)
        })
    }
    func getData(snapshot: FIRDataSnapshot) -> TidesData? {

        guard let snapValue = snapshot.value as? [String: Any] else { return nil }
        guard let data = snapValue[Constant.TideProperty.date] as? String else { return nil }
        guard let height = snapValue[Constant.TideProperty.height] as? Int else { return nil }
        guard let location = snapValue[Constant.TideProperty.location] as? String else { return nil }
        guard let order = snapValue[Constant.TideProperty.order] as? Int else { return nil }
        guard let tide = snapValue[Constant.TideProperty.tide] as? String else { return nil }
        guard let time = snapValue[Constant.TideProperty.time] as? String else { return nil }
        guard let type = snapValue[Constant.TideProperty.type] as? String else { return nil }
        guard let stationID = snapValue[Constant.TideProperty.stationID] as? String else { return nil }
        let index = stationID.index(stationID.startIndex, offsetBy: 4)
        let areaID = stationID.substring(to: index)

        let tidesData = TidesData(date: data, location: location, order: order, time: time, type: type, tide: tide, height: height, stationID: stationID, areaID: areaID)

        return tidesData
    }
}
