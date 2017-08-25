//
//  UIImage+Extension.swift
//  Homepwner
//
//  Created by Xiaoke Zhang on 2017/8/24.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

extension UIImage {

    func getThumb(_ size: CGSize = CGSize(width: 80, height: 80),
                  rounded: Bool = false) -> UIImage {
        let w = size.width + 2
        let h = size.height + 2
        let oldSize = self.size
        let newSize = CGRect(x: 0, y: 0, width: w, height: h)
        let ratio = max(newSize.width / oldSize.width, newSize.height / oldSize.height)
        UIGraphicsBeginImageContext(newSize.size)
        if rounded {
            let path = UIBezierPath(roundedRect: newSize, cornerRadius: w / 10)
            path.addClip()
        }
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
