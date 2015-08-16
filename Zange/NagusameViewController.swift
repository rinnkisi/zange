//
//  NagusameViewController.swift
//  Zange
//
//  Created by user on 2015/08/16.
//  Copyright (c) 2015年 teamA. All rights reserved.
//

import UIKit
import AVFoundation

// 美少女またはイケメンが懺悔を聞き入るクラス
class NagusameViewController: UIViewController {
  
  // 質問文問い合わせリクエスト
  var param: DialogueRequestParam!
  // 雑談対話問い合わせ処理
  var dialogue: Dialogue!
  // 回答データ
  var resultData: DialogueResultData!
  // エラー情報
  var sdkError: SdkError!
  var talker: AVSpeechSynthesizer!
  
  let ud = NSUserDefaults.standardUserDefaults()
  
  private var myImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // 認証情報初期化
    // docomo Developer supportから取得したAPIキーを設定
    AuthApiKey.initializeAuth("69725746705451496f6d6d374e356f5a2f7a4d68532f6c6c545065374574316d6c5169477371486c487534")
    
    param = DialogueRequestParam()
    dialogue = Dialogue()
    sdkError = SdkError()
    talker = AVSpeechSynthesizer()
    
    // 背景色
    self.view.backgroundColor = UIColor.whiteColor()
    
    // 美少女またはイケメンの画像を表示
    myImageView = UIImageView(frame: CGRectMake(0, 0, self.view.bounds.width, 0))
    myImageView.contentMode = UIViewContentMode.ScaleAspectFill
    let data_sample = SwiftDataSample()
    // println(data_sample.Get_Bool2PicPath(ud.objectForKey("sex")!.boolValue!))
    let myImage = UIImage(named: data_sample.Get_Bool2PicPath(!ud.objectForKey("sex")!.boolValue!))
    myImageView.image = myImage
    myImageView.layer.position = CGPoint(x: self.view.bounds.width / 2, y: 270.0)
    self.view.addSubview(myImageView)
    
    //発話を設定
    param.utt = ud.stringForKey("zangetext")
    // APIのキャラクタ設定(デフォルト:ゼロ,20:桜子,30:ハヤテ)
    if (ud.objectForKey("sex")!.boolValue!) {
      param.character = 20
    }
    else {
      param.character = 30
    }
    
    /*
    雑談対話問い合わせ処理にデータを渡す.
    APIからは音声合成用情報が「resultData.yomi」に返ってくるので
    AVSpeechSynthesizerで読み上げる.
    コンテキストID(resultData.context)を使うことで継続した会話ができる.
    */
    dialogue.request(param, onComplete: { (resultData) -> Void in
      self.param.context = "\(resultData.context)"
      let utterance = AVSpeechUtterance(string: "\(resultData.yomi)")
      utterance.voice = AVSpeechSynthesisVoice(language: "jp-JP")
      utterance.rate = 0.1
      
      if (self.ud.objectForKey("sex")!.boolValue!) {
        utterance.pitchMultiplier = 6.0
      }
      else {
        utterance.pitchMultiplier = 0.5
      }
      
      self.talker.speakUtterance(utterance)
      
      // 格言を表示
      let myNormalLabel: UILabel = UILabel()
      myNormalLabel.font = UIFont.systemFontOfSize(CGFloat(20))
      myNormalLabel.text = resultData.yomi
      myNormalLabel.frame = CGRect(x: self.view.bounds.width / 2 - 150, y: self.view.bounds.height - 250, width: 300, height: 100)
      myNormalLabel.numberOfLines = 0 // 自動改行
      myNormalLabel.sizeToFit();  // 高さを自動で調整
     
      myNormalLabel.textColor = UIColor.blackColor()
      myNormalLabel.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
      self.view.addSubview(myNormalLabel)
      
      }) { (sdkError) -> Void in
        println("\(sdkError)")
    }
    
    // 「もう一度懺悔する」ボタンを生成
    let backButton: UIButton = UIButton(frame: CGRectMake(0, 0, self.view.bounds.width, 150))
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
}
