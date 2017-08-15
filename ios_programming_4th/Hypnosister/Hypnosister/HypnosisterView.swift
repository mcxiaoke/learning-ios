//
//  HypnosisterView.swift
//  Hypnosister
//
//  Created by Xiaoke Zhang on 2017/8/15.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

class HypnosisterView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func drawSingleCircle(){
        let bounds = self.bounds
        var center = CGPoint()
        center.x = bounds.origin.x + bounds.size.width/2.0;
        center.y = bounds.origin.y + bounds.size.height/2.0;
        let radius = min(bounds.size.width, bounds.size.height)/2.0;
        let path = UIBezierPath()
        path.addArc(withCenter: center, radius: radius, startAngle: 0.0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        path.lineWidth = 10
        UIColor.lightGray.setStroke()
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
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
        UIColor.lightGray.setStroke()
        path.stroke()
        
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.saveGState()
        ctx?.setShadow(offset: CGSize(width:6, height:8), blur: 4)
        let image = UIImage(named: "bluetooth.png")!
        image.draw(in: bounds)
        ctx?.restoreGState()
        
        
    }
    
}
