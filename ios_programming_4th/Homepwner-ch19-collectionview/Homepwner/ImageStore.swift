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
    
    var thumbSize = CGSize(width: 80, height: 80)
    private var images: [String: UIImage] = [:]
    private var thumbs: [String: UIImage] = [:]
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(clearCache(noti:)),
                                               name: .UIApplicationDidReceiveMemoryWarning,
                                               object: nil)
    }
    
    @objc func clearCache(noti: Notification) {
        images.removeAll()
    }
    
    lazy var placeholder = UIImage(named: "placeholder.jpg")?.getThumb(ImageStore.shared.thumbSize, rounded: false)
    lazy var placeholder2 = UIImage(named: "placeholder2.jpg")?.getThumb(ImageStore.shared.thumbSize, rounded: false)
    
    func thumb(forKey key: String) -> UIImage? {
        if let thumb = thumbs[key] {
            return thumb
        } else {
            let _ = image(forKey: key)
            return thumbs[key]
        }
    }
    
    func image(forKey key: String) -> UIImage? {
        if let image =  images[key] {
            return image
        } else {
            let path = imagePath(forKey: key)
            if let newImage = UIImage(contentsOfFile: path.path) {
                images[key] = newImage
                thumbs[key] = newImage.getThumb(thumbSize)
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
        return documents.appendingPathComponent("\(key).jpg")
    }
    
    func setImage(image: UIImage, forKey key:String){
        let path = imagePath(forKey: key)
        images[key] = image
        thumbs[key] = image.getThumb(thumbSize)
        guard let data = UIImageJPEGRepresentation(image, 0.9) else { return }
        do {
            try data.write(to: path, options: .atomic)
            print("setImage write success")
        } catch {
            print("setImage write error=\(error)")
        }
    }
    
    func removeImage(forKey key:String) {
        print("removeImage for key: \(key)")
        images[key] = nil
    }
    
    func save() {
        
    }
    
    
    
}
