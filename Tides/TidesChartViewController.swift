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

    // MARK: - Property

    @IBOutlet weak var timeOfwet: UILabel!
    @IBOutlet weak var timeOfdry: UILabel!
    @IBOutlet weak var selectedDate: UILabel!
    @IBOutlet weak var selectedTide: UILabel!
    var dataEntriesForLine: [ChartDataEntry] = []
    var xValue = [String]()
    var stationID: String {

        if Constant.selectedStationIDFromMapView == nil {

            return "500012"

        } else {

            return Constant.selectedStationIDFromMapView!

        }
    }

    // MARK: - Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        FirebaseDataManager.shared.setTidesData()
        navigationSetUp()
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "paperBackground"))

        FirebaseDataManager.shared.getTidesData(byDate: "20170330", stationID: stationID) { (tidesData, tidesDataCount) in
            TidesDataArray.data = tidesData
            TidesDataArray.amountOfData = tidesDataCount
            self.updateChartWithData()
            self.imformationSetUp()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    // MARK: - updateChartWithData

    func updateChartWithData() {

        lineChartView.delegate = self

        for data in TidesDataArray.data {
            let yValue = data.height
            let dataEntryForLine = ChartDataEntry(x: Double(data.order), y: Double(yValue))
            dataEntriesForLine.append(dataEntryForLine)
            xValue.append(data.time)
        }

        let chartDataSet = LineChartDataSet(values: dataEntriesForLine, label: nil)
        let chartData = LineChartData(dataSet: chartDataSet)
        lineChartView.data = chartData
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        chartData.setDrawValues(true)
        chartData.value
        chartDataSet.colors = [UIColor.brown]
        chartDataSet.setCircleColor(UIColor.blue)
        chartDataSet.circleHoleColor = UIColor.clear
        chartDataSet.lineWidth = 2
        chartDataSet.circleRadius = 4.5
        chartDataSet.circleHoleRadius = 3.5
        chartDataSet.mode = .cubicBezier
        chartDataSet.cubicIntensity = 0.2
        chartDataSet.drawCirclesEnabled = true
        chartDataSet.valueFont = UIFont(name: "Helvetica", size: 12.0)!

        // Axes setup
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.chartDescription?.enabled = false
        lineChartView.legend.enabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawTopYLabelEntryEnabled = true
        lineChartView.snapshotView(afterScreenUpdates: false)
        lineChartView.scaleXEnabled = false
        lineChartView.scaleYEnabled = false
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValue)
        lineChartView.extraRightOffset = 25.0
        lineChartView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "paperBackground"))

    }

    // MARK: - imformationSetUp

    func imformationSetUp() {

        let date = TidesDataArray.data[0].date
        let index = date.index(date.startIndex, offsetBy: 4)
        let year = date.substring(to: index)
        let start = date.index(date.startIndex, offsetBy: 4)
        let end = date.index(date.startIndex, offsetBy: 6)
        let range = Range(uncheckedBounds: (lower: start, upper: end))
        let month = date.substring(with: range)
        let ind = date.index(date.startIndex, offsetBy: 6)
        let day = date.substring(from: ind)
        self.selectedDate.text = "\(year)-\(month)-\(day)"
        self.selectedTide.text = "潮差 － \(TidesDataArray.data[0].tide)"
        self.navigationItem.title = TidesDataArray.data[0].location
        var highTideTime = ""
        var lowTideTime = ""

        switch TidesDataArray.amountOfData {

        case 2:
            if TidesDataArray.data[0].height < 0 {
                highTideTime = TidesDataArray.data[1].time
                lowTideTime = TidesDataArray.data[0].time
            } else {
                highTideTime = TidesDataArray.data[0].time
                lowTideTime = TidesDataArray.data[1].time
            }

        case 3:
            if TidesDataArray.data[0].height < 0 {
                highTideTime = TidesDataArray.data[1].time
                lowTideTime = TidesDataArray.data[0].time + "\n" + TidesDataArray.data[2].time
            } else {
                highTideTime = TidesDataArray.data[0].time + "\n" + TidesDataArray.data[2].time
                lowTideTime = TidesDataArray.data[1].time
            }

        case 4:
            if TidesDataArray.data[0].height < 0 {
                highTideTime = TidesDataArray.data[1].time + "\n" + TidesDataArray.data[3].time
                lowTideTime = TidesDataArray.data[0].time + "\n" + TidesDataArray.data[2].time
            } else {
                highTideTime = TidesDataArray.data[0].time + "\n" + TidesDataArray.data[2].time
                lowTideTime = TidesDataArray.data[1].time + "\n" + TidesDataArray.data[3].time
            }

        default:
            break
        }

        timeOfdry.text = lowTideTime
        timeOfwet.text = highTideTime

    }

    // MARK: - navigationSetUp

    func navigationSetUp() {

        let calendarImage = #imageLiteral(resourceName: "calendar").withRenderingMode(.alwaysOriginal)
        let calendarItem = UIBarButtonItem(image: calendarImage, style: .plain, target: self, action: #selector(self.showCalendar))
        let navigationTitleFont: UIFont = UIFont(name: "PingFang TC", size: UIFontWeightHeavy.advanced(by: 18))!
        self.navigationItem.rightBarButtonItem = calendarItem
        self.navigationController?.navigationBar.barTintColor = Constant.ColorCode.oceanBoatBlue
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navigationTitleFont, NSForegroundColorAttributeName: UIColor.white]
    }
    func showCalendar() {
        guard let xibView = Bundle.main.loadNibNamed("CalendarPopUp", owner: nil, options: nil)?[0] as? CalendarPopUp else { return }
//        xibView.calendarDelegate = self
//        xibView.selected = currentDate
        PopupContainer.generatePopupWithView(xibView).show()
    }
    @IBOutlet weak var lineChartView: LineChartView!
}
