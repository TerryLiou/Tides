//
//  CalendarViewController.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/23.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation
import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    // MARK: - property
    
    let formatter = DateFormatter()
    let outsideMonthColor = UIColor(colorWithHexvalue: 0x51375c)
    let monthDayColor = UIColor.white
    let selectedMonthColor = UIColor.black
    let currentDaySelectedViewColor = UIColor(colorWithHexvalue: 0x829fff)
    let testcalendar = Calendar.current
    let currentDate = Date()
    var isSelected = false
    var selectedDate: String?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpCalendarView()
        dayInitional()
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        
    }
    
    // Month and year init
    
    func dayInitional() {
        
        let intMonth = testcalendar.component(.month, from: currentDate)
        let thisYear = testcalendar.component(.year, from: currentDate)
        
        if intMonth < 10 {
            
            let thisMonth = "0\(intMonth)"
            monthLabel.text = getChineseMonth(month: thisMonth)
            
        } else {
            
            let thisMonth = String(intMonth)
            monthLabel.text = getChineseMonth(month: thisMonth)
        }
        
        yearLabel.text = String(thisYear)
        
    }
    
    // Got start and end day
    
    func getDate() -> (Date, Date) {
        
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        formatter.dateFormat = "yyyy MM 01"
        
        let startYearMonthDay = formatter.string(from: currentDate)
        
        let startDate = formatter.date(from: startYearMonthDay)
        
        var thisMonth = testcalendar.component(.month, from: currentDate)
        var thisYear = testcalendar.component(.year, from: currentDate)
        
        if thisMonth < 10 {
            
            thisMonth += 1
            
            let endYearMonthDay = String(thisYear) + " 0\(thisMonth) 01"
            let endDate = formatter.date(from: endYearMonthDay)
            
            return (startDate!, endDate!)
            
        } else if thisMonth == 12 {
            
            thisYear += 1
            let endYearMonthDay = String(thisYear) + " 01 01"
            let endDate = formatter.date(from: endYearMonthDay)
            
            return (startDate!, endDate!)
            
            
            
        } else {
            
            thisMonth += 1
            
            let endYearMonthDay = String(thisYear) + String(thisMonth) + " 01"
            let endDate = formatter.date(from: endYearMonthDay)
            
            return (startDate!, endDate!)
            
        }
    }
    
    func setUpCalendarView() {
        
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
    }
    
    // handleCellTextColor
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        
        guard let validCell = view as? CustomCell else { return }
        
        formatter.dateFormat = "yyyy MM dd"
        
        let currentDayString = formatter.string(from: currentDate)
        let cellStateString = formatter.string(from: cellState.date)
        let nextWeek = testcalendar.date(byAdding: .day, value: 6, to: currentDate)
        
        if cellState.isSelected {
            
            validCell.dataLabel.textColor = selectedMonthColor
            
        } else {
            
            if cellState.date > currentDate && cellState.date <= nextWeek! {
                
                validCell.dataLabel.textColor = monthDayColor
                
            } else if cellStateString == currentDayString {
                
                validCell.dataLabel.textColor = currentDaySelectedViewColor
                
            } else {
                
                validCell.dataLabel.textColor = outsideMonthColor
                
            }
        }
        
    }
    
    // Selected View Hided or Showed
    
    func handleCellSelected (view: JTAppleCell?, cellState: CellState) {
        
        guard let validCell = view as? CustomCell else { return }
        
        if validCell.isSelected {
            
            validCell.selectedView.isHidden = false
            
        } else {
            
            validCell.selectedView.isHidden = true
            
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func enterButton(_ sender: Any) {
        
        if isSelected {

            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

            Constant.selectedDateFromCalenderView = selectedDate

            FirebaseDataManager.shared.getTidesData(byDate: Constant.selectedDateFromCalenderView!, stationName: Constant.selectedStationNameFromMapView ) { (tidesData, tidesDataCount) in
                
                TidesDataArray.data = tidesData
                TidesDataArray.amountOfData = tidesDataCount
                
                appDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
                
            self.dismiss(animated: true, completion: nil)

            }
        }
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)

    }
}

// MARK: - JTAppleCalendarViewDataSource

extension CalendarViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        let dates = getDate()
        
        let parameters = ConfigurationParameters(startDate: dates.0, endDate: dates.1)
        
        return parameters
        
    }
    
}

// MARK: - JTAppleCalendarViewDelegate

extension CalendarViewController: JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        let locleToday = testcalendar.date(byAdding: .day, value: -1, to: currentDate)
        let nextWeek = testcalendar.date(byAdding: .day, value: 6, to: currentDate)
        
        cell.dataLabel.text = cellState.text
        
        if cellState.date >= locleToday! && cellState.date <= nextWeek! {
            
            cell.isUserInteractionEnabled = true
            
        } else {
            
            cell.isUserInteractionEnabled = false
            
        }
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        return cell
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        isSelected = true

        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        formatter.dateFormat = "yyyy-MM-dd"
        selectedDate = formatter.string(from: cellState.date)

    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        
        let date = visibleDates.monthDates.first?.date
        
        formatter.dateFormat = "yyyy"
        yearLabel.text = formatter.string(from: date!)
        
        formatter.dateFormat = "MM"
        monthLabel.text = getChineseMonth(month: formatter.string(from: date!))
        
    }
}
