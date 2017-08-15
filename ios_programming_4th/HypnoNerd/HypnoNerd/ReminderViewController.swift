//
//  ReminderViewController.swift
//  HypnoNerd
//
//  Created by Xiaoke Zhang on 2017/8/15.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

class ReminderViewController: UIViewController {
    
    @IBOutlet weak var datePicker:UIDatePicker!
    @IBOutlet weak var colorPicker:UISegmentedControl!
    
    @IBAction func addReminder(_ sender:AnyObject) {
        let date = datePicker.date
        print("Setting a reminder at \(date)")
        let note = UILocalNotification()
        note.alertBody = "Hypnotize Me!"
        note.fireDate = date
        UIApplication.shared.scheduleLocalNotification(note)
    }
    
    @IBAction func setColor(_ sender:AnyObject) {
        setCircleColor()
    }
    
    func setCircleColor() {
        let index = colorPicker.selectedSegmentIndex
        let colors = [UIColor.red, UIColor.green, UIColor.blue]
        print("Set color index to \(index)")
        guard let vc = self.tabBarController?.viewControllers?[0] else { return }
        guard let hv = vc.view as? HypnosisterView else { return }
        hv.circleColor = colors[index]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCircleColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        datePicker.minimumDate = Date()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.tabBarItem.title = "Reminder"
        self.tabBarItem.image = UIImage(named:"Time.png")
    }
    
    
}
