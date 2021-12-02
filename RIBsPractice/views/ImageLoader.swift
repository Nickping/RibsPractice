//
//  ImageLoader.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/02.
//

import UIKit


class ImageLoader {
        
    static func getImage(from url: String, completion: @escaping ((UIImage) -> Void)) {
        
        if let cachedImage = ImageCache.instance.cache[url] {
            completion(cachedImage)
        }
        
        guard let url = URL(string: url) else {
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
}

class ImageCache {
    
    var cache: [String: UIImage] = [:]
    
    static let instance: ImageCache = {
        return ImageCache()
    }()
    
    private init() {}
    

}


