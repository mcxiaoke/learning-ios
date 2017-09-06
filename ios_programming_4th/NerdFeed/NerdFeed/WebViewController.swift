//
//  WebViewController.swift
//  NerdFeed
//
//  Created by Xiaoke Zhang on 2017/9/5.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var wkWebView: WKWebView!
    
    var city: CityInfo? {
        didSet {
            loadPage()
        }
    }
    
    override func loadView() {
        print("loadView")
        let wkWebView = WKWebView(frame: UIScreen.main.bounds)
        self.view = wkWebView
        self.wkWebView = wkWebView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print("viewDidLoad")
        setNavitaionBar()
        loadPage()
    }
    
    func setNavitaionBar() {
        if self.splitViewController?.displayMode == .allVisible {
            self.navigationItem.leftBarButtonItem = nil
        } else {
            let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
            self.navigationItem.leftBarButtonItem = cancel
        }
  
    }
    
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func loadPage() {
        guard let city = self.city else { return }
        self.navigationItem.title = "\(city.name)天气"
        print("loadPage for \(city) url=\(city.webUrl)")
        if let url2 = URL(string: city.webUrl) {
            wkWebView.load(URLRequest(url: url2))
        }
    }
    
}

extension WebViewController: UISplitViewControllerDelegate {
    
    /**
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let v1 = secondaryViewController as? UINavigationController {
            if let v2 = v1.topViewController as? WebViewController {
                return v2.city == nil
            }
        }
        return true
    }**/

    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewControllerDisplayMode) {
        switch displayMode {
        case .automatic:
            print("splitViewController automatic")
            break
        case .allVisible:
            print("splitViewController allVisible")
            setNavitaionBar()
            break
        case .primaryHidden:
            print("splitViewController primaryHidden")
            setNavitaionBar()
            break
        case .primaryOverlay:
            print("splitViewController primaryOverlay")
            break
        }
    }
    
}
