//
//  ImageListCollectionViewController.swift
//  ImageLibrary
//
//  Created by Abhishek Binniwale on 06/08/20.
//  Copyright © 2020 Abhishek Binniwale. All rights reserved.
//

import UIKit

class ImageListCollectionViewController: UIViewController , UISearchBarDelegate {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    var viewModels = [ImageInfoViewModel]()
    fileprivate let cellId = "ImageListCollectionViewCell"
    fileprivate var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.title = "Image Search"
        self.searchBarOutlet.enablesReturnKeyAutomatically = true
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // CustomImageView().clearImageCache()
        ImageLoader.shared.removeAllImages()
        self.viewModels.removeAll()
        self.imageCollectionView.reloadData()
        self.pageNumber = 1
        if let searchText = searchBar.text {
            self.callDataFetchAPI(searchText: searchText, pageNumber: self.pageNumber)
        }
        
    }
    
    //Close Keyboard
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    ///Call data fetch API from NetworkAPIManager
    func callDataFetchAPI(searchText: String, pageNumber: Int){
        if !searchText.isEmpty {
            DispatchQueue.global(qos: .background).async {
                NetworkAPIManager.sharedInstance.fetchImagesInfoForSearch(text: searchText, page: pageNumber) { (viewModels) in
                    DispatchQueue.main.async {
                        if let models = viewModels {
                            self.viewModels.append(contentsOf: models)
                            self.imageCollectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
}

//MARK: UICollectionViewDelegate and UICollectionViewDataSource
extension ImageListCollectionViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ImageListCollectionViewCell {
             let viewModel = viewModels[indexPath.row]
                 cell.configureCell(viewModel: viewModel)
            
            if indexPath.row == (viewModels.count) - 5 {
                self.pageNumber += 1
                self.callDataFetchAPI(searchText: self.searchBarOutlet.searchTextField.text ?? "", pageNumber: self.pageNumber)
            }
            return cell
        }
        return UICollectionViewCell()
    }
}
