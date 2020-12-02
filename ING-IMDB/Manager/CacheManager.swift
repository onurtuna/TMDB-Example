//
//  CacheManager.swift
//  ING-IMDB
//
//  Created by Onur Tuna on 1.12.2020.
//

import UIKit

class CacheManager {
    
    private let imageQueue = DispatchQueue(label: "cacheImageQueue")
    
    static let shared = CacheManager()
    let cache = NSCache<NSString, UIImage>()
    
    init() {
        
    }
    
    func cacheImage(image: UIImage, identifier: String) {
        imageQueue.async {
            self.cache.setObject(image, forKey: identifier as NSString)
        }
    }
    
    func getImage(identifier: String) -> UIImage? {
        var image: UIImage?
        imageQueue.async {
            image = self.cache.object(forKey: identifier as NSString)
        }
        return image
    }
    
}
