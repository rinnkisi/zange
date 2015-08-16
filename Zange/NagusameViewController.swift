//
//  NagusameViewController.swift
//  Zange
//
//  Created by user on 2015/08/16.
//  Copyright (c) 2015年 teamA. All rights reserved.
//

import UIKit

class NagusameViewController: UIViewController {
  // 美少女またはイケメンが格言を与えるクラス
  
  private var myImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    // 背景色
    self.view.backgroundColor = UIColor.grayColor()
    
    // 文字列を表示
    // let myNormalLabel: UILabel = UILabel()
    // myNormalLabel.font = UIFont.systemFontOfSize(CGFloat(20))
    // myNormalLabel.text = "癒す画面"
    // myNormalLabel.frame = CGRect(x: 25, y: 10, width: 200, height: 150)
    // myNormalLabel.textColor = UIColor.whiteColor()
    // self.view.addSubview(myNormalLabel)
    
    // 「もう一度懺悔する」ボタンを生成
    let backButton: UIButton = UIButton(frame: CGRectMake(0,0,200,50))
    backButton.backgroundColor = UIColor.blueColor();
    backButton.layer.masksToBounds = true
    backButton.setTitle("もう一度懺悔する", forState: .Normal)
    backButton.layer.cornerRadius = 10.0
    backButton.layer.position = CGPoint(x: self.view.bounds.width / 2, y:self.view.bounds.height - 50)
    backButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
    self.view.addSubview(backButton);
    
    
    
    // UIImageViewを作成する.
    myImageView = UIImageView(frame: CGRectMake(0,0,330,440))
    let myImage = UIImage(named: "w00.jpg")
    myImageView.image = myImage
    myImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: 250.0)
    self.view.addSubview(myImageView)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  internal func onClickMyButton(sender: UIButton){
    /* ボタン押下時の処理 */
    // popすることにより、前のビューに戻る
    self.navigationController?.popViewControllerAnimated(true)
  }

}