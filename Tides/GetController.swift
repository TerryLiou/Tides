//
//  GetController.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/26.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation
import UIKit

enum GetController {

    case controller

    var mapSearch: MapSearchController {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let MapViewCV = storyboard.instantiateViewController(withIdentifier: "MapSearchController") as! MapSearchController

        return MapViewCV
    }

    var calendarView: CalendarViewController {

        let storyboard = UIStoryboard(name: "CalendarViewController", bundle: nil)
        let calendarViewController = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController

        return calendarViewController
    }
}
