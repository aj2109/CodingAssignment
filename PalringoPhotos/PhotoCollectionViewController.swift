
//
//  PhotoCollectionViewController.swift
//  PalringoPhotos
//
//  Created by Benjamin Briggs on 14/10/2016.
//  Copyright © 2016 Palringo. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController, AlertShowing {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choosePhotographer()
    }
    
    private func choosePhotographer() {
        showPhotographerAlert(presenter: self) { [weak self] (photographer) in
            guard let self = self else {return}
            if let dataSource = self.collectionView.dataSource as? ImageDataSource {
                dataSource.chosenPhotographer = photographer
            }
            self.title = photographer.displayName
            
            CachedRequest.request(url: photographer.imageURL) { data, isCached in
                //CHANGED
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    guard let data = data, let image = UIImage(data: data) else {
                        return
                    }
                    self.navigationItem.addImage(image: image, location: .left, size: CGSize(width: 200, height: 200))
                }
            }
        }
    }
}

//put this into its own extension just because I think it makes things a bit clearer

extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if
            let sb = UIStoryboard.init(name: "CommentsViewController", bundle: .main) as UIStoryboard?,
            let vc = sb.instantiateViewController(withIdentifier: "CommentsViewController") as? CommentsViewController,
            let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell,
            let photo = cell.photo,
            let image = cell.imageView?.image {
            _ = vc.view
            vc.setup(image: image, photo: photo)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
