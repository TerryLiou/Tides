//
//  NavigationViewController.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/14.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }

    func setUp() {

        let navigationTitleFont: UIFont = UIFont(name: "PingFang TC", size: UIFontWeightHeavy.advanced(by: 18))!
        navigationBar.barTintColor = Constant.ColorCode.oceanBoatBlue
        navigationBar.titleTextAttributes = [NSFontAttributeName: navigationTitleFont, NSForegroundColorAttributeName: UIColor.white]

    }
}
