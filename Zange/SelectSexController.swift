//
//  SelectSexController.swift
//  Zange
//
//  Created by user on 2015/08/16.
//  Copyright (c) 2015年 teamA. All rights reserved.
//
import UIKit

class SelectSexController: UIViewController {
    // 性別を選択するビュー。
    let ud = NSUserDefaults.standardUserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景色は黒
        self.view.backgroundColor = UIColor.blackColor()

        // 「男」ボタンの生成
        let menButton: UIButton = UIButton(frame: CGRectMake(0,0,120,50))
        menButton.backgroundColor = UIColor.blueColor();
        menButton.layer.masksToBounds = true
        menButton.setTitle("男", forState: .Normal)
        menButton.layer.cornerRadius = 20.0
        menButton.layer.position = CGPoint(x: self.view.bounds.width/2-100 , y:self.view.bounds.height-150)
        // 「男」ボタンを追加する.
        menButton.addTarget(self, action: "didmenTouch:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(menButton);
        
        // 「女」ボタンの生成
        
        let womenButton: UIButton = UIButton(frame: CGRectMake(0,0,120,50))
        womenButton.backgroundColor = UIColor.redColor();
        womenButton.layer.masksToBounds = true
        womenButton.setTitle("女", forState: .Normal)
        womenButton.layer.cornerRadius = 20.0
        womenButton.layer.position = CGPoint(x: self.view.bounds.width/2+100 , y:self.view.bounds.height-150)
        womenButton.addTarget(self, action: "didwomenTouch:", forControlEvents: UIControlEvents.TouchUpInside)
        // 「女」ボタンを追加する.
        self.view.addSubview(womenButton);
        
        // 「決定」ボタンの生成
        let nextButton: UIButton = UIButton(frame: CGRectMake(0,0,120,50))
        nextButton.backgroundColor = UIColor.whiteColor();
        nextButton.layer.masksToBounds = true
        nextButton.setTitle("決定", forState: .Normal)
        nextButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        nextButton.layer.cornerRadius = 20.0
        nextButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-50)
        nextButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        // 決定ボタンを追加する.
        self.view.addSubview(nextButton);
        
    }
    func didmenTouch(button :UIButton){
        var flag = true
        ud.setObject("男", forKey: "sex")
        println(flag)
        println("「男」ボタンがタッチされました")
    }
    func didwomenTouch(button :UIButton){
        var flag = false
        ud.setObject("女", forKey: "sex")
        println(flag)
        println("「女」ボタンがタッチされました")
    }
    internal func onClickMyButton(sender: UIButton){
        /* 決定ボタンイベント. */
        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = ZangeController()
        // Viewの移動する.
        self.navigationController?.pushViewController(mySecondViewController, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}