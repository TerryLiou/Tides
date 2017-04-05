//
//  CategoryCell.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/4.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit

class CetagoryView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    override func awakeFromNib() {

        super.awakeFromNib()

        setUpView()

    }

    let appsCollectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    func setUpView() {

        appsCollectionView.dataSource = self
        appsCollectionView.delegate = self
        addSubview(appsCollectionView)
        appsCollectionView.register(WeatherCell.self, forCellWithReuseIdentifier: "WeatherCell")
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : appsCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : appsCollectionView]))

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 5

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        return collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 110)
    }
}

class WeatherCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpViews() {
        backgroundColor = UIColor.red
    }
}
