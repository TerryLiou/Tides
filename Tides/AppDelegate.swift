//
//  AppDelegate.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/3/20.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    override init() {
        FIRApp.configure()
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}
