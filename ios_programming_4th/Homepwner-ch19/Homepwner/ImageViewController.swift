//
//  ImageViewController.swift
//  Homepwner
//
//  Created by Xiaoke Zhang on 2017/8/24.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit
import SnapKit

class ImageViewController: UIViewController {
    
    var scrollView: CenterScrollView!
    var imageView: UIImageView!
    var image: UIImage?
    
    override func loadView() {
        let sv = CenterScrollView()
        sv.zoomScale = 1.0
        sv.minimumZoomScale = 0.2
        sv.maximumZoomScale = 6.0
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.bouncesZoom = true
        self.scrollView = sv
        self.view = sv
        
        self.imageView = UIImageView()
        self.imageView.contentMode = .topLeft
        self.scrollView.containerView = self.imageView
        self.view.addSubview(self.imageView)
        
        self.imageView.center.equalTo(self.view.center)
        self.imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.image = image
        print("scrollview bounds=\(self.scrollView.bounds)")
        print("imageview bounds=\(self.imageView.bounds)")
        if let image = self.image {
            print("image size=\(image.size)")
            self.scrollView.contentSize = image.size
        } else {
            self.scrollView.contentSize = self.scrollView.bounds.size
        }
    }
    
    func centerContent() {
        let boundsSize = self.view.bounds.size
        var frameToCenter = self.imageView.frame
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        self.view.frame = frameToCenter
    }
    
}
