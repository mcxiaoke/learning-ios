//
//  ViewController.swift
//  Homepwner
//
//  Created by Xiaoke Zhang on 2017/8/16.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit
import IDMPhotoBrowser

class ItemsViewController: UIViewController {
    var collectionView: UICollectionView!
    
    override func loadView() {
        super.loadView()
        
        let sw = round((UIScreen.main.bounds.width - 2) / 3)
        let sh = sw
        print("sw=\(sw) sh=\(sh) screen=\(UIScreen.main.bounds.size)")
        ImageStore.shared.thumbSize = CGSize(width: sw, height: sh)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = ImageStore.shared.thumbSize
        
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.white
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.dataSource = self
        cv.delegate = self
        cv.bounces = true
        cv.bouncesZoom = true
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        self.collectionView = cv
        self.view = cv
    }
    
    @IBAction func addNewItem(_ sender: AnyObject) {
        print("addNewItem")
        let newItem = ItemStore.shared.createItem()
        let lastRow = ItemStore.shared.allItems.index(of:newItem) ?? 0
        let indexPath = IndexPath(row:lastRow, section:0)
        self.collectionView.insertItems(at: [indexPath])
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

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CollectionItemCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "CollectionItemCell")
        self.navigationItem.title = "Homepwner"
        let newButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem(_:)))
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = newButtonItem
        
        let doubleTap = UITapGestureRecognizer.init(target: self, action: #selector(doubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.numberOfTouchesRequired = 1
        doubleTap.delaysTouchesBegan = true
        doubleTap.cancelsTouchesInView = false
        self.collectionView.addGestureRecognizer(doubleTap)
    }
    
    func doubleTap(_ gs: UITapGestureRecognizer) {
        let point = gs.location(in: self.collectionView)
        if let indexPath = self.collectionView.indexPathForItem(at: point) {
            print("doubleTap at:\(point) index:\(indexPath)")
            removeItem(at: indexPath)
        }
        
    }
    
    func removeItem(at indexPath: IndexPath) {
        ItemStore.shared.allItems.remove(at: indexPath.row)
        self.collectionView.deleteItems(at: [indexPath])
        self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.reloadData()
    }
    
    func showImageViewController2(_ key: String, at cell: CollectionItemCell) {
        guard let image = ImageStore.shared.image(forKey: key) else { return }
        let photo = IDMPhoto(image: image)!
        let ivc = IDMPhotoBrowser(photos: [photo], animatedFrom: cell.thumbView)!
        if UIDevice.current.userInterfaceIdiom == .pad {
            ivc.preferredContentSize = CGSize(width: 600, height: 600)
            // if no this line, ivc.popoverPresentationController is nil
            ivc.modalPresentationStyle = .popover
            if let popover = ivc.popoverPresentationController {
                popover.backgroundColor = UIColor.darkGray
                popover.permittedArrowDirections = .any
                popover.sourceView = cell.thumbView
                popover.sourceRect = cell.thumbView.bounds
            }
            
        }
        self.present(ivc, animated: true, completion: nil)
    }
    
    func showImageViewController(_ key: String, at cell: CollectionItemCell) {
        guard let image = ImageStore.shared.image(forKey: key) else { return }
        let ivc = ImageViewController()
        ivc.image = image
        if UIDevice.current.userInterfaceIdiom == .pad {
            ivc.preferredContentSize = CGSize(width: 600, height: 600)
            // if no this line, ivc.popoverPresentationController is nil
            ivc.modalPresentationStyle = .popover
            if let popover = ivc.popoverPresentationController {
                popover.backgroundColor = UIColor.darkGray
                popover.permittedArrowDirections = .any
                popover.sourceView = cell.thumbView
                popover.sourceRect = cell.thumbView.bounds
            }

        }
        self.present(ivc, animated: true, completion: nil)
    }
    
    func showModalViewController(vc: DetailViewController) {
        let nvc = UINavigationController(rootViewController: vc)
        if UIDevice.current.userInterfaceIdiom == .pad {
            //vc.dismissBlock = { self.tableView.reloadData() }
            nvc.modalPresentationStyle = .formSheet
        }
        self.present(nvc, animated: true, completion: nil)
    }


}

class CollectionItemCell: UICollectionViewCell {
    @IBOutlet weak var thumbView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var item: Item?
    var thumbClickBlock: ((String)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @IBAction func showImage(_ sender: Any?) {
        if let item = self.item {
            thumbClickBlock?(item.key)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("thumb frame=\(self.thumbView.frame)")
        print("label frame=\(self.nameLabel.frame)")
        print("cell frame=\(self.frame)")
    }
    
    func config(_ item: Item) {
        self.item = item
        self.nameLabel.text = item.itemName
        self.nameLabel.sizeToFit()
        let thumb = ImageStore.shared.thumb(forKey: item.key)
        self.thumbView.image = thumb
        print("thumb size=\(thumb?.size)")
    }
}

extension ItemsViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ItemStore.shared.allItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionItemCell", for: indexPath) as! CollectionItemCell
        let item = ItemStore.shared.allItems[indexPath.row]
        cell.config(item)
        return cell
    }
    
}

extension ItemsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionView didSelectItemAt \(indexPath)")
        let dvc = DetailViewController()
        dvc.item = ItemStore.shared.allItems[indexPath.row]
        showModalViewController(vc: dvc)
    }

}
