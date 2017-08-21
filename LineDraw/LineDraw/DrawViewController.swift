//
//  ViewController.swift
//  TouchTracker
//
//  Created by Xiaoke Zhang on 2017/8/17.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit
import SnapKit

class DrawViewController: UIViewController {
    var drawView: DrawView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
        self.drawView = DrawView(frame:UIScreen.main.bounds)
        self.view.addSubview(self.drawView)
        self.drawView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("viewWillTransition to \(size) with \(coordinator)")
        self.view = DrawView(frame:UIScreen.main.bounds)
    }
}

