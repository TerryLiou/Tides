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
    var dataEntriesForLine: [ChartDataEntry] = []
    var amountOfData = tidesDataArray.data.count
    var xValue = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateChartWithData()

        FirebaseDataManager.shared.getTidesData { (tidesData) in
            tidesDataArray.data = tidesData
        }

    }
    func updateChartWithData() {
        lineChartView.delegate = self
        for i in 0 ..< amountOfData {

            let yValue = tidesDataArray.data[i].height
            let dataEntryForLine = ChartDataEntry(x: Double(i), y: Double(yValue))
            dataEntriesForLine.append(dataEntryForLine)
            xValue.append(tidesDataArray.data[i].time)

        }
        let chartDataSet = LineChartDataSet(values: dataEntriesForLine, label: "Int")
        let chartData = LineChartData(dataSet: chartDataSet)
        lineChartView.data = chartData
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        chartData.setDrawValues(true)
        chartDataSet.colors = [UIColor.blue]
        chartDataSet.setCircleColor(UIColor.blue)
        chartDataSet.circleHoleColor = UIColor.blue
        chartDataSet.circleRadius = 4.0
        chartDataSet.mode = .cubicBezier
        chartDataSet.cubicIntensity = 0.2
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.valueFont = UIFont(name: "Helvetica", size: 12.0)!
        // Gradient fill
        let gradientColors = [UIColor.blue.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else { return }
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        chartDataSet.drawFilledEnabled = true
        // Axes setup
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.chartDescription?.enabled = false
        lineChartView.legend.enabled = true
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawTopYLabelEntryEnabled = true
        lineChartView.snapshotView(afterScreenUpdates: false)
        lineChartView.scaleXEnabled = false
        lineChartView.scaleYEnabled = false
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValue)

    }

    @IBOutlet weak var lineChartView: LineChartView!
}
