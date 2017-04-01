//
//  AnnotationMobel.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/3/29.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation
import MapKit

class Annotations: NSObject, MKAnnotation {

    let title: String?
    let subtitle: String?
    var cllocation: CLLocation
    let coordinate: CLLocationCoordinate2D
    var distance: CLLocationDistance

    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, distance: CLLocationDistance) {

        self.title = title
        self.subtitle = subtitle
        self.cllocation = CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
        self.coordinate = coordinate
        self.distance = distance

    }
}

struct TidesStation {
    static let title = ["基隆", "麟鼻山", "淡水", "臺北港", "竹圍", "新竹", "外埔", "臺中港", "箔子寮", "澎湖", "塭港", "東石", "將軍", "高雄", "東港", "小琉球", "後壁湖", "龍洞", "福隆", "烏石", "蘇澳", "花蓮", "成功", "蘭嶼", "馬祖"]

    static let subtitle = ["基隆港西33號碼頭", "麟山鼻漁港", "淡水河油車口", "臺北港第3港埠", "桃園竹圍漁港", "新竹南寮漁港", "外埔漁港", "臺中港4號碼頭", "箔子寮漁港", "澎湖馬公港", "嘉義塭港漁港", "嘉義東石港", "台南將軍漁港", "高雄港10號碼頭", "屏東東港漁港", "屏東琉球漁港", "後壁湖漁港", "南口遊艇港", "福隆漁港碼頭", "宜蘭烏石港", "蘇澳港內碼頭", "花蓮港內", "臺東成功漁港", "蘭嶼開元漁港", "福澳港"]

    static let coordinate = [CLLocationCoordinate2DMake(25.155, 121.755), CLLocationCoordinate2DMake(25.284, 121.644),
                             CLLocationCoordinate2DMake(25.176, 121.425), CLLocationCoordinate2DMake(25.155, 121.393),
                             CLLocationCoordinate2DMake(25.118, 121.244), CLLocationCoordinate2DMake(24.849, 120.921),
                             CLLocationCoordinate2DMake(24.651, 120.771), CLLocationCoordinate2DMake(24.288, 120.533),
                             CLLocationCoordinate2DMake(23.619, 120.138), CLLocationCoordinate2DMake(23.562, 119.578),
                             CLLocationCoordinate2DMake(23.467, 120.123), CLLocationCoordinate2DMake(23.450, 120.139),
                             CLLocationCoordinate2DMake(23.213, 120.083), CLLocationCoordinate2DMake(22.616, 120.280),
                             CLLocationCoordinate2DMake(22.465, 120.428), CLLocationCoordinate2DMake(22.354, 120.381),
                             CLLocationCoordinate2DMake(21.946, 120.745), CLLocationCoordinate2DMake(25.098, 121.918),
                             CLLocationCoordinate2DMake(25.021, 121.950), CLLocationCoordinate2DMake(24.867, 121.838),
                             CLLocationCoordinate2DMake(24.586, 121.869), CLLocationCoordinate2DMake(23.981, 121.624),
                             CLLocationCoordinate2DMake(23.097, 121.380), CLLocationCoordinate2DMake(22.058, 121.507),
                             CLLocationCoordinate2DMake(26.162, 119.943)]

}

class AnnotationView: MKAnnotationView {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if (hitView != nil) {
            self.superview?.bringSubview(toFront: self)
        }
        return hitView
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = self.bounds
        var isInside: Bool = rect.contains(point)
        if(!isInside) {
            for view in self.subviews {
                isInside = view.frame.contains(point)
                if isInside {
                    break
                }
            }
        }
        return isInside
    }
}
