//
//  TidesChartViewController.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/3/21.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation
import UIKit
import Charts

class TidesChartViewController: UIViewController, ChartViewDelegate {
    var dataEntries: [BarChartDataEntry] = []
    var dataEntriesForLine: [ChartDataEntry] = []
    let yValue = [ 1 ,10 ,2 ,15 ,5 ,17 ,7 ,10 ,1 ,10 ]
    override func viewDidLoad() {
        super.viewDidLoad()
        updateChartWithData()
    }
    func updateChartWithData() {
        lineChartView.delegate = self
        for i in 0 ... 9 {
//            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(yValue[i]))
            let dataEntryForLine = ChartDataEntry(x: Double(i), y: Double(yValue[i]))
//            dataEntries.append(dataEntry)
            dataEntriesForLine.append(dataEntryForLine)
        }
//        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Visitor count")
        let chartDataSet = LineChartDataSet(values: dataEntriesForLine, label: "Int")
//        let chartData = BarChartData(dataSet: chartDataSet)
        let chartData = LineChartData(dataSet: chartDataSet)
        lineChartView.data = chartData
    }
    @IBOutlet weak var lineChartView: LineChartView!
}
