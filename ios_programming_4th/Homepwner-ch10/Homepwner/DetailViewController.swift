//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Xiaoke Zhang on 2017/8/17.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serialField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    var item:Item? {
        didSet {
           self.navigationItem.title = item?.itemName
        }
    }
    
    func endEdit() {
        self.view.endEditing(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(endEdit))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let item = self.item {
            nameField.text = item.itemName
            serialField.text = item.serialNumber
            valueField.text = String(format:"%d", item.valueInDollars)
            let df = DateFormatter()
            df.dateStyle = .medium
            df.timeStyle = .none
            dateLabel.text = df.string(from: item.dateCreated)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        guard var newItem = self.item else { return }
        newItem.itemName = nameField.text ?? ""
        newItem.serialNumber = serialField.text ?? ""
        newItem.valueInDollars = Int(valueField.text ?? "") ?? 0
        ItemStore.shared.replace(newItem: newItem)
    }
}

extension DetailViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.returnKeyType == .done
    }
}
