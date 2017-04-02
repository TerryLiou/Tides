//
//  TabBarControllerViewController.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/2.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {

        super.viewDidLoad()

        configTabBar()

    }

    func configTabBar() {

        self.tabBar.barTintColor = Constant.ColorCode.greenBlue1

    }
}
