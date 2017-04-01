//
//  TideAnnotationView.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/3/31.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import UIKit

class TideAnnotationView: UIView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var infoButton: UIButton!

    var shadowLayer: CAShapeLayer?
    let info = UIButton()

    override func awakeFromNib() {

        super.awakeFromNib()

        if shadowLayer == nil {

            shadowLayer = CAShapeLayer()
            shadowLayer?.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
            shadowLayer?.fillColor = Constant.ColorCode.greenBlue2.cgColor
            shadowLayer?.shadowColor = UIColor.darkGray.cgColor
            shadowLayer?.shadowPath = shadowLayer?.path
            shadowLayer?.shadowRadius = 5.0
            shadowLayer?.shadowOpacity = 0.8
            shadowLayer?.shadowOffset = CGSize(width: 5, height: 5)
            // swiftlint:disable force_cast
            layer.insertSublayer(shadowLayer!, at: 0)
            // swiftlint:enable force_cast

        }

        backgroundColor = UIColor.init(white: 0, alpha: 0)

        title.font = UIFont(name: "PingFang TC", size: UIFontWeightHeavy.advanced(by: 20))
        title.textColor = UIColor.white
        subtitle.font = UIFont(name: "PingFang TC", size: UIFontWeightThin.advanced(by: 15))
        subtitle.textColor = UIColor.white
        distance.font = UIFont(name: "PingFang TC", size: UIFontWeightThin.advanced(by: 15))
        distance.textColor = UIColor.white

        let infoIcon = #imageLiteral(resourceName: "info").withRenderingMode(.alwaysOriginal)
        infoButton.setImage(infoIcon, for: .normal)

    }
}
