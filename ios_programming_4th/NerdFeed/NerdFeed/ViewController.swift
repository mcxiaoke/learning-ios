//
//  ViewController.swift
//  NerdFeed
//
//  Created by Xiaoke Zhang on 2017/9/5.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let cities: [CityInfo] = []
    var webViewController: WebViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(SimpleCell.self, forCellReuseIdentifier: "Cell")
        self.navigationController?.hidesBarsOnSwipe = false
        WeatherCenter.shared.fetchCities { 
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherCenter.shared.cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.accessoryType = .disclosureIndicator
        let city = WeatherCenter.shared.cities[indexPath.row]
        cell.textLabel?.text = city.name
        cell.detailTextLabel?.text = city.detail
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = WeatherCenter.shared.cities[indexPath.row]
        print("didSelectRowAt \(indexPath)")
        self.webViewController.city = city
        if self.splitViewController == nil {
            self.navigationController?.present(webViewController, animated: true, completion: nil)
        }
    }

}


