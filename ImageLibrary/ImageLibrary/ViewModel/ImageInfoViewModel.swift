//
//  ImageInfoViewModel.swift
//  ImageLibrary
//
//  Created by Abhishek Binniwale on 06/08/20.
//  Copyright © 2020 Abhishek Binniwale. All rights reserved.
//

import Foundation
/*
 "id": "50192071543",
 "owner": "35953802@N03",
 "secret": "eb5150d598",
 "server": "65535",
 "farm": 66,
 "title": "IMG_2361.jpg",
 "ispublic": 1,
 "isfriend": 0,
 "isfamily": 0
 */
class  ImageInfoViewModel {
    
    let imageId : String
    let owner : String
    let secret: String
    let server : String
    let farm : Int
    let imageTitle : String
    let ispublic : Int
    let isfriend : Int
    let isfamily : Int
    var imageUrlString : String
    
    //Dependency Injection
    init(model : PhotoInfoModel) {
        self.imageId = model.id
        self.owner = model.owner
        self.secret = model.secret
        self.server = model.server
        self.farm = model.farm
        self.imageTitle = model.title
        self.isfamily = model.isfamily
        self.ispublic = model.ispublic
        self.isfriend = model.isfriend
        self.imageUrlString = "https://farm\(model.farm).staticflickr.com/\(model.server)/\(model.id)_\(model.secret)_n.jpg"
    }
}
