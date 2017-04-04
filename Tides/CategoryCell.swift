//
//  CategoryCell.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/4.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit

class CetagoryView: UIView {

    override func awakeFromNib() {

        super.awakeFromNib()

        setUpView()

    }

    let appsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    func setUpView() {

        addSubview(appsCollectionView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : appsCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : appsCollectionView]))

    }
}
