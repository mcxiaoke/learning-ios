//
//  ViewController.swift
//  Homepwner
//
//  Created by Xiaoke Zhang on 2017/8/16.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet weak var thumbView: UIImageView!
    @IBOutlet weak var thumbButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var item: Item?
    var thumbClickBlock: ((String)->Void)?
    var imagePopover: UIPopoverPresentationController?
    
    @IBAction func showImage(_ sender: Any?) {
        if let item = self.item {
            thumbClickBlock?(item.key)
        }
    }
    
    func config(_ item: Item) {
        self.item = item
        self.nameLabel.text = item.itemName
        self.serialLabel.text = item.serialNumber
        self.valueLabel.text = "$\(item.valueInDollars)"
        self.valueLabel.textColor = item.valueInDollars > 50 ? UIColor.green : UIColor.red
        self.thumbView.image = ImageStore.shared.thumb(forKey: item.key)
    }
}

class ItemsViewController: UITableViewController {
    
    @IBOutlet var headerView:UIView!
    
    @IBAction func addNewItem(_ sender: AnyObject) {
        print("addNewItem")
        let newItem = ItemStore.shared.createItem()
        let lastRow = ItemStore.shared.allItems.index(of:newItem) ?? 0
        let indexPath = IndexPath(row:lastRow, section:0)
        tableView.insertRows(at: [indexPath], with: .none)
        let detailVC = DetailViewController()
        detailVC.item = newItem
        detailVC.createMode = true
        showModalViewController(vc: detailVC)
    }
    
    @IBAction func toggleEditMode(_ sender: AnyObject) {
        print("toggleEditMode \(self.isEditing)")
        guard let v = sender as? UIButton else { return }
        if self.isEditing {
            v.setTitle("Edit", for: .normal)
            self.isEditing = false
        } else {
            v.setTitle("Done", for: .normal)
            self.isEditing = true
        }
    }
    
    init() {
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ItemCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ItemCell")
        self.navigationItem.title = "Homepwner"
        let newButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem(_:)))
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = newButtonItem
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.cellLayoutMarginsFollowReadableWidth = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemStore.shared.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
//        if indexPath.row == ItemStore.shared.allItems.count {
//            cell.textLabel?.textAlignment = .center
//            cell.textLabel?.text = "No more items!"
//        } else {
            let item = ItemStore.shared.allItems[indexPath.row]
            print("\(item) at \(indexPath.row)")
            cell.config(item)
        cell.thumbClickBlock = { [weak self, weak cell] key in
            guard let cell = cell else { return }
            self?.showImageViewController(key, at: cell)
        }
//        }
        return cell
    }
    
    func showImageViewController(_ key: String, at cell: ItemCell) {
        guard let image = ImageStore.shared.image(forKey: key) else { return }
        let ivc = ImageViewController()
        ivc.image = image
        if UIDevice.current.userInterfaceIdiom == .pad {
            ivc.preferredContentSize = CGSize(width: 600, height: 600)
            // if no this line, ivc.popoverPresentationController is nil
            ivc.modalPresentationStyle = .popover
            if let popover = ivc.popoverPresentationController {
                popover.delegate = self
                popover.backgroundColor = UIColor.darkGray
                popover.permittedArrowDirections = .any
                popover.sourceView = cell.thumbButton
                popover.sourceRect = cell.thumbButton.bounds
            }

        }
        self.present(ivc, animated: true, completion: nil)
    }
    
    // can not edit last row
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row < ItemStore.shared.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("commitEditingStyle \(editingStyle.rawValue) \(indexPath.row)")
        if editingStyle == .delete {
            let item = ItemStore.shared.allItems[indexPath.row]
            ItemStore.shared.allItems -= item
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // can not move last row
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row < ItemStore.shared.allItems.count
    }
    
    // can not move to last row
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.row == ItemStore.shared.allItems.count {
            return sourceIndexPath
        } else {
            return proposedDestinationIndexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("moveRowAt from \(sourceIndexPath.row) to \(destinationIndexPath.row)")
        ItemStore.shared.move(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == ItemStore.shared.allItems.count {
            return nil
        } else {
            return indexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.item = ItemStore.shared.allItems[indexPath.row]
        showModalViewController(vc: detailVC)
    }
    
    func showModalViewController(vc: DetailViewController) {
        let nvc = UINavigationController(rootViewController: vc)
        if UIDevice.current.userInterfaceIdiom == .pad {
            vc.dismissBlock = { self.tableView.reloadData() }
            nvc.modalPresentationStyle = .formSheet
        }
        self.present(nvc, animated: true, completion: nil)
    }


}

extension ItemsViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
