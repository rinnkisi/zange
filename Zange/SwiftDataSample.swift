//
//  SwiftDataSample.swift
//  Zange
//
//  Created by user on 2015/08/16.
//  Copyright (c) 2015年 teamA. All rights reserved.
//

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
      }
    }
    // 格言テーブル
    if !contains(tb, "kakugen_mst") {
      if let err = SD.createTable("kakugen_mst", withColumnNamesAndTypes: ["kakugen_id" : .IntVal, "word":.StringVal]) {
        //there was an error during this function, handle it here
      } else {
        //no error, the table was created successfully
      }
    }
    println(SD.databasePath())
  }
  
}