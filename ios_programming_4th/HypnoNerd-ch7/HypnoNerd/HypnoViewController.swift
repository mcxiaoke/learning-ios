//
//  HypnoViewController.swift
//  HypnoNerd
//
//  Created by Xiaoke Zhang on 2017/8/15.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

class HypnoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        let hv = HypnosisterView()
        let tf = CGRect(x:40, y:70, width:240, height:30)
        let tv = UITextField(frame: tf)
        tv.spellCheckingType = .no
        tv.autocorrectionType = .no
        tv.autocapitalizationType = .none
        tv.borderStyle = .roundedRect
        tv.placeholder = "Hypnotize Me"
        tv.returnKeyType = .done
        tv.delegate = self
        hv.addSubview(tv)
        self.view = hv
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.tabBarItem.title = "Hypnotize"
        self.tabBarItem.image = UIImage(named:"Hypno.png")
    }
    
    func drawHypnoticMessage(message:String) {
        for i in 1..<20 {
            let lb = UILabel()
            lb.backgroundColor = UIColor.clear
            lb.textColor = UIColor.black
            lb.text = message
            lb.sizeToFit()
            
            let width = Int(self.view.bounds.size.width - lb.bounds.size.width)
            let x = Int(arc4random()) % width
            let height = Int(self.view.bounds.size.height - lb.bounds.size.height)
            let y = Int(arc4random()) % height
            
            var frame = lb.frame
            frame.origin = CGPoint(x:x, y:y)
            lb.frame = frame
            
            self.view.addSubview(lb)
            
            // add motion effects
            let effect1 = UIInterpolatingMotionEffect(keyPath:"center.x", type:.tiltAlongHorizontalAxis)
            effect1.minimumRelativeValue = -25
            effect1.maximumRelativeValue = 25
            lb.addMotionEffect(effect1)
            
            let effect2 = UIInterpolatingMotionEffect(keyPath:"center.y", type:.
                tiltAlongVerticalAxis)
            effect2.minimumRelativeValue = -25
            effect2.maximumRelativeValue = 25
            lb.addMotionEffect(effect2)
            
        }
    }
}

extension HypnoViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        //
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text)")
        if let message = textField.text {
            drawHypnoticMessage(message: message)
            textField.text = ""
            textField.resignFirstResponder()
        }
        return true
    }
}
