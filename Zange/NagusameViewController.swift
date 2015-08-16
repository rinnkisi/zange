//
//  NagusameViewController.swift
//  Zange
//
//  Created by user on 2015/08/16.
//  Copyright (c) 2015年 teamA. All rights reserved.
//

import UIKit

// 美少女またはイケメンが格言を与えるクラス
class NagusameViewController: UIViewController {
  
  // 懺悔を入力するビュー
  let ud = NSUserDefaults.standardUserDefaults()
  
  private var myImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // 背景色
    self.view.backgroundColor = UIColor.whiteColor()
    
    // 美少女またはイケメンの画像を表示
    myImageView = UIImageView(frame: CGRectMake(0, 0, self.view.bounds.width, 0))
    myImageView.contentMode = UIViewContentMode.ScaleAspectFill
    let data_sample = SwiftDataSample()
    println(data_sample.Get_Bool2PicPath(ud.objectForKey("sex")!.boolValue!))
    let myImage = UIImage(named: data_sample.Get_Bool2PicPath(!ud.objectForKey("sex")!.boolValue!))
    myImageView.image = myImage
    myImageView.layer.position = CGPoint(x: self.view.bounds.width / 2, y: 270.0)
    
    self.view.addSubview(myImageView)
  
    
    // 格言を表示
    let myNormalLabel: UILabel = UILabel()
    myNormalLabel.font = UIFont.systemFontOfSize(CGFloat(20))
    myNormalLabel.text = data_sample.Get_RndKakugen()
    myNormalLabel.frame = CGRect(x: self.view.bounds.width / 2 - 100, y: self.view.bounds.height - 250, width: 200, height: 150)
    myNormalLabel.textColor = UIColor.redColor()
    self.view.addSubview(myNormalLabel)
    
    // 「もう一度懺悔する」ボタンを生成
    let backButton: UIButton = UIButton(frame: CGRectMake(0, 0, self.view.bounds.width, 50))
    backButton.backgroundColor = UIColor.blueColor();
    backButton.layer.masksToBounds = true
    backButton.setTitle("もう一度懺悔する", forState: .Normal)
    backButton.layer.cornerRadius = 0
    backButton.layer.position = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height - 75)
    backButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
    self.view.addSubview(backButton);
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // ボタン押下時の処理
  internal func onClickMyButton(sender: UIButton){
    // popすることにより、前のビューに戻る
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  // 乱数
  func RandomPicture() ->String{
    var num = Int(arc4random_uniform(5))
    return "w0" + num.description + ".jpg"
  }
}
