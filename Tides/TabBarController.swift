//
//  TabBarControllerViewController.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/2.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit

enum TarBarItemTypes: Int {

    case chart, search, weather, moonAge

    var item: UITabBarItem {

        return UITabBarItem(title: title, image: image, selectedImage: rawValue)

    }

    var title: String {

        switch self {

        case .chart:

            return "潮汐資訊"

        case .search:

            return "潮汐查詢"

        case .weather:

            return "天氣資訊"

        case .moonAge:

            return "月齡資訊"

        }
    }

    var image: UIImage {

        switch self {

        case .chart:

            return #imageLiteral(resourceName: "tides").withRenderingMode(.alwaysOriginal)

        case .search:

            return #imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal)

        case .weather:

            return #imageLiteral(resourceName: "weather").withRenderingMode(.alwaysOriginal)

        case .moonAge:

            return #imageLiteral(resourceName: "moon").withRenderingMode(.alwaysOriginal)

        }
    }
}
class TabBarController: UITabBarController {

    override func viewDidLoad() {

        super.viewDidLoad()

        configTabBar()

    }

    func configTabBar() {

        self.tabBar.barTintColor = Constant.ColorCode.greenBlue1

    }
}
