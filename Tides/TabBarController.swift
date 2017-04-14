//
//  TabBarControllerViewController.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/2.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit

enum TabBarItemTypes: Int {

    case chart, search, weather, moonAge

    var item: UITabBarItem {

        return UITabBarItem(title: title, image: image, tag: rawValue)

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

    let tabbarItemTypes: [TabBarItemTypes] = [.chart, .search, .weather, .moonAge]

    override func viewDidLoad() {

        super.viewDidLoad()

        configTabBar()

    }

    func configTabBar() {

        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.white
        tabBar.barTintColor = Constant.ColorCode.greenBlue1
        tabBar.items?.forEach { item in

            let itemType = TabBarItemTypes(rawValue: item.tag)!

            item.title = itemType.title
            item.image = itemType.image

        }
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        if item.tag == 3 {

            tabBar.barTintColor? = .clear
            tabBar.backgroundImage = UIImage()
            tabBar.isTranslucent = true

        } else {

            tabBar.backgroundImage = nil
            tabBar.barTintColor = Constant.ColorCode.greenBlue1

        }
    }
}
