//
//  MoonAgeController.swift
//  Tides
//
//  Created by 劉洧熏 on 2017/4/13.
//  Copyright © 2017年 劉洧熏. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import SceneKit

class MoonAgeController: UIViewController {

    // MARK: - Property

    @IBOutlet weak var lunarView: SCNView!
    @IBOutlet weak var moonPhaseCollection: UICollectionView!

    let lunarScene = SCNScene()
    let lunarNode = SCNNode()
    let geometryNode = SCNNode()
    let lightNode = SCNNode()
    var cameraOrbit = SCNNode()
    var beginPosition: Float = 0.0
    var endPosition: Float = 0.0
    let screenSize = UIScreen.main.bounds
    let layout = UICollectionViewFlowLayout()

    // MARK: - View Life Cycle

    override func viewDidLoad() {

        super.viewDidLoad()
        initLunarView()
        initLunarScene()
        initCamera()
        initLunarNode()
        initLightNode()
        setUpCollectionView()

    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(true)

        moonPhaseCollection.selectItem(at: Constant.firstDayMoonCellIndexPath!, animated: true, scrollPosition: .centeredHorizontally)

    }

    // MARK: - setUp Surroundings

    func initLunarView() {

        lunarView.translatesAutoresizingMaskIntoConstraints = false
        lunarView.allowsCameraControl = true
        lunarView.autoenablesDefaultLighting = true
        lunarView.frame = screenSize

    }

    func initLunarScene() {

        lunarView.scene = lunarScene
        lunarView.scene?.background.contents = #imageLiteral(resourceName: "space")
        lunarView.isUserInteractionEnabled = false

    }

    func initCamera() {

        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        camera.orthographicScale = 3
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3.init(0, 0, 10)
        cameraOrbit.addChildNode(cameraNode)
        lunarScene.rootNode.addChildNode(cameraOrbit)

    }

    func initLunarNode() {

        lunarNode.geometry = SCNSphere(radius: 2.0)
        lunarNode.position = SCNVector3.init(0, 1, 0)
        lunarNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "moonDiffuse")
        lunarScene.rootNode.addChildNode(lunarNode)

    }

    func initLightNode() {

        lightNode.light = SCNLight()
        lightNode.light?.type = .directional
        lightNode.light?.color = UIColor(white: 1, alpha: 1)
        lightNode.position = SCNVector3Make(0, 0, 20)
        lunarScene.rootNode.addChildNode(lightNode)

    }

    func spinAnimation() {

        let spin = CABasicAnimation(keyPath: "rotation")
        spin.fromValue = NSValue(scnVector4: SCNVector4Make(0, 1, 0, beginPosition))
        spin.toValue = NSValue(scnVector4: SCNVector4Make(0, 1, 0, endPosition))
        spin.duration = 1
        spin.fillMode = kCAFillModeForwards
        spin.isRemovedOnCompletion = false
        spin.timingFunction = CAMediaTimingFunction.init(name: "easeInEaseOut")
        cameraOrbit.addAnimation(spin, forKey: "rotation")

    }
}

// MARK: - moonPhaseCollectionView

extension MoonAgeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func setUpCollectionView() {

        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 70, height: 100)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        moonPhaseCollection.delegate = self
        moonPhaseCollection.dataSource = self
        moonPhaseCollection.backgroundColor = UIColor.init(white: 1, alpha: 0)
        moonPhaseCollection.collectionViewLayout = layout

        let moonCell = UINib.init(nibName: "MoonPhaseCell", bundle: nil)
        moonPhaseCollection.register(moonCell, forCellWithReuseIdentifier: "MoonPhaseCell")

    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 30

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoonPhaseCell", for: indexPath) as! MoonPhaseCell
        // swiftlint:enable force_cast

        return cell.configCell(IndexPath: indexPath.row)

    }

        // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        endPosition = Float(((Double(indexPath.row)) * Double.pi) / 15.0)
        spinAnimation()
        beginPosition = endPosition

    }
}
