//
//  PhotoCell.swift
//  PalringoPhotos
//
//  Created by Benjamin Briggs on 14/10/2016.
//  Copyright © 2016 Palringo. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    private var fetchTask: URLSessionTask? {
        willSet {
            fetchTask?.cancel()
        }
    }
    
    var photo: Photo? {
        didSet {
            //CHANGED
            DispatchQueue.main.async {
                self.nameLabel?.text = self.photo?.name ?? ""
            }
            if let photo = photo {
                //CHANGED
                DispatchQueue.global(qos: .background).async {
                    self.fetchTask = CachedRequest.cachedImageDownload(view: self, imageView: self.imageView!, url: photo.url, animationType: .transitionCrossDissolve)
                    }
                }
            }
        }
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel?.text = nil
        self.imageView?.image = nil
    }
}
