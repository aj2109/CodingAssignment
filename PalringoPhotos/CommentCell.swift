//
//  CommentCell.swift
//  PalringoPhotos
//
//  Created by Adam Jessop on 21/02/2021.
//  Copyright © 2021 Palringo. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    //already dealt with the HTML decoding by this point thanks to the dataSource, so once a PhotoComment object is passed in it is just a case of displaying what is there
    var photoComment: PhotoComment? {
        willSet {
            guard let newValue = newValue else {return}
            self.name.text = newValue.author
            self.comment.attributedText = newValue.commentAtrString
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.name.text = nil
        self.comment.attributedText = nil
        self.photoComment = nil
    }
}
