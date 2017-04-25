//
//  TidesSearchController.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/3/26.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class TidesSearchTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Property

    @IBOutlet weak var tidesTableView: UITableView!

    var searchController: UISearchController?
    var resultsController = UITableViewController()
    var filteredArea = [String]()
    var filterArea = [String]()
    var isSatelliteMode = false

    // MARK: - View Life Cycle

    override func viewDidLoad() {

        super.viewDidLoad()

        setUpTableView()
        searchBarSetUp()

    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

        return 44.0

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 70

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? TidesSearchTableViewCell else { return }

        Constant.selectedStationNameFromMapView = selectedCell.tidesStationName.text!

        FirebaseDataManager.shared.getTidesData(byDate: Constant.selectedDateFromCalenderView!, stationName: selectedCell.tidesStationName.text!) { (tidesData, tidesDataCount) in

            TidesDataArray.data = tidesData
            TidesDataArray.amountOfData = tidesDataCount

            appDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")

        }
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {

        if tableView === tidesTableView {

            return LocationList().citys.count

        } else {

            return 1
        }

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableView === tidesTableView {

            let cityName = LocationList().citys[section]
            let townAmount = LocationList().towns[cityName]

            return townAmount!.count

        } else {

            return filteredArea.count

        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // swiftlint:disable force_cast
        let cell = tidesTableView.dequeueReusableCell(withIdentifier: "TidesSearchTableViewCell") as! TidesSearchTableViewCell
        // swiftlint:enable force_cast

        if tableView === tidesTableView {

            let cityName = LocationList().citys[indexPath.section]
            let townAmount = LocationList().towns[cityName]
            let townName = cityName + (townAmount?[indexPath.row])!

            cell.tidesStationName.text = townName

        } else {

            cell.tidesStationName.text = filteredArea[indexPath.row]

        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 30

    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if tableView === tidesTableView {

            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 25))

            headerView.backgroundColor = Constant.ColorCode.oceanBoatBlue

            let label = UILabel(frame: CGRect(x: 10, y: 5, width: view.bounds.width, height: 20))

            label.text = LocationList().citys[section]
            label.textColor = UIColor.white

            headerView.addSubview(label)

            return headerView

        } else {

            return nil

        }

    }

    // MARK: - setUpTableView

    func setUpTableView() {

        let tableViewCell = UINib(nibName: "TidesSearchTableViewCell", bundle: nil)
        tidesTableView.register(tableViewCell, forCellReuseIdentifier: "TidesSearchTableViewCell")

    }

    // MARK: - IBAction

    @IBAction func swiftMode(_ sender: UISegmentedControl) {

        switch sender.selectedSegmentIndex {

        case 0:

            tidesTableView.isHidden = false

        default:

            tidesTableView.isHidden = true

        }

        setTabBarVisible(visible: !tabBarIsVisible(), animated: true)

    }

    // MARK: - TabBarHidingAnimated

    func setTabBarVisible(visible: Bool, animated: Bool) {

        // hide tab bar

        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)

        // zero duration means no animation

        let duration: TimeInterval = (animated ? 0.3 : 0.0)

        // animate tabBar

        if frame != nil {

            UIView.animate(withDuration: duration) {

                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
                self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + offsetY!)
                self.view.setNeedsDisplay()
                self.view.layoutIfNeeded()

                return

            }
        }
    }

    func tabBarIsVisible() -> Bool {

        return (self.tabBarController?.tabBar.frame.origin.y)! < UIScreen.main.bounds.height

    }
}

// MARK: - UISearchResults

extension TidesSearchTableViewController: UISearchResultsUpdating {

    func searchBarSetUp() {

        self.resultsController.tableView.delegate = self
        self.resultsController.tableView.dataSource = self

        let tableViewCell = UINib(nibName: "TidesSearchTableViewCell", bundle: nil)
        self.resultsController.tableView.register(tableViewCell, forCellReuseIdentifier: "TidesSearchTableViewCell")
        self.resultsController.tableView.backgroundColor = UIColor.lightGray
        self.searchController = UISearchController(searchResultsController: self.resultsController)
        self.tidesTableView.tableHeaderView = self.searchController?.searchBar
        self.searchController?.searchResultsUpdater = self
        self.searchController?.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true

        for city in LocationList().citys {

            // Force Case: Unrap town name list from dictionary in Contant file alway successed.

            let townName = LocationList().towns[city]!

            for town in townName {

                let title = city + town
                filterArea.append(title)
    
            }
        }
    }

    func updateSearchResults(for searchController: UISearchController) {

        
        filteredArea = filterArea.filter({ (cityName) -> Bool in

            if cityName.contains((self.searchController?.searchBar.text)!) {

                return true

            } else {

                return false

            }
        })

        resultsController.tableView.reloadData()

    }
}
