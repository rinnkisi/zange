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
    if !contains(tb, "zange_mst") {
      if let err = SD.createTable("zange_mst", withColumnNamesAndTypes: ["zange_id" : .IntVal, "zange":.StringVal]) {
        //there was an error during this function, handle it here
      } else {
        //no error, the table was created successfully
      }
    }
    // 画像テーブル
    if !contains(tb, "gazou_mst") {
      if let err = SD.createTable("gazou_mst", withColumnNamesAndTypes: ["gazou_id" : .IntVal, "url":.StringVal, "collect" : .BoolVal, "sex" : .BoolVal]){
        //there was an error during this function, handle it here
      } else {
        //no error, the table was created successfully
        // データを追加
        let Men = 1
        let Women = 0
        var gazou_id = 1;
        
        // 男性の画像追加
        let data_men = NSString(contentsOfFile: NSBundle.mainBundle().pathForResource("men", ofType: "txt")!, encoding: NSUTF8StringEncoding, error: nil) as! String
        data_men.enumerateLines { (line, stop) -> () in
          Add_Gazou(gazou_id++, filename : line, sex: Men)
        }
        
        // 女性の画像追加
        let data_women = NSString(contentsOfFile: NSBundle.mainBundle().pathForResource("women", ofType: "txt")!, encoding: NSUTF8StringEncoding, error: nil) as! String
        data_women.enumerateLines { (line, stop) -> () in
          Add_Gazou(gazou_id++, filename : line, sex: Women)
        }
        
      }
    }
    // 格言テーブル
    if !contains(tb, "kakugen_mst") {
      if let err = SD.createTable("kakugen_mst", withColumnNamesAndTypes: ["kakugen_id" : .IntVal, "word":.StringVal]) {
        //there was an error during this function, handle it here
      } else {
        //no error, the table was created successfully
        // データを追加
        var kakugen_id = 1;
        let data = NSString(contentsOfFile: NSBundle.mainBundle().pathForResource("proverbs", ofType: "txt")!, encoding: NSUTF8StringEncoding, error: nil) as! String
        data.enumerateLines { (line, stop) -> () in
          Add_Kakugen(kakugen_id++, kakugen: line)
        }
      }
    }
    println(SD.databasePath())

  }
  
  func Add_Kakugen(kakugen_id : Int, kakugen :String) ->Bool{
    // 格言を格納する。
    // sqlを準備
    let sql = "INSERT INTO kakugen_mst (kakugen_id, word) VALUES (?, ?)";
    
    // ?に入る変数をバインドして実行
    if let err = SwiftData.executeChange( sql, withArgs: [kakugen_id, kakugen]) {
      //エラーが発生した時の処理
      let msg = SwiftData.errorMessageForCode(err);
      print(msg)
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
      print(msg)
      return false;
    } else {
      return true;
    }
  }
  
  func Add_Zange(zange_id : Int, zange : String) ->Bool{
    // 入力された懺悔を記録するメソッド
    // sqlを準備
    let sql = "INSERT INTO zange_mst (zange_id, zange) VALUES (?, ?)";
    
    // ?に入る変数をバインドして実行
    if let err = SwiftData.executeChange( sql, withArgs: [zange_id, zange]) {
      //エラーが発生した時の処理
      let msg = SwiftData.errorMessageForCode(err);
      print(msg)
      return false;
    } else {
      return true;
    }
  }
  
  func Get_PicPath(gazou_id : Int) -> String{
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
  
  func Collected_Gazou(gazou_id : Int) ->Bool{
    // 画像IDに対して、収集済みフラグを立てる
    // sqlを準備
    let sql = "UPDATE gazou_mst SET collect = 1 WHERE gazou_id = ? ";
    
    // ?に入る変数をバインドして実行
    if let err = SwiftData.executeChange( sql, withArgs: [gazou_id]) {
      //エラーが発生した時の処理
      let msg = SwiftData.errorMessageForCode(err);
      print(msg)
      return false;
    } else {
      return true;
    }
  }
}