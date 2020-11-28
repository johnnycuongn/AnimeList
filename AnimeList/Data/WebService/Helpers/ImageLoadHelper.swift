//
//  ImageLoad.swift
//  AnimeList
//
//  Created by Johnny on 14/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

let imageToCache = NSCache<NSURL, UIImage>()

extension UIImageView {
    
    func loadUsingCache(with url: URL) {
        self.image = nil
        if let cachedImage = imageToCache.object(forKey: url as NSURL) {
            self.image = cachedImage
            return
        }
        else {
            URLSession(configuration: .ephemeral).dataTask(with: url) { (data, response, error) in
                guard let data = data, let downloadImage = UIImage(data: data) else {return}

                DispatchQueue.main.async {
                    self.image = downloadImage
                    imageToCache.setObject(downloadImage, forKey: url as NSURL)
                }

            }.resume()
        }

    }
    
    
}
