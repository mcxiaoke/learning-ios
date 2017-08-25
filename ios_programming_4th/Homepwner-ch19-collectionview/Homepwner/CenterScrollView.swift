//
//  CenterScrollView.swift
//  Homepwner
//
//  Created by Xiaoke Zhang on 2017/8/24.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

class CenterScrollView: UIScrollView {
    
    var containerView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("CenterScrollView init frame=\(frame)")
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setContentOffset(_ contentOffset: CGPoint, animated: Bool) {
        var offset = contentOffset
        if let cv = self.containerView {
            let csize = cv.frame.size
            let ssize = self.bounds.size
            if csize.width < ssize.width {
                offset.x = -(ssize.width - csize.width)/2.0
                offset.y = -(ssize.height - csize.height)/2.0
            }
        }
        print("CenterScrollView setContentOffset offset=\(contentOffset)")
        super.contentOffset = offset
    }
    
}

extension CenterScrollView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.containerView
    }
    
    
    
}
