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

    func manager(originTidesData: [TidesData], didgetTidesArray: [[TidesData]], didgetTidesAmount: [Int])

}

class FirebaseDataManager {

    static let shared = FirebaseDataManager()
    weak var delegate: FirebaseManagerDelegate?

    let reference = FIRDatabase.database().reference().child("records")

    func getTidesData(byDate: String, stationID: String, completionHandler: @escaping (_ tidesData: [TidesData], _ tidesDataCount: Int) -> Void) {

        reference.queryOrdered(byChild: Constant.TideProperty.stationID).queryEqual(toValue: stationID).observeSingleEvent(of: .value, with: { snapshot in

            var tidesData = [TidesData]()
            let tidesDataCount: Int?

            for item in snapshot.children {

                guard let snap = item as? FIRDataSnapshot else { return }

                guard let result = self.getData(snapshot: snap) else { return }

                if result.date == byDate {
                    tidesData.append(result)
                }

            }

            tidesData.sort { $0.order < $1.order }
            tidesDataCount = tidesData.count

            completionHandler(tidesData, tidesDataCount!)
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

            let originTidesData = seletedTidesData

            let taipeiTides = seletedTidesData.filter { (TidesData) -> Bool in
                return TidesData.areaID == Constant.Taipei.areaID
            }

            let keelungTides = seletedTidesData.filter { (TidesData) -> Bool in
                return TidesData.areaID == Constant.Keelung.areaID
            }

            let taoyuanTides = seletedTidesData.filter { (TidesData) -> Bool in
                return TidesData.areaID == Constant.Taoyuan.areaID
            }

            let hsinchuTides = seletedTidesData.filter { (TidesData) -> Bool in
                return TidesData.areaID == Constant.Hsinchu.areaID
            }

            let hsinchuCityTides = seletedTidesData.filter { (TidesData) -> Bool in
                return TidesData.areaID == Constant.HsinchuCity.areaID
            }

            let miaoliTides = seletedTidesData.filter { (TidesData) -> Bool in
                return TidesData.areaID == Constant.Miaoli.areaID
            }

            let changhuaTides = seletedTidesData.filter { (TidesData) -> Bool in
                return TidesData.areaID == Constant.Changhua.areaID
            }

            let taichungTides = seletedTidesData.filter { (TidesData) -> Bool in
                return TidesData.areaID == Constant.Taichung.areaID
            }

            let yunlinTides = seletedTidesData.filter { (TidesData) -> Bool in
                return TidesData.areaID == Constant.Yunlin.areaID
            }

//            let chiayiTides = seletedTidesData.filter({ (TidesData) -> Bool in
//                return TidesData.areaID == Constant..areaID
//            })

            let dataAmount = [taipeiTides.count, keelungTides.count, taoyuanTides.count,
                             hsinchuTides.count, hsinchuCityTides.count, miaoliTides.count,
                             changhuaTides.count, taichungTides.count, yunlinTides.count]

            let seletedTidesDataArray = [taipeiTides, keelungTides, taoyuanTides,
                                        hsinchuTides, hsinchuCityTides, miaoliTides,
                                        changhuaTides, taichungTides, yunlinTides]

            self.delegate?.manager(originTidesData: originTidesData, didgetTidesArray: seletedTidesDataArray, didgetTidesAmount: dataAmount)
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
