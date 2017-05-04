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
    @IBOutlet weak var lineChartView: LineChartView!

    var dataEntriesForLine: [ChartDataEntry] = []
    var xValue = [String]()

    // MARK: - Controller Life Cycle

    override func viewDidLoad() {

        super.viewDidLoad()

        if Reachability.isConnectedToNetwork() != true {

            checkInternet()

        } else {

        self.updateChartWithData()
        navigationSetUp()

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
        
        chartDataSet.colors = [Constant.ColorCode.oceanBoatBlue]
        chartDataSet.setCircleColor(Constant.ColorCode.oceanBoatBlue)
        chartDataSet.circleHoleColor = UIColor.init(colorWithHexvalue: 0x99feff)
        chartDataSet.lineWidth = 3
        chartDataSet.circleRadius = 8
        chartDataSet.circleHoleRadius = 3.5
        chartDataSet.mode = .cubicBezier
        chartDataSet.cubicIntensity = 0.2
        chartDataSet.drawCirclesEnabled = true
        chartDataSet.valueFont = UIFont(name: "Helvetica", size: 15.0)!

        // Axes setup

        lineChartView.xAxis.labelPosition = .bottomInside
        lineChartView.xAxis.labelFont = UIFont(name: "Helvetica", size: 15.0)!
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.chartDescription?.enabled = false

        lineChartView.noDataText = "資料顯示中..."
        lineChartView.noDataFont = UIFont(name: "Helvetica", size: 18.0)!

        lineChartView.legend.enabled = false
        lineChartView.rightAxis.enabled = false

        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawTopYLabelEntryEnabled = true
        lineChartView.leftAxis.labelFont = UIFont(name: "Helvetica", size: 15.0)!

        lineChartView.snapshotView(afterScreenUpdates: false)

        lineChartView.scaleXEnabled = false
        lineChartView.scaleYEnabled = false

        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValue)
        lineChartView.xAxis.granularity = 1.0

        lineChartView.extraRightOffset = 25.0

    }

    func checkInternet() {

        let alertController = UIAlertController(title: "偵測無網路服務",
                                                message: "親愛的用戶，本應用程式必須有網路服務才能正常使用，請開啟網路服務後重新啟動以確保功能正常，按下確定關閉應用程式。",
                                                preferredStyle: .alert)

        let okAction = UIAlertAction(title: "確認", style: .default) { (okAction) in

            exit(0)

        }

        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)

    }

    // MARK: - imformationSetUp

    func imformationSetUp() {

        self.selectedDate.text = TidesDataArray.data[0].date
        self.selectedTide.text = "潮差 － \(TidesDataArray.data[0].type)"
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

        self.navigationItem.rightBarButtonItem = calendarItem

    }

    func showCalendar() {

        let calendarViewController = GetController.controller.calendarView

        calendarViewController.modalPresentationStyle = .overCurrentContext

        self.present(calendarViewController, animated: true, completion: nil)

    }
}
