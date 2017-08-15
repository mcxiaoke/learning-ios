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
    
    @IBAction func addReminder(_ sender:AnyObject) {
        let date = datePicker.date
        print("Setting a reminder at \(date)")
        let note = UILocalNotification()
        note.alertBody = "Hypnotize Me!"
        note.fireDate = date
        UIApplication.shared.scheduleLocalNotification(note)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
