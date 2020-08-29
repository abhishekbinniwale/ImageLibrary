//
//  ImageLoader.swift
//  ImageLibrary
//
//  Created by Abhishek Binniwale on 09/08/20.
//  Copyright © 2020 Abhishek Binniwale. All rights reserved.
//

import Foundation
import UIKit.UIImage
import Combine

public final class ImageLoader {
    public static let shared = ImageLoader()

    private let cache: ImageCacheProtocol
    private let backgroundQueue = DispatchQueue.global(qos: .userInitiated)

    public init(cache: ImageCacheProtocol = ImageCache()) {
        self.cache = cache
    }

    public func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache.image(for: url) {
            return Just(image).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.cache.insertImage(image, for: url)
            })
            .print("Image loading \(url):")
            .subscribe(on: backgroundQueue)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    public func removeAllImages(){
        cache.removeAllImages()
    }
}
