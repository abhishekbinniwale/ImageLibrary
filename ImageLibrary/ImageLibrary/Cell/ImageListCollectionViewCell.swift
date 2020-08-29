//
//  ImageListCollectionViewCell.swift
//  ImageLibrary
//
//  Created by Abhishek Binniwale on 05/08/20.
//  Copyright © 2020 Abhishek Binniwale. All rights reserved.
//

import UIKit
import Combine

class ImageListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewOutlet: CustomImageView!
    @IBOutlet weak var titleLabelOutlet: UILabel!
    
    private var cancellable: AnyCancellable?
    
    ///Prepare a cell for Resuse
    ///If view is going out of scope then cancel the image download.
    override func prepareForReuse() {
        super.prepareForReuse()
        // imageViewOutlet.cancelImageDownload()
        self.imageViewOutlet.image = UIImage(named: "loading")
        cancellable?.cancel()
    }
    
    ///Configure a cell with ImageInfoViewModel
    func configureCell(viewModel : ImageInfoViewModel){
        self.imageViewOutlet.layer.cornerRadius = 10
        self.addBorderAndShadowToCell()
        self.titleLabelOutlet.text = viewModel.imageTitle
        
        cancellable = loadImage(for: viewModel).sink { [unowned self] image in self.showImage(image: image) }
    }
    
    private func showImage(image: UIImage?) {
        self.imageViewOutlet.image = image
    }
    
    ///Load image either from Cache or download it from network
    private func loadImage(for infoModel: ImageInfoViewModel) -> AnyPublisher<UIImage?, Never> {
        return Just(infoModel.imageUrlString)
            .flatMap { imageUrlString -> AnyPublisher<UIImage?, Never> in
                let url = URL(string: infoModel.imageUrlString)!
                return ImageLoader.shared.loadImage(from: url)
        }.eraseToAnyPublisher()
    }
    
    ///TO add border ad shdow to cell
    func addBorderAndShadowToCell(){
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
    }
    
}
