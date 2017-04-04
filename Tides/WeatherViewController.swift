//
//  WeatherViewController.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/4.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var weatherScrollView: UIScrollView!
    var wheatherView = Array(repeating: WeatherView(), count: 24)

    override func viewDidLoad() {

        super.viewDidLoad()
        configScrollView()

    }

    func configScrollView (){

        for i in 0..<wheatherView.count {

            let xPosition = wheatherView[0].frame.width * CGFloat(i)
            wheatherView[i].frame = CGRect(x: xPosition,
                                           y: 0,
                                           width: wheatherView[0].frame.width,
                                           height: wheatherView[0].frame.height)
            weatherScrollView.contentSize.width = wheatherView[0].frame.width * CGFloat(i + 1)
            weatherScrollView.addSubview(wheatherView[i])
        }
    }
}
