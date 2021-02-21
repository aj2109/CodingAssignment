//
//  CachedRequest.swift
//  PalringoPhotos
//
//  Created by Benjamin Briggs on 14/10/2016.
//  Copyright © 2016 Palringo. All rights reserved.
//

import UIKit

//changed this to struct as it isn't using any inheritance
struct CachedRequest {
    
    static let cache = URLCache(memoryCapacity: 40 * 1024 * 1024,
                                diskCapacity: 512 * 1024 * 1024,
                                diskPath: "urlCache")
    
    static func request(url: URL, completion: @escaping (Data?, Bool)->()) -> URLSessionTask? {
        let request = URLRequest(url: url,
                                 cachePolicy: .returnCacheDataElseLoad,
                                 timeoutInterval: 100)
        
        if let cacheResponse = cache.cachedResponse(for: request) {
            completion(cacheResponse.data, true)
            return nil
        } else {
            let config = URLSessionConfiguration.default
            
            config.urlCache = cache
            
            let session = URLSession(configuration: config)
            
            let task = session.dataTask(with: request, completionHandler: { data, response, error in
                if let response = response, let data = data {
                    let cacheResponse = CachedURLResponse(response: response,data: data)
                    URLCache.shared.storeCachedResponse(cacheResponse,for: request)
                }
                
                completion(data, false)
            })
            task.resume()
            return task
        }
    }
    
    //only used once in this app, but if this were to be a larger app it would likely be used multiple times, so I have moved this out, also to keep the view (cell in this case) quite lightweight
    static func cachedImageDownload(view: UIView, imageView: UIImageView, url: URL, animationType: UIView.AnimationOptions = .transitionCrossDissolve) -> URLSessionTask? {
        return CachedRequest.request(url: url) { data, isCached in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                let img = UIImage(data: data)
                if isCached {
                    imageView.image = img
                } else {
                    UIView.transition(with: view, duration: 1, options: animationType, animations: {
                        imageView.image = img
                    }, completion: nil)
                }
            }
        }
    }
    
}
