//
//  CommentsDataSource.swift
//  PalringoPhotos
//
//  Created by Adam Jessop on 21/02/2021.
//  Copyright © 2021 Palringo. All rights reserved.
//

import UIKit

private let commentsReuseIdentifier = "CommentCell"

class CommentsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, DynamicHeight {

    var comments: [PhotoComment]?
    
    func downloadComments(photo: Photo, completion: @escaping (_ comments: [PhotoComment])->()) {
        FlickrFetcher().getPhotoComments(for: photo) { [weak self] (comments) in
            guard let self = self else {
                return
            }
            var attributedComments = [PhotoComment]()
            for comment in comments {
                var comment = comment
                comment.commentAtrString = comment.comment.toAttributedHTML()
                attributedComments.append(comment)
            }
            self.comments = attributedComments
            completion(comments)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commentsReuseIdentifier, for: indexPath) as! CommentCell
        cell.photoComment = comments?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let comments = comments,comments.count > indexPath.row else {
            return 0
        }
        let comment = comments[indexPath.row].comment
        let cellHeight = getHeight(comment: comment, width: UIScreen.main.bounds.width - 230, padding: 20) //230 = size of commenter's name label + the 2 spacers in the cell
        return cellHeight > 50 ? cellHeight : (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? 100 : 50)
    }
    
    
    
}
