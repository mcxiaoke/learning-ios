//
//  HypnosisterView.swift
//  Hypnosister
//
//  Created by Xiaoke Zhang on 2017/8/15.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

class HypnosisterView: UIView {
    
    var circleColor = UIColor.lightGray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        print("init")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        print("init")
    }
    
    override func draw(_ rect: CGRect) {
        print("draw")
        let bounds = self.bounds
        var center = CGPoint()
        center.x = bounds.origin.x + bounds.size.width/2.0;
        center.y = bounds.origin.y + bounds.size.height/2.0;
        let maxRadius = hypot(bounds.size.width, bounds.size.height)/2.0;
        let path = UIBezierPath()
        
        var currentRadius = maxRadius
        while currentRadius>0 {
            path.move(to: CGPoint(x:center.x+currentRadius, y:center.y))
            path.addArc(withCenter: center,
                        radius: currentRadius,
                        startAngle: 0.0,
                        endAngle: CGFloat(Double.pi*2),
                        clockwise: true)
            currentRadius -= 20
        }
        path.lineWidth = 10
        circleColor.setStroke()
        path.stroke()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
        let red = CGFloat(arc4random_uniform(100))/100.0
        let green = CGFloat(arc4random_uniform(100))/100.0
        let blue = CGFloat(arc4random_uniform(100))/100.0
        let color = UIColor(red:red, green:green, blue:blue, alpha:1.0)
        self.circleColor = color
    }
    
}
