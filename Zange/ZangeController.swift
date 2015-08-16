//
//  ViewController.swift
//  Zange
//
//  Created by user on 2015/08/16.
//  Copyright (c) 2015年 teamA. All rights reserved.
//

import UIKit

class ZangeController: UIViewController, UITextFieldDelegate {
    // 懺悔を入力するビュー
    let ud = NSUserDefaults.standardUserDefaults()
    // テキストフィールドの宣言
    private var myTextField: UITextField!
    // ボタンの宣言
    private var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        var sex:AnyObject! = ud.objectForKey("sex")
        // 「懺悔を入力」を表示するラベル
        let myNormalLabel: UILabel = UILabel()
        myNormalLabel.font = UIFont.systemFontOfSize(CGFloat(20))
        myNormalLabel.text = "懺悔を入力"
        myNormalLabel.frame = CGRect(x: 25, y: 10, width: 200, height: 150)
        myNormalLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(myNormalLabel)
        
        // 懺悔を入力するテキストフィールドを宣言
        myTextField = UITextField(frame: CGRectMake(50, 100, 250, 100))
        myTextField.borderStyle = UITextBorderStyle.RoundedRect  // 枠線を表示
        myTextField.delegate = self                              // デリゲートを追加
        myTextField.text = String(stringInterpolationSegment: sex)
        self.view.addSubview(myTextField)                        // ビュー画面
        
        // Buttonを生成する.
        myButton = UIButton()
        myButton.frame = CGRectMake(0,0,200,40)
        myButton.backgroundColor = UIColor.redColor()
        myButton.layer.masksToBounds = true
        myButton.layer.cornerRadius = 20.0
        myButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.bounds.height-50)
        myButton.tag = 1         // タグを設定する.
        // タイトルを設定する(通常時).
        myButton.setTitle("懺悔ボタン", forState: UIControlState.Normal)
        myButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        // タイトルを設定する(ボタンがハイライトされた時).
        myButton.setTitle("懺悔中", forState: UIControlState.Highlighted)
        myButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        // イベントを追加する.
        myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        // ボタンをViewに追加する.
        self.view.addSubview(myButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func onClickMyButton(sender: UIButton){
        /* ボタン押下時の処理 */
        // 遷移するViewを定義する.
        let myThirdViewController: UIViewController = NagusameViewController()
        
        // コンソールにテキストフィールドの入力値を表示
        println("\(myTextField.text)")
        
        // ビューを遷移
        self.navigationController?.pushViewController(myThirdViewController, animated: true)
        
    }

    
}

