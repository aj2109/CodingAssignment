//
//  PalingroPhotoTests.swift
//  PalringoPhotosTests
//
//  Created by Adam Jessop on 21/02/2021.
//  Copyright © 2021 Palringo. All rights reserved.
//

import XCTest
import PalringoPhotos

class PalingroPhotoTests: XCTestCase, DynamicHeight {
    
    
    override func setUpWithError() throws {
        
        self.htmlString = "<meta name='description' content='The World's On-Line Festival (WOLF) brings the magic of real-world festivals to the online world, uniting people across the globe in discovery, entertainment, and belonging.'>"
        
        self.nonHtmlString = "This is a non HTML string, feel free to replace this with a similar string for testing."
        
        self.image = #imageLiteral(resourceName: "WOLFLogo")
        
        self.navigationItem = UINavigationItem()
        
        self.smallTextForHeight = "Lorem ipsum dolor sit amet"
        
        self.mediumTextForHeight = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
        
        self.largeTextForHeight = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        self.textViewWidth = 100
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    var htmlString: String?
    var nonHtmlString: String?
    
    //This test shows the string being changed into data / HTML in the case of the HTML String, but being left as a standard string for the non-HTML one.
    func testHTMLDecoder() {
        guard let htmlString = htmlString, let nonHTMLString = nonHtmlString else {
            XCTFail("[Test failed] - Something in setup went wrong! Test: \(#function)")
            return
        }
        let htmlAttributedString = htmlString.toAttributedHTML()
        XCTAssert(htmlAttributedString.string == "")
        let nonHTMLAttributedString = nonHTMLString.toAttributedHTML()
        XCTAssert(nonHTMLAttributedString.string != "")
    }
    
    var image: UIImage?
    var navigationItem: UINavigationItem?
    
    //This test shows that the navbar items are not there originally, but after adding in them to all 3 places they are no longer nil and so the function has worked.
    func testNavbarImageAddition() {
        guard let navigationItem = navigationItem, let image = image else {
            XCTFail("[Test failed] - Something in setup went wrong! Test: \(#function)")
            return
        }
        XCTAssert(navigationItem.leftBarButtonItem?.customView == nil)
        XCTAssert(navigationItem.titleView == nil)
        XCTAssert(navigationItem.rightBarButtonItem == nil)
        for location in Location.allCases {
            navigationItem.addImage(image: image, location: location, size: CGSize(width: 10, height: 10))
        }
        XCTAssert(navigationItem.leftBarButtonItem?.customView != nil)
        XCTAssert(navigationItem.titleView != nil)
        XCTAssert(navigationItem.rightBarButtonItem != nil)
    }
    
    var largeTextForHeight: String?
    var mediumTextForHeight: String?
    var smallTextForHeight: String?
    var textViewWidth: CGFloat?
    
    //testing three different strings to make sure that the height function gives the largest string as the largest height for the same given
    func testDynamicHeight() {
        guard
            let largeTextForHeight = largeTextForHeight,
            let mediumTextForHeight = mediumTextForHeight,
            let smallTextForHeight = smallTextForHeight,
            let textViewWidth = textViewWidth else {
            XCTFail("[Test failed] - Something in setup went wrong! Test: \(#function)")
            return
        }
        let heightForLargerText = getHeight(comment: largeTextForHeight, width: textViewWidth)
        let heightForMediumText = getHeight(comment: mediumTextForHeight, width: textViewWidth)
        let heightForSmallerText = getHeight(comment: smallTextForHeight, width: textViewWidth)
        XCTAssert(heightForLargerText > heightForMediumText)
        XCTAssert(heightForMediumText > heightForSmallerText)
    }

}

