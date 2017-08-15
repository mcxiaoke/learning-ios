//
//  ViewController.swift
//  Hypnosister
//
//  Created by Xiaoke Zhang on 2017/8/15.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var frame = self.view.bounds
        var bigFrame = frame
        bigFrame.size.width *= 2.0
        //bigFrame.size.height *= 2.0
        let sv = UIScrollView(frame:frame)
        let v1 = HypnosisterView(frame:frame)
        //v1.circleColor = UIColor.blue
        frame.origin.x += frame.size.width
        let v2 = HypnosisterView(frame:frame)
        //v2.circleColor = UIColor.red
        sv.addSubview(v1)
        sv.addSubview(v2)
        self.view.addSubview(sv)
        self.view.backgroundColor = UIColor.white
        sv.contentSize = bigFrame.size
        //sv.isPagingEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

