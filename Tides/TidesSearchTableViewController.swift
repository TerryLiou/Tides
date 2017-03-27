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

    var dataAmount: Int?
    var seletedTidesData = [TidesData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        FirebaseDataManager.shared.delegate = self
        FirebaseDataManager.shared.getTidesAmount(stationID: "5000")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataAmount ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tidesTableView.dequeueReusableCell(withIdentifier: "TidesSearchTableViewCell", for: indexPath) as? TidesSearchTableViewCell
        cell?.tidesStationName.text = seletedTidesData[indexPath.row].location
        return cell!
    }
    func setUpTableView() {
        let tableViewCell = UINib(nibName: "TidesSearchTableViewCell", bundle: nil)
        tidesTableView.register(tableViewCell, forCellReuseIdentifier: "TidesSearchTableViewCell")
    }
}

extension TidesSearchTableViewController: FirebaseManagerDelegate {
    func manager(didget: [TidesData]) {

        self.dataAmount = didget.count
        self.seletedTidesData = didget
        self.tidesTableView.reloadData()

    }
}
