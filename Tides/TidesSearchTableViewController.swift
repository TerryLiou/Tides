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
    var fileredArea = [TidesData]()
    var originalTidesData = [TidesData]()
    var dataAmount = [Int](repeating: 0, count: TidesDataArray.cityOrder.count)
    var seletedTidesData = [[TidesData]]()
    var isSatelliteMode = false

    // MARK: - View Life Cycle
    override func viewDidLoad() {

        super.viewDidLoad()
        setUpTableView()
        SearchBarSetUp()
        FirebaseDataManager.shared.delegate = self
        FirebaseDataManager.shared.getTidesAmount(byDate: "20170420")

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

        FirebaseDataManager.shared.getStationIDByStationName(byDate: "20170420", stationName: selectedCell.tidesStationName.text!) { stationName in

            Constant.selectedStationIDFromMapView = stationName

            appDelegate.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
        }
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {

        if tableView === tidesTableView {

            return TidesDataArray.cityOrder.count

        } else {

            return 1
        }

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableView === tidesTableView {

            return dataAmount[section]

        } else {

            return fileredArea.count

        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // swiftlint:disable force_cast
        let cell = tidesTableView.dequeueReusableCell(withIdentifier: "TidesSearchTableViewCell") as! TidesSearchTableViewCell
        // swiftlint:enable force_cast

        if tableView === tidesTableView {

            cell.tidesStationName.text = seletedTidesData[indexPath.section][indexPath.row].location

        } else {

            cell.tidesStationName.text = fileredArea[indexPath.row].location

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
            label.text = TidesDataArray.cityOrder[section]
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

// MARK: - FirebaseManagerDelegate

extension TidesSearchTableViewController: FirebaseManagerDelegate {

    func manager(originTidesData: [TidesData], didgetTidesArray: [[TidesData]], didgetTidesAmount: [Int]) {

        originalTidesData = originTidesData
        seletedTidesData = didgetTidesArray
        dataAmount = didgetTidesAmount

        self.tidesTableView.reloadData()

    }
}

// MARK: - UISearchResults

extension TidesSearchTableViewController: UISearchResultsUpdating {

    func SearchBarSetUp() {

        self.resultsController.tableView.delegate = self
        self.resultsController.tableView.dataSource = self

        let tableViewCell = UINib(nibName: "TidesSearchTableViewCell", bundle: nil)
        self.resultsController.tableView.register(tableViewCell, forCellReuseIdentifier: "TidesSearchTableViewCell")
        self.searchController = UISearchController(searchResultsController: self.resultsController)
        self.tidesTableView.tableHeaderView = self.searchController?.searchBar
        self.searchController?.searchResultsUpdater = self
        self.searchController?.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true

    }

    func updateSearchResults(for searchController: UISearchController) {

        fileredArea = originalTidesData.filter({ (TidesData) -> Bool in

            if TidesData.location.contains((self.searchController?.searchBar.text)!) {

                return true

            } else {

                return false

            }
        })

        resultsController.tableView.reloadData()

    }
}
