//
//  StringHelper.swift
//  PalringoPhotos
//
//  Created by Adam Jessop on 21/02/2021.
//  Copyright © 2021 Palringo. All rights reserved.
//

import UIKit

extension String {
    
    //The comments frequently contain HTML so this extension is to deal with that
    
    //Did some checks of the comment contents to filter out the non-html comments so the app didn't slow down as much when loading the comments
    func toAttributedHTML() -> NSAttributedString {
        guard self.contains("<") || self.contains("&") || self.contains("[") else {
            return NSMutableAttributedString(string: self)
        }
        
        let htmlData = NSString(string: self).data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        //attempted to make it into HTML, the alternative is it just returns the original string that is being used
        if let attributedString = try? NSMutableAttributedString(data: htmlData ?? Data(), options: options,documentAttributes: nil) {
            
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,
                                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)],
                                           range: NSRange(location: 0,
                                                          length: attributedString.length)
            )
            return attributedString
        } else {
            return NSMutableAttributedString(string: self)
        }
    }
    
}
