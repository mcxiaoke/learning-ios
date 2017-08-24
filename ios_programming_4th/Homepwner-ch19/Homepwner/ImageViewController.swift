//
//  ImageViewController.swift
//  Homepwner
//
//  Created by Xiaoke Zhang on 2017/8/24.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var image: UIImage?
    
    override func loadView() {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        self.view = iv
//        self.scrollView = UIScrollView()
//        self.scrollView.delegate = self
//        self.scrollView.minimumZoomScale = 0.5
//        self.scrollView.maximumZoomScale = 5.0
//        self.view = self.scrollView
//        self.imageView = UIImageView()
//        self.imageView.contentMode = .scaleAspectFit
//        self.view.addSubview(self.imageView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let imageView = self.view as? UIImageView {
            imageView.image = image
        }
    }
    
}

extension ImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
