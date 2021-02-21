//
//  AlertHelper.swift
//  PalringoPhotos
//
//  Created by Adam Jessop on 21/02/2021.
//  Copyright © 2021 Palringo. All rights reserved.
//

import UIKit

protocol AlertShowing {
    
    //I wanted to make this generic, but I could not get photographers to show allCases when it was generic so have this instead - but thought I would leave the commented out generics code where I to go into it that way
        
    // func showAlert<T>(presenter: UIView, completion: @escaping (T)->())
    
    //extension AlertShowing where Self: PhotoCollectionViewController {
    
    // func showAlert<Photographers>(presenter: UIView, completion: @escaping (Photographers)->()) { ... }
    
    // }
    
    func showPhotographerAlert(presenter: UIViewController, completion: @escaping (Photographers)->())

}

extension AlertShowing {
    
    //show all the photographers names in an alert, and pass out the chosen one.  I elaborate on this being a piece of UI I would like to improve were there more time in the Read Me file.
    
    func showPhotographerAlert(presenter: UIViewController, completion: @escaping (Photographers)->()) {
        let alertController = UIAlertController(title: "Please choose your photographer", message: "", preferredStyle: .alert)
        
        for photographer in Photographers.allCases {
            alertController.addAction(UIAlertAction(title: photographer.rawValue, style: .default, handler: { (_) in
                completion(photographer)
            }))
        }
        presenter.present(alertController, animated: true, completion: nil)
    }
    
}
