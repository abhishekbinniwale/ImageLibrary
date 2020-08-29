//
//  ImageInfoModel.swift
//  ImageLibrary
//
//  Created by Abhishek Binniwale on 06/08/20.
//  Copyright © 2020 Abhishek Binniwale. All rights reserved.
//

import Foundation
/*
 {
 "photos": {
   "page": 1,
   "pages": 7800,
   "perpage": 20,
   "total": "155983",
   "photo": [
     {
       "id": "50192071543",
       "owner": "35953802@N03",
       "secret": "eb5150d598",
       "server": "65535",
       "farm": 66,
       "title": "IMG_2361.jpg",
       "ispublic": 1,
       "isfriend": 0,
       "isfamily": 0
     }
     ]
  }
 }
 */

struct ImageInfoModel :Decodable {
   
    var photos : InfoModel?
    
    struct InfoModel : Decodable{
        let perpage : Int
        var photo : [PhotoInfoModel]?
    }
}

struct PhotoInfoModel : Decodable{
    let id : String
    let owner : String
    let secret : String
    let server : String
    let farm : Int
    let title : String
    let ispublic : Int
    let isfriend : Int
    let isfamily : Int
}


