//
//  ImageLoaderTest.swift
//  ImageLibraryTests
//
//  Created by Abhishek Binniwale on 09/08/20.
//  Copyright © 2020 Abhishek Binniwale. All rights reserved.
//

import XCTest
@testable import ImageLibrary
class ImageLoaderTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImageDownload() {
       
        let photoInfoModel = ImageLibrary.PhotoInfoModel(id: "50202910272", owner: "36588449@N04", secret: "20e8db0c68", server: "65535", farm: 66, title: "IMG_6145", ispublic: 1, isfriend: 0, isfamily: 0)
               let imageInfoViewModel = ImageInfoViewModel(model: photoInfoModel)
               let url = URL(string: imageInfoViewModel.imageUrlString)!
            XCTAssertNotNil(ImageLoader.shared.loadImage(from: url))

    
    }
    
    
}
