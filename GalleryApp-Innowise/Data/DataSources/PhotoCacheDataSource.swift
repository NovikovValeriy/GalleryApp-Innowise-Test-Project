//
//  PhotoCacheDataSource.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

import Foundation

final class PhotoCacheDataSource {
    private let imageCache: NSCache<NSString, NSData> = NSCache<NSString, NSData>()
    
    func getImageData(for url: String) -> Data? {
        let key = url as NSString
        return imageCache.object(forKey: key) as? Data
    }
    
    func setImageData(data: Data, for url: String) {
        imageCache.setObject(data as NSData, forKey: url as NSString)
    }
}
