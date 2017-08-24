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
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var removeButton: UIBarButtonItem!
    
    var dismissBlock: (() -> Void)?
    var createMode = false
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    var item:Item? {
        didSet {
           self.navigationItem.title = item?.itemName
        }
    }
    
    func cancelAndBack() {
        print("doneAndBack")
        if let item = self.item {
            ItemStore.shared.allItems.remove(object: item)
        }
        self.view.endEditing(true)
        self.presentingViewController?.dismiss(animated: true, completion: self.dismissBlock)
    }
    
    func doneAndBack() {
        print("doneAndBack")
        saveEdit()
        self.view.endEditing(true)
        self.presentingViewController?.dismiss(animated: true, completion: self.dismissBlock)
    }
    
    func saveEdit() {
        if let newItem = self.item {
            newItem.itemName = nameField.text ?? ""
            newItem.serialNumber = serialField.text ?? ""
            newItem.valueInDollars = Int(valueField.text ?? "") ?? 0
            print("saveEdit \(newItem)")
        }
    }
    
    func onOrientationChange() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return
        }
        print("onOrientationChange")
        if UIDevice.current.orientation.isLandscape {
            self.imageView.isHidden = true
            self.cameraButton.isEnabled = false
        } else {
            self.imageView.isHidden = false
            self.cameraButton.isEnabled = true
        }
    }
    
    func bindViews() {
        if let item = self.item {
            print("bindViews \(item)")
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
    
    func bindImage() {
        print("bindImage")
        if let item = self.item {
            self.imageView.image = ImageStore.shared.image(forKey: item.key)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.createMode {
            let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAndBack))
            let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAndBack))
            self.navigationItem.rightBarButtonItem = done
            self.navigationItem.leftBarButtonItem = cancel
        } else {
            let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAndBack))
            self.navigationItem.rightBarButtonItem = done
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        self.onOrientationChange()
        self.bindViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
        self.view.endEditing(true)
        if let item = self.item {
            ImageStore.shared.removeImage(forKey: item.key)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.onOrientationChange()
    }
    
    // MARK: IBActions
    
    @IBAction func backgroundTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func takePicture(_ sender: Any) {
        saveEdit()
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if imagePicker.sourceType == .photoLibrary {
                imagePicker.modalPresentationStyle = .popover
            }
            if let pop = imagePicker.popoverPresentationController {
                print("image picker, using popover")
                pop.barButtonItem = self.cameraButton
                pop.permittedArrowDirections = .any
            }
        }
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func removePicture(_ sender: Any) {
        saveEdit()
        if let item = self.item {
            ImageStore.shared.removeImage(forKey: item.key)
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
            ImageStore.shared.setImage(image: image, forKey: item.key)
        } else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage,
            let item = self.item {
            print("Picked original image: \(image)")
            ImageStore.shared.setImage(image: image, forKey: item.key)
        }
        picker.dismiss(animated: true) { [weak self] in
            self?.bindImage()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) { [weak self] in
            self?.bindImage()
        }
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
