//  ViewController.swift
//  Zange
//
//  Created by user on 2015/08/16.
//  Copyright (c) 2015年 teamA. All rights reserved.
//

import UIKit
import Foundation

func hexFromRGB(hex:String) -> (CGFloat,CGFloat,CGFloat,CGFloat) {
    var red: CGFloat   = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat  = 0.0
    var alpha: CGFloat = 1.0
    
    let index = hex.startIndex.advancedBy(1)
    let hexCode = hex.substringFromIndex(index)
    let scanner = NSScanner(string: hexCode)
    var hexValue: CUnsignedLongLong = 0
    if scanner.scanHexLongLong(&hexValue) {
        if hexCode.characters.count == 6 {
            red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
            green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
            blue  = CGFloat(hexValue & 0x0000FF) / 255.0
        } else if hexCode.characters.count == 8 {
            red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
            green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
            blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
            alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
        } else {
            print("err", terminator: "")
        }
    }
    
    return (red,green,blue,alpha)
}

extension UIColor {
    convenience init(hex: String = "") {
        var red: CGFloat  = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat  = 0.0
        var alpha: CGFloat = 1.0
        (red,green,blue,alpha) = hexFromRGB(hex)
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

class ZangeController: UIViewController, UITextViewDelegate {
    private var myTextView: UITextView!
    // 懺悔を入力するビュー
    let ud = NSUserDefaults.standardUserDefaults()
    // テキストフィールドの宣言
    private let menButton: UIButton = UIButton(frame: CGRectMake(0,0,120,50))
    private let womenButton: UIButton = UIButton(frame: CGRectMake(0,0,120,50))

    // ボタンの宣言
    private var myButton: UIButton!

    // ボタンの色
    private let buttonOffColor = UIColor(hex: "#c0dfd9")
    private let buttonOnColor = UIColor(hex: "#5c9c8f")
    
    private var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ud = NSUserDefaults.standardUserDefaults()
        var sex: AnyObject! = ud.objectForKey("sex")
        // 背景色
        // 背景に画像を設定する.
        // self.view.backgroundColor = UIColor.clearColor()
        // myImageView = UIImageView(frame: CGRectMake(0, 0, self.view.bounds.width, 0))
        // myImageView.contentMode = UIViewContentMode.ScaleAspectFill
        // let data_sample = SwiftDataSample()
        // let myImage = UIImage(named: "zange.jpg")
        // myImageView.image = myImage
        // myImageView.layer.position = CGPoint(x: self.view.bounds.width / 2, y: 270.0)
        // self.view.addSubview(myImageView)
        self.view.backgroundColor = UIColor(hex: "#b3c2bf")
        // 「懺悔を入力」を表示するラベル
        let ZangeLabel: UILabel = UILabel()
        ZangeLabel.font = UIFont.systemFontOfSize(CGFloat(20))
        ZangeLabel.text = "懺悔を入力"
        ZangeLabel.frame = CGRect(x:(self.view.bounds.width - 270) / 2, y: 10, width: 200, height: 150)
        ZangeLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(ZangeLabel)

        // 懺悔を入力するテキストフィールドを宣言
        myTextView = UITextView(frame: CGRectMake((self.view.bounds.width - 270) / 2, 100, 270, 100))
        // myTextView.layer.borderWidth = 1
        // 枠線の色を黒に設定する.
        // myTextView.layer.borderColor = UIColor.blackColor().CGColor
        myTextView.returnKeyType = UIReturnKeyType.Done //改行を完了ボタンにする
        myTextView.font = UIFont(name: "AmericanTypewriter",size: 20)
        // myTextField.text = String(stringInterpolationSegment: sex)
        myTextView.textAlignment = NSTextAlignment.Justified // 中央寄せする
        myTextView.delegate = self //デリゲートを追加
        // 左詰めの設定をする.
        myTextView.textAlignment = NSTextAlignment.Left
        myTextView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
        
        self.view.addSubview(myTextView)
        // テキストフィールドを強制フォーカス
        NSOperationQueue.mainQueue().addOperationWithBlock({self.myTextView.becomeFirstResponder()});
  
        // 性別を選択するビュー。
        let SexLabel: UILabel = UILabel()
        SexLabel.textColor = UIColor.whiteColor()
        SexLabel.font = UIFont.systemFontOfSize(CGFloat(20))
        SexLabel.text = "どちらに懺悔する？"
        SexLabel.sizeToFit()
        //SexLabel.center = CGPointMake(100,100)
        SexLabel.frame = CGRect(x: (self.view.bounds.width - 300) / 2,y:self.view.bounds.height / 2, width: 300, height: 30)
        self.view.addSubview(SexLabel)
        
        // 「男」ボタンの生成
        ud.setBool(true, forKey: "sex")//初期値を男性に設定
        menButton.backgroundColor = buttonOnColor
        menButton.frame = CGRectMake(0,0,self.view.bounds.width/2,75)
        menButton.layer.masksToBounds = true
        menButton.setTitle("美少女に", forState: .Normal)
        //menButton.layer.cornerRadius = 20.0
        menButton.layer.position = CGPoint(x: self.view.bounds.width/4 , y:self.view.bounds.height-112)
        // 「男」ボタンを追加する.
        menButton.addTarget(self, action: "didmenTouch:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(menButton);
        
        // 「女」ボタンの生成
        womenButton.backgroundColor = buttonOffColor
        womenButton.frame = CGRectMake(0,0,self.view.bounds.width/2,75)
        womenButton.layer.masksToBounds = true
        womenButton.setTitle("イケメンに", forState: .Normal)
        //womenButton.layer.cornerRadius = 20.0
        womenButton.layer.position = CGPoint(x: self.view.bounds.width/4*3 , y:self.view.bounds.height-112)
        womenButton.addTarget(self, action: "didwomenTouch:", forControlEvents: UIControlEvents.TouchUpInside)
        // 「女」ボタンを追加する.
        self.view.addSubview(womenButton);
      
        // Buttonを生成する.
        myButton = UIButton()
        myButton.frame = CGRectMake(0,0,self.view.bounds.width,75)
        myButton.backgroundColor = UIColor(hex: "#9b2c3b")
        myButton.layer.masksToBounds = true
        myButton.layer.position = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height - 37.5)
        myButton.tag = 1         // タグを設定する.
        // タイトルを設定する(通常時).
        myButton.setTitle("懺悔する", forState: UIControlState.Normal)
        myButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)

        // タイトルを設定する(ボタンがハイライトされた時).
        myButton.setTitle("懺悔中…", forState: UIControlState.Highlighted)
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
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    func didmenTouch(button :UIButton){
        //男性ボタンが押された時の処理
        _ = true
        menButton.backgroundColor = buttonOnColor
        womenButton.backgroundColor = buttonOffColor
        ud.setBool(true, forKey: "sex") //ユーザのデフォルトに入れる
        print("「男」ボタンがタッチされました")
    }
    func didwomenTouch(button :UIButton){
        //女性ボタンが押された時の処理
        _ = false
        menButton.backgroundColor = buttonOffColor
        womenButton.backgroundColor = buttonOnColor
        ud.setBool(false, forKey: "sex") //ユーザのデフォルトに入れる
        print("「女」ボタンがタッチされました")
    }
  
    func textViewShouldReturn(textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        // 遷移するViewを定義する.
        let myThirdViewController: UIViewController = NagusameViewController()
        // コンソールにテキストフィールドの入力値を表示
        // println(myTextField.text)
        ud.setObject(myTextView.text, forKey: "zangetext")
        print(ud.objectForKey("zangetext"))
        print(ud.objectForKey("sex"))
        // ビューを遷移
        self.navigationController?.pushViewController(myThirdViewController, animated: true)
        myTextView.text = nil
        return true
    }
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange,
        replacementText text: String) -> Bool {
            if text == "\n" {
                textView.resignFirstResponder() //キーボードを閉じる
                let myThirdViewController: UIViewController = NagusameViewController()
                // コンソールにテキストフィールドの入力値を表示
                // println(myTextField.text)
                ud.setObject(myTextView.text, forKey: "zangetext")
                print(ud.objectForKey("zangetext"))
                print(ud.objectForKey("sex"))
                // ビューを遷移
                self.navigationController?.pushViewController(myThirdViewController, animated: true)
                myTextView.text = nil
                return false
            }
            return true
    }
  
    // ボタン押下時の処理
    internal func onClickMyButton(sender: UIButton){
      
        // 遷移するViewを定義する.
        let myThirdViewController: UIViewController = NagusameViewController()
        // コンソールにテキストフィールドの入力値を表示
        print(myTextView.text)
        ud.setObject(myTextView.text, forKey: "zangetext")
        print(ud.objectForKey("zangetext"))
        print(ud.objectForKey("sex"))
        // ビューを遷移
        self.navigationController?.pushViewController(myThirdViewController, animated: true)
        myTextView.text = nil
    }
}
