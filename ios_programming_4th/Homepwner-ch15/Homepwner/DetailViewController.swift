//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Xiaoke Zhang on 2017/8/17.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//
/**
 
 autolayout debug
 https://medium.com/ios-os-x-development/auto-layout-debugging-in-swift-93bcd21a4abf
 for objc: po [[UIWindow keyWindow] _autolayoutTrace]
 for swift: expr -l objc++ -O -- [[UIWindow keyWindow] _autolayoutTrace]
 
 **/

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serialField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toolBar: UIToolbar!
    
    var item:Item? {
        didSet {
           self.navigationItem.title = item?.itemName
        }
    }
    
    func doneAndBack() {
        print("doneAndBack")
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneAndBack))
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
            self.imageView.image = ImageStore.shared.image(forKey: item.key)
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
    
    // MARK: IBActions
    
    @IBAction func backgroundTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func takePicture(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            let x = self.view.bounds.width/2
            let y = self.view.bounds.height/2
            let ov = UILabel(frame:CGRect(x:x, y:y, width:80, height:80))
            ov.font = UIFont.systemFont(ofSize: 40)
            ov.textAlignment = .center
            ov.textColor = UIColor.yellow
            ov.text = "+"
            ov.sizeToFit()
            var frame = ov.frame
            frame.origin.x -= frame.width/2
            frame.origin.y -= frame.height/2
            ov.frame = frame
            imagePicker.cameraOverlayView = ov
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func removePicture(_ sender: Any) {
        if let item = self.item {
            ImageStore.shared.removeImage(item.key)
            self.imageView.image = nil
        }
    }
}

extension DetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        print("Picked image: \(info)")
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage,
            let item = self.item {
            print("Picked edited image: \(image)")
            ImageStore.shared.addImage(key: item.key, image: image)
        } else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage,
            let item = self.item {
            print("Picked original image: \(image)")
            ImageStore.shared.addImage(key: item.key, image: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done {
            textField.resignFirstResponder()
            return true
        } else if textField.returnKeyType == .next {
            // impl next action
            if textField.tag == 1 {
                textField.resignFirstResponder()
                self.view.viewWithTag(2)?.becomeFirstResponder()
            } else if textField.tag == 2 {
                textField.resignFirstResponder()
                self.view.viewWithTag(3)?.becomeFirstResponder()
            }
            return false
        } else {
            return  false
        }
    }
}
