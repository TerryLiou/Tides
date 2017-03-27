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
    let location = "基隆市中正區"
    let tide = "中潮"
    let order = 4
    let time = ["03:54", "10:25", "16:10", "23:26"]
    let height = [-31, 24, -50, 29]
    let type = ["乾潮", "滿潮", "乾潮", "滿潮"]
    let reference = FIRDatabase.database().reference().child("records")
    let stationID = "001701"
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

    func getTidesAmount(stationID: String) {
        reference.queryOrdered(byChild: Constant.TideProperty.stationID).queryStarting(atValue: stationID).observeSingleEvent(of: .value, with: { snapshot in

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
        guard let ID = snapValue[Constant.TideProperty.stationID] as? String else { return nil }
        let index = ID.index(ID.startIndex, offsetBy: 4)
        let stationID = ID.substring(to: index)

        let tidesData = TidesData(date: data, location: location, order: order, time: time, type: type, tide: tide, height: height, stationID: stationID)

        return tidesData
    }
}
