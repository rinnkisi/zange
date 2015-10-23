//
//  SwiftDataSample.swift
//  Zange
//
//  Created by user on 2015/08/16.
//  Copyright (c) 2015年 teamA. All rights reserved.
//
import UIKit

class SwiftDataSample {
  
  init() {
    let (tb, err) = SD.existingTables()
    // 懺悔テーブル
    if !tb.contains("zange_mst") {
      if let err = SD.createTable("zange_mst", withColumnNamesAndTypes: ["zange_id" : .IntVal, "zange":.StringVal]) {
        //there was an error during this function, handle it here
      } else {
        //no error, the table was created successfully
      }
    }
    // 画像テーブル
    if !tb.contains("gazou_mst") {
      if let err = SD.createTable("gazou_mst", withColumnNamesAndTypes: ["gazou_id" : .IntVal, "url":.StringVal, "collect" : .BoolVal, "sex" : .BoolVal]){
        //there was an error during this function, handle it here
      } else {
        //no error, the table was created successfully
        // データを追加
        let Men = 1
        let Women = 0
        var gazou_id = 0
        
        // 男性の画像追加
        let data_men = (try! NSString(contentsOfFile: NSBundle.mainBundle().pathForResource("men", ofType: "txt")!, encoding: NSUTF8StringEncoding)) as! String
        data_men.enumerateLines { (line, stop) -> () in
          Add_Gazou(gazou_id++, filename : line, sex: Men)
        }
        
        // 女性の画像追加
        let data_women = (try! NSString(contentsOfFile: NSBundle.mainBundle().pathForResource("women", ofType: "txt")!, encoding: NSUTF8StringEncoding)) as! String
        data_women.enumerateLines { (line, stop) -> () in
          Add_Gazou(gazou_id++, filename : line, sex: Women)
        }
        
      }
    }
    // 格言テーブル
    if !tb.contains("kakugen_mst") {
      if let err = SD.createTable("kakugen_mst", withColumnNamesAndTypes: ["kakugen_id" : .IntVal, "word":.StringVal]) {
        //there was an error during this function, handle it here
      } else {
        //no error, the table was created successfully
        // データを追加
        var kakugen_id = 1;
        let data = (try! NSString(contentsOfFile: NSBundle.mainBundle().pathForResource("proverbs", ofType: "txt")!, encoding: NSUTF8StringEncoding)) as! String
        data.enumerateLines { (line, stop) -> () in
          Add_Kakugen(kakugen_id++, kakugen: line)
        }
      }
    }
    print(SD.databasePath())
    
    print("実行")
    print(Get_RndKakugen())
  }
  // 初期データ作成用
  func Add_Kakugen(kakugen_id : Int, kakugen :String) ->Bool{
    // 格言を格納する。
    // sqlを準備
    let sql = "INSERT INTO kakugen_mst (kakugen_id, word) VALUES (?, ?)";
    
    // ?に入る変数をバインドして実行
    if let err = SwiftData.executeChange( sql, withArgs: [kakugen_id, kakugen]) {
      //エラーが発生した時の処理
      let msg = SwiftData.errorMessageForCode(err);
      print(msg, terminator: "")
      return false;
    } else {
      return true;
    }
  }
  
  func Add_Gazou(gazou_id : Int, filename : String, sex : Int) ->Bool{
    // 画像のパスを格納する
    // sqlを準備
    let sql = "INSERT INTO gazou_mst (gazou_id, url, collect, sex) VALUES (?, ?, 0, ?)";
    
    // ?に入る変数をバインドして実行
    if let err = SwiftData.executeChange( sql, withArgs: [gazou_id, filename, sex]) {
      //エラーが発生した時の処理
      let msg = SwiftData.errorMessageForCode(err);
      print(msg, terminator: "")
      return false;
    } else {
      return true;
    }
  }
  
  // データ取得・操作用↓
  
  func Add_Zange(zange_id : Int, zange : String) ->Bool{
    // 入力された懺悔を記録するメソッド
    // sqlを準備
    let sql = "INSERT INTO zange_mst (zange_id, zange) VALUES (?, ?)";
    
    // ?に入る変数をバインドして実行
    if let err = SwiftData.executeChange( sql, withArgs: [zange_id, zange]) {
      //エラーが発生した時の処理
      let msg = SwiftData.errorMessageForCode(err);
      print(msg, terminator: "")
      return false;
    } else {
      return true;
    }
  }
  
  func Get_ID2PicPath(gazou_id : Int) -> String{
    // 画像IDに対して、ファイル名を返す
    let (resultSet, err) = SD.executeQuery("SELECT url FROM gazou_mst where gazou_id = ?", withArgs: [gazou_id])
    if err != nil {
      //there was an error during the query, handle it here
      return ""
    } else {
      for row in resultSet {
        if let name = row["url"]?.asString() {
          return name
        }
      }
    }
    return ""
  }
  
  func Get_Bool2PicPath(IsMen : Bool) -> String{
    // Bool型の引数（男はTrue,女はFalse）に対して、ランダムにファイル名を返す
    // Int(arc4random_uniform(5)  .description
    var sex = 0
    if IsMen {
      sex = 1
    } else {
      sex = 0
    }
    let (resultSet, err) = SD.executeQuery("SELECT url FROM gazou_mst where sex = ?", withArgs: [sex])
    if err != nil {
      //there was an error during the query, handle it here
      return ""
    } else {
      var result = [String]()
      for row in resultSet {
        if let name = row["url"]?.asString() {
          result.append(name)
        }
      }
      let p_id = Int(arc4random_uniform(UInt32(result.count)))
      // 収集済みフラグを立てる
      Collected_Gazou(p_id)
      return result[p_id]
    }
  }
  
  func Collected_Gazou(gazou_id : Int) ->Bool{
    // 画像IDに対して、収集済みフラグを立てる
    // sqlを準備
    let sql = "UPDATE gazou_mst SET collect = 1 WHERE gazou_id = ? ";
    
    // ?に入る変数をバインドして実行
    if let err = SwiftData.executeChange( sql, withArgs: [gazou_id]) {
      //エラーが発生した時の処理
      let msg = SwiftData.errorMessageForCode(err);
      print(msg, terminator: "")
      return false;
    } else {
      return true;
    }
  }
  
  func Get_RndKakugen() -> String{
    // ランダムに格言を一つ返す
    let (resultSet, err) = SD.executeQuery("SELECT word FROM kakugen_mst")
    if err != nil {
      //there was an error during the query, handle it here
      return ""
    } else {
      var result = [String]()
      for row in resultSet {
        if let name = row["word"]?.asString() {
          result.append(name)
        }
      }
      let p_id = Int(arc4random_uniform(UInt32(result.count)))
      return result[p_id]
    }
  }
}