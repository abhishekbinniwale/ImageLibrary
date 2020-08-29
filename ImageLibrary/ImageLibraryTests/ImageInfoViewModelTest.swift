//
//  ImageInfoViewModelTest.swift
//  ImageLibraryTests
//
//  Created by Abhishek Binniwale on 09/08/20.
//  Copyright © 2020 Abhishek Binniwale. All rights reserved.
//

import XCTest
@testable import ImageLibrary

class ImageInfoViewModelTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImageInfoViewModel() {
        
        let photoInfoModel = ImageLibrary.PhotoInfoModel(id: "50202910272", owner: "36588449@N04", secret: "20e8db0c68", server: "65535", farm: 66, title: "IMG_6145", ispublic: 1, isfriend: 0, isfamily: 0)
        
        let imageInfoViewModel = ImageInfoViewModel(model: photoInfoModel)
        
        XCTAssertEqual(photoInfoModel.id, imageInfoViewModel.imageId)
        XCTAssertEqual(photoInfoModel.owner, imageInfoViewModel.owner)
        XCTAssertEqual(photoInfoModel.secret, imageInfoViewModel.secret)
        XCTAssertEqual(photoInfoModel.server, imageInfoViewModel.server)
        XCTAssertEqual(photoInfoModel.farm, imageInfoViewModel.farm)
        XCTAssertEqual(photoInfoModel.title, imageInfoViewModel.imageTitle)
        XCTAssertEqual(photoInfoModel.ispublic, imageInfoViewModel.ispublic)
        XCTAssertEqual(photoInfoModel.isfriend, imageInfoViewModel.isfriend)
        XCTAssertEqual(photoInfoModel.isfamily, imageInfoViewModel.isfamily)
    }
    
    func testImageUrlCreation(){
         let photoInfoModel = ImageLibrary.PhotoInfoModel(id: "50202910272", owner: "36588449@N04", secret: "20e8db0c68", server: "65535", farm: 66, title: "IMG_6145", ispublic: 1, isfriend: 0, isfamily: 0)
        let imageInfoViewModel = ImageInfoViewModel(model: photoInfoModel)
        
        let imageUrl =  "https://farm66.staticflickr.com/65535/50202910272_20e8db0c68_n.jpg"
        
        XCTAssertEqual(imageUrl, imageInfoViewModel.imageUrlString)
    }

}
