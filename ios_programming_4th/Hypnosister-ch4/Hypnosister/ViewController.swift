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
//        let firstFrame = CGRect(x:160, y:240, width: 100, height: 150)
        let firstFrame = self.view.bounds
        let sv1 = HypnosisterView(frame:firstFrame)
//        sv1.backgroundColor = UIColor.red
        self.view.addSubview(sv1)
        
        let secondFrame = CGRect(x:20, y:30, width:50, height:50)
        let sv2  = HypnosisterView(frame:secondFrame)
        sv2.backgroundColor = UIColor.blue
//        sv1.addSubview(sv2)
//        self.view.addSubview(sv2)
        
        self.view.backgroundColor = UIColor.white
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

