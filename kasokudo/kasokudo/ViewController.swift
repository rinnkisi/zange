
//
//  ViewController.swift
//  kasokudo
//
//  Created by 林貴史 on 2015/08/17.
//  Copyright (c) 2015年 林貴史. All rights reserved.
//
//  ViewController.swift
//  CoreMotion001
//
import UIKit
import CoreMotion

class ViewController: UIViewController {
    var myMotionManager: CMMotionManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Labelを作成.
        let myZLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
        myZLabel.backgroundColor = UIColor.redColor()
        myZLabel.layer.masksToBounds = true
        myZLabel.layer.cornerRadius = 10.0
        myZLabel.textColor = UIColor.whiteColor()
        myZLabel.shadowColor = UIColor.grayColor()
        myZLabel.textAlignment = NSTextAlignment.Center
        myZLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 360)
        
        // Viewの背景色を青にする.
        self.view.backgroundColor = UIColor.cyanColor()
        // ViewにLabelを追加.
        self.view.addSubview(myZLabel)
        // MotionManagerを生成.
        myMotionManager = CMMotionManager()
        // 更新周期を設定.
        myMotionManager.accelerometerUpdateInterval = 0.1
        // 加速度の取得を開始.
        myMotionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: {(accelerometerData:CMAccelerometerData!, error:NSError!) -> Void in
            myZLabel.text = "z=\(accelerometerData.acceleration.z)"
        });
    }
};