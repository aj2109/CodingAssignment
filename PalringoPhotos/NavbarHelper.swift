//
//  CustomisableNav.swift
//  PalringoPhotos
//
//  Created by Adam Jessop on 21/02/2021.
//  Copyright © 2021 Palringo. All rights reserved.
//

import UIKit

extension UINavigationItem {
    
    //This extension is for modifications to the navbar, only will be using this once for the left, but wanted it to be usable in all places in the navbar were it required. I elaborate on how I would like to change the navbar generally in my Read Me file.
    
    func addImage(image: UIImage, location: Location, size: CGSize) {
        let overallView = UIView()
        NSLayoutConstraint.activate([
            overallView.widthAnchor.constraint(equalToConstant: size.width),
            overallView.heightAnchor.constraint(equalToConstant: size.height)
        ])
        
        let spacerVIew = UIView()
        overallView.addSubview(spacerVIew)
        spacerVIew.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spacerVIew.heightAnchor.constraint(equalToConstant: 8),
            spacerVIew.bottomAnchor.constraint(equalTo: overallView.bottomAnchor),
            spacerVIew.leadingAnchor.constraint(equalTo: overallView.leadingAnchor),
            spacerVIew.trailingAnchor.constraint(equalTo: overallView.trailingAnchor)
        ])
        
        let logoImageView = UIImageView(image: image)
        logoImageView.contentMode = .scaleAspectFit
        
        overallView.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: overallView.topAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: spacerVIew.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: overallView.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: overallView.trailingAnchor)
        ])
        let imageItem = UIBarButtonItem(customView: overallView)
        
        switch location {
        case .left:
            self.leftBarButtonItem = imageItem
        case .middle:
            self.titleView = logoImageView
        case .right:
            self.rightBarButtonItem = imageItem
        }
    }
    
}

enum Location: CaseIterable {
    
    case left
    case middle
    case right
    
}
