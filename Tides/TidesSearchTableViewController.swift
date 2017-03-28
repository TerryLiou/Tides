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
    @IBOutlet weak var tidesTableView: UITableView!

    var dataAmount = [Int](repeating: 0, count: TidesDataArray.cityOrder.count)
    var seletedTidesData = [[TidesData]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        FirebaseDataManager.shared.delegate = self
        FirebaseDataManager.shared.getTidesAmount(byDate: "20170330")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return TidesDataArray.cityOrder.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dataAmount[section]

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tidesTableView.dequeueReusableCell(withIdentifier: "TidesSearchTableViewCell", for: indexPath) as? TidesSearchTableViewCell

            cell?.tidesStationName.text = seletedTidesData[indexPath.section][indexPath.row].location

        return cell!
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

            return TidesDataArray.cityOrder[section]

    }

    // MARK: - setUpTableView
    func setUpTableView() {
        let tableViewCell = UINib(nibName: "TidesSearchTableViewCell", bundle: nil)
        tidesTableView.register(tableViewCell, forCellReuseIdentifier: "TidesSearchTableViewCell")
    }
}

extension TidesSearchTableViewController: FirebaseManagerDelegate {
    func manager(didget: [TidesData]) {
        let taipeiTides = didget.filter { (TidesData) -> Bool in
            return TidesData.areaID == Constant.Taipei.areaID
        }

        let keelungTides = didget.filter { (TidesData) -> Bool in
            return TidesData.areaID == Constant.Keelung.areaID
        }

        let taoyuanTides = didget.filter { (TidesData) -> Bool in
            return TidesData.areaID == Constant.Taoyuan.areaID
        }

        let hsinchuTides = didget.filter { (TidesData) -> Bool in
            return TidesData.areaID == Constant.Hsinchu.areaID
        }

        let hsinchuCityTides = didget.filter { (TidesData) -> Bool in
            return TidesData.areaID == Constant.HsinchuCity.areaID
        }

        let miaoliTides = didget.filter { (TidesData) -> Bool in
            return TidesData.areaID == Constant.Miaoli.areaID
        }

        let changhuaTides = didget.filter { (TidesData) -> Bool in
            return TidesData.areaID == Constant.Changhua.areaID
        }

        let taichungTides = didget.filter { (TidesData) -> Bool in
            return TidesData.areaID == Constant.Taichung.areaID
        }

        let yunlinTides = didget.filter { (TidesData) -> Bool in
            return TidesData.areaID == Constant.Yunlin.areaID
        }

        self.dataAmount = [taipeiTides.count, keelungTides.count, taoyuanTides.count,
                           hsinchuTides.count, hsinchuCityTides.count, miaoliTides.count,
                           changhuaTides.count, taichungTides.count, yunlinTides.count]
        self.seletedTidesData = [taipeiTides, keelungTides, taoyuanTides, hsinchuTides, hsinchuCityTides,
                                 miaoliTides, changhuaTides, taichungTides, yunlinTides]
        self.tidesTableView.reloadData()

    }
}
