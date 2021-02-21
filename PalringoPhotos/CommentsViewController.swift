//
//  CommentsViewcontroller.swift
//  PalringoPhotos
//
//  Created by Adam Jessop on 21/02/2021.
//  Copyright © 2021 Palringo. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noCommentsLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func setup(image: UIImage, photo: Photo) {
        authorName.text = "'\(photo.name)'"
        if let dataSource = tableView.dataSource as? CommentsDataSource {
            dataSource.downloadComments(photo: photo) { (comments) in
                guard !comments.isEmpty else {
                    self.noCommentsLabel.isHidden = false
                    self.commentLabel.isHidden = true
                    self.imageView.image = image
                    return
                }
                self.activityIndicator.stopAnimating()
                self.imageView.image = image
                self.tableView.reloadData()
            }
        }
    }
    
    //on small phones the large nav took up too much space in the comments views, this is why prefersLarge tiles is toggled in this class
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    
}
