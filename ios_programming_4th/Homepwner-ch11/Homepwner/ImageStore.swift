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
    
    func image(forKey key: String) -> UIImage? {
        return images[key]
    }
    
    func addImage(key:String, image:UIImage) {
        images[key] = image
    }
    
    func removeImage(_ forKey:String) {
        images.removeValue(forKey: forKey)
    }
    
    
}
