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
    let yValue = [23, -31, 45, -69]
    let xValue = [00:20, 06:00, 12:00, 18:00]
    override func viewDidLoad() {
        super.viewDidLoad()
        updateChartWithData()
    }
    func updateChartWithData() {
        lineChartView.delegate = self
        for i in 0 ... 3 {
            let dataEntryForLine = ChartDataEntry(x: Double(i), y: Double(yValue[i]))
            dataEntriesForLine.append(dataEntryForLine)
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
        
        var dateComponentsFormatter: DateComponentsFormatter {
            let dateComponentsFormatter = DateComponentsFormatter()
            dateComponentsFormatter.allowedUnits = [.hour,.minute]
            dateComponentsFormatter.collapsesLargestUnit = true
            dateComponentsFormatter.zeroFormattingBehavior = .pad
            return dateComponentsFormatter
        }
        let xAxis: XAxis = XAxis()
    }

    @IBOutlet weak var lineChartView: LineChartView!
}
