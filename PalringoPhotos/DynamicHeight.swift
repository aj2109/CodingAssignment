//
//  DynamicHeight.swift
//  PalringoPhotos
//
//  Created by Adam Jessop on 21/02/2021.
//  Copyright © 2021 Palringo. All rights reserved.
//

import UIKit

protocol DynamicHeight {
    
    func getHeight(comment: String, width: CGFloat, padding: CGFloat) -> CGFloat
    
}

extension DynamicHeight {
    
    //the comments contain HTML,sometimes images, and don't seem to have a character limit, so this is used to determine what height is necessary for them.  Used a protocol so it could be easily transferred to other classes were it necessary.
    
    func getHeight(comment: String, width: CGFloat, padding: CGFloat = 0) -> CGFloat {
        let attrString = comment.toAttributedHTML()
        
        let textStorage = NSTextStorage(attributedString: attrString)
        
        let textContainer = NSTextContainer(size: CGSize(width: width, height: 0))
        textContainer.maximumNumberOfLines = 0
        textContainer.lineFragmentPadding = 0
        
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        return layoutManager.usedRect(for: textContainer).size.height.rounded(.up) + padding
    }
    
}
