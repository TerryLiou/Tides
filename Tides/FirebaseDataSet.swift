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
    let location = "宜蘭蘇澳鎮"
    let tide = "大潮"
    let order = 4
    let time = ["01:20", "07:25", "13:48", "20:03"]
    let height = [-65, 58, -83, 54]
    let type = ["乾潮", "滿潮", "乾潮", "滿潮"]
    let reference = FIRDatabase.database().reference().child("records")
    func setTidesData() {
        for i in 0 ..< order {
            let data = TidesData(date: self.data, location: location, order: i, time: time[i], type: type[i], tide: tide, height: height[i])
            let value = ["date": data.date, "location": data.location, "order": data.order,
                         "time": data.time, "type": data.type, "tide": data.tide, "height": data.height] as [String : Any]
            reference.childByAutoId().setValue(value) { (error, _) in
                if error != nil {
                    print(error!)
                    return
                }
                print("success")
            }
        }
    }
    func getTidesData() {
//        reference.
    }
}
