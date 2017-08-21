//
//  ImageStore.swift
//  Homepwner
//
//  Created by Xiaoke Zhang on 2017/8/17.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

class ImageStore: AnyObject {
    static let shared = ImageStore()
    
    private var images:[String:UIImage] = [:]
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(clearCache(noti:)), name: .UIApplicationDidReceiveMemoryWarning, object: nil)
    }
    
    @objc func clearCache(noti: Notification) {
        print("low memory, clear cache")
        images.removeAll()
    }
    
    func image(forKey key: String) -> UIImage? {
        if let image =  images[key] {
            return image
        } else {
            let path = imagePath(forKey: key)
            if let newImage = UIImage(contentsOfFile: path.path) {
                images[key] = newImage
                return newImage
            }
        }
        return nil
    }
    
    func imagePath(forKey key: String) -> URL {
        let documents = try! FileManager.default.url(for: .documentDirectory,
                                                in: .userDomainMask,
                                                appropriateFor: nil,
                                                create: true)
        return documents.appendingPathComponent(key)
    }
    
    func setImage(image:UIImage, forKey key:String) {
        let path = imagePath(forKey: key)
//        try? UIImagePNGRepresentation(image)?.write(to: path, options: .atomicWrite)
        try? UIImageJPEGRepresentation(image, 0.8)?.write(to: path, options: .atomicWrite)
    }
    
    func removeImage(forKey key:String) {
        let path = imagePath(forKey: key)
        try? FileManager.default.removeItem(at: path)
    }
    
    func save() {
        
    }
    
    
    
}
