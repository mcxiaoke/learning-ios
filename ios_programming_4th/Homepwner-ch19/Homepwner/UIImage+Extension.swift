//
//  UIImage+Extension.swift
//  Homepwner
//
//  Created by Xiaoke Zhang on 2017/8/24.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

extension UIImage {

    func getThumb() -> UIImage {
        let oldSize = self.size
        let newSize = CGRect(x: 0, y: 0, width: 40, height: 40)
        let ratio = max(newSize.width / oldSize.width, newSize.height / oldSize.height)
        UIGraphicsBeginImageContext(newSize.size)
        let path = UIBezierPath.init(roundedRect: newSize, cornerRadius: 5.0)
        path.addClip()
        var projectRect = CGRect.zero
        projectRect.size.width = ratio * oldSize.width
        projectRect.size.height = ratio * oldSize.height
        projectRect.origin.x = (newSize.width - projectRect.width) / 2.0
        projectRect.origin.y = (newSize.height - projectRect.height) / 2.0
        self.draw(in: projectRect)
        let thumb = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return thumb
    }
}
