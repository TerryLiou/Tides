//
//  WeatherViewController.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/4.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var weatherCollectionView: UICollectionView!

    let layout = UICollectionViewFlowLayout()

    override func viewDidLoad() {

        super.viewDidLoad()
        setUpView()

    }

    func setUpView() {

        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        weatherCollectionView.backgroundColor = UIColor.white
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 110)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        weatherCollectionView.collectionViewLayout = layout
        let weatherCollectionViewCell = UINib.init(nibName: "WeatherCollectionViewCell", bundle: nil)
        weatherCollectionView.register(weatherCollectionViewCell, forCellWithReuseIdentifier: "WeatherCollectionViewCell")

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 24

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        // swiftlint:enable force_cast
        cell.weatherImage.image = #imageLiteral(resourceName: "cloud")
        cell.backgroundColor = UIColor.white

        return cell
    }

}
