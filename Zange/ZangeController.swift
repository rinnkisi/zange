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
    private let menButton: UIButton = UIButton(frame: CGRectMake(0,0,120,50))
    private let womenButton: UIButton = UIButton(frame: CGRectMake(0,0,120,50))

    // ボタンの宣言
    private var myButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ud = NSUserDefaults.standardUserDefaults()
        var sex:AnyObject! = ud.objectForKey("sex")
        // 背景色は黒
        self.view.backgroundColor = UIColor.blackColor()
        // 「懺悔を入力」を表示するラベル
        let ZangeLabel: UILabel = UILabel()
        ZangeLabel.font = UIFont.systemFontOfSize(CGFloat(20))
        ZangeLabel.text = "懺悔を入力"
        ZangeLabel.frame = CGRect(x:(self.view.bounds.width - 270) / 2, y: 10, width: 200, height: 150)
        ZangeLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(ZangeLabel)

        // 懺悔を入力するテキストフィールドを宣言
        myTextField = UITextField(frame: CGRectMake((self.view.bounds.width - 270) / 2, 100, 270, 100))
        myTextField.borderStyle = UITextBorderStyle.RoundedRect  // 枠線を表示
        myTextField.delegate = self                              // デリゲートを追加
        // myTextField.text = String(stringInterpolationSegment: sex)
        myTextField.textAlignment = NSTextAlignment.Center // 中央寄せする
        self.view.addSubview(myTextField)                        // ビュー画面
        
        // 性別を選択するビュー。
        let SexLabel: UILabel = UILabel()
        SexLabel.textColor = UIColor.whiteColor()
        SexLabel.font = UIFont.systemFontOfSize(CGFloat(20))
        SexLabel.text = "あなたの性別をお選びください"
        SexLabel.sizeToFit()
        //SexLabel.center = CGPointMake(100,100)
        SexLabel.frame = CGRect(x: (self.view.bounds.width - 300) / 2,y:self.view.bounds.height / 2, width: 300, height: 30)
        self.view.addSubview(SexLabel)
        
        // 「男」ボタンの生成
        ud.setBool(true, forKey: "sex")//初期値を男性に設定
        menButton.backgroundColor = UIColor.blueColor();
        menButton.layer.masksToBounds = true
        menButton.setTitle("男", forState: .Normal)
        menButton.layer.cornerRadius = 20.0
        menButton.layer.position = CGPoint(x: self.view.bounds.width/2-100 , y:self.view.bounds.height-150)
        // 「男」ボタンを追加する.
        menButton.addTarget(self, action: "didmenTouch:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(menButton);
        
        // 「女」ボタンの生成
        womenButton.backgroundColor = UIColor.redColor();
        womenButton.layer.masksToBounds = true
        womenButton.setTitle("女", forState: .Normal)
        womenButton.layer.cornerRadius = 20.0
        womenButton.layer.position = CGPoint(x: self.view.bounds.width/2+100 , y:self.view.bounds.height-150)
        womenButton.addTarget(self, action: "didwomenTouch:", forControlEvents: UIControlEvents.TouchUpInside)
        // 「女」ボタンを追加する.
        self.view.addSubview(womenButton);
        
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
    
    func didmenTouch(button :UIButton){
        //男性ボタンが押された時の処理
        var flag = true
        menButton.backgroundColor = UIColor.blueColor()
        womenButton.backgroundColor = UIColor.redColor()
        ud.setBool(true, forKey: "sex") //ユーザのデフォルトに入れる
        println("「男」ボタンがタッチされました")
    }
    func didwomenTouch(button :UIButton){
        //女性ボタンが押された時の処理
        var flag = false
        menButton.backgroundColor = UIColor.redColor()
        womenButton.backgroundColor = UIColor.blueColor()
        ud.setBool(false, forKey: "sex") //ユーザのデフォルトに入れる
        println("「女」ボタンがタッチされました")
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    internal func onClickMyButton(sender: UIButton){
        /* ボタン押下時の処理 */
        // 遷移するViewを定義する.
        let myThirdViewController: UIViewController = NagusameViewController()
        // コンソールにテキストフィールドの入力値を表示
        println(myTextField.text)
        println(ud.objectForKey("sex"))
        // ビューを遷移
        self.navigationController?.pushViewController(myThirdViewController, animated: true)
        myTextField.text = nil
        
    }
}