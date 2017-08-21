//
//  ViewController.swift
//  Homepwner
//
//  Created by Xiaoke Zhang on 2017/8/16.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    @IBOutlet var headerView:UIView!
    
    @IBAction func addNewItem(_ sender: AnyObject) {
        print("addNewItem")
        let newItem = ItemStore.shared.createItem()
        let lastRow = ItemStore.shared.allItems.index(of:newItem) ?? 0
        let indexPath = IndexPath(row:lastRow, section:0)
        tableView.insertRows(at: [indexPath], with: .top)
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
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        for _ in 0..<5 {
            let _ = ItemStore.shared.createItem()
        }
        self.navigationItem.title = "Homepwner"
//        let lb = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleEditMode(_:)))
        let newButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem(_:)))
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = newButtonItem
        
//        headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?[0] as! UIView
//        tableView.tableHeaderView = headerView
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemStore.shared.allItems.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        if indexPath.row == ItemStore.shared.allItems.count {
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = "No more items!"
        } else {
            let item = ItemStore.shared.allItems[indexPath.row]
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.text = item.description
        }
        return cell
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
    
/**
    // custom delete edit action
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let removeAction = UITableViewRowAction(style: .destructive, title: "Remove", handler:{_,_ in
            let item = ItemStore.shared.allItems[indexPath.row]
            ItemStore.shared.allItems -= item
            tableView.deleteRows(at: [indexPath], with: .fade)
        })
        return [removeAction]
    }
 **/
    
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
        self.navigationController?.pushViewController(detailVC, animated: true)
    }


}

