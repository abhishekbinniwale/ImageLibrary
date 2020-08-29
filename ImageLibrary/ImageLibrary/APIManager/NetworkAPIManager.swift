//
//  NetworkAPIManager.swift
//  ImageLibrary
//
//  Created by Abhishek Binniwale on 06/08/20.
//  Copyright © 2020 Abhishek Binniwale. All rights reserved.
//

import Foundation

public class NetworkAPIManager {
    
    static let sharedInstance = NetworkAPIManager()
   
    //Fetching image Information with the given text
    func fetchImagesInfoForSearch(text : String, page: Int, completion:@escaping (([ImageInfoViewModel]?) -> Void)) {
        
        let searchText = text.replacingOccurrences(of: " ", with: "+")
        let imagesInfoFetchUrl = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=318d4c1c7b8eaafb95582869297be716&text=\(searchText)&per_page=20&page=\(page)&format=json&nojsoncallback=1"
        
        if let url = URL(string: imagesInfoFetchUrl) {
            let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let imageInfoModel = try JSONDecoder().decode(ImageInfoModel.self, from: data)
                   // print("Fetched imageInfo Model :\(imageInfoModel)")
                    
                    let viewModels = imageInfoModel.photos?.photo?.map({ (photoInfoModel) -> ImageInfoViewModel in
                        return ImageInfoViewModel(model: photoInfoModel)
                    })
                    completion(viewModels)
                } catch let error {
                    print("error while fetching data :\(error)")
                    completion(nil)
                }
            }
            dataTask.resume()
        } else {
            print("URL is not valid returning from function")
            ///Return nil in case of url failure
            completion(nil)
        }
    }
}
