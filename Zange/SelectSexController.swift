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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景色は黒
        self.view.backgroundColor = UIColor.blackColor()

        // 「男」ボタンの生成
        let menButton: UIButton = UIButton(frame: CGRectMake(0,0,120,50))
        menButton.backgroundColor = UIColor.redColor();
        menButton.layer.masksToBounds = true
        menButton.setTitle("男", forState: .Normal)
        menButton.layer.cornerRadius = 20.0
        menButton.layer.position = CGPoint(x: self.view.bounds.width/2-100 , y:self.view.bounds.height-150)
        self.view.addSubview(menButton);

        // 「女」ボタンの生成
        let womenButton: UIButton = UIButton(frame: CGRectMake(0,0,120,50))
        womenButton.backgroundColor = UIColor.redColor();
        womenButton.layer.masksToBounds = true
        womenButton.setTitle("女", forState: .Normal)
        womenButton.layer.cornerRadius = 20.0
        womenButton.layer.position = CGPoint(x: self.view.bounds.width/2+100 , y:self.view.bounds.height-150)
        self.view.addSubview(womenButton);
        
        // 「決定」ボタンの生成
        let nextButton: UIButton = UIButton(frame: CGRectMake(0,0,120,50))
        nextButton.backgroundColor = UIColor.redColor();
        nextButton.layer.masksToBounds = true
        nextButton.setTitle("決定", forState: .Normal)
        nextButton.layer.cornerRadius = 20.0
        nextButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-50)
        nextButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        // ボタンを追加する.
        self.view.addSubview(nextButton);
        
    }
    
    internal func onClickMyButton(sender: UIButton){
        /* ボタンイベント. */
        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = ZangeController()
        // Viewの移動する.
        self.navigationController?.pushViewController(mySecondViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}