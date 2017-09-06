//
//  WeatherCenter.swift
//  NerdFeed
//
//  Created by Xiaoke Zhang on 2017/9/5.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//

import Foundation


let apiCitiesUrl = "http://flash.weather.com.cn/wmaps/xml/yunnan.xml"
let apiWeatherUrl = "http://www.sojson.com/open/api/weather/json.shtml?city=%@"
let webWeatherUrl = "http://m.weather.com.cn/mweather/%@.shtml"
let baiduWeathUrl = "https://cn.bing.com/search?q=%@"

class CityInfo: AnyObject, CustomStringConvertible {
    let name: String
    let pyName: String
    let weather: String
    let wind: String
    let temp1: String
    let temp2: String
    let code: String?
    
    var detail: String {
        return "\(weather), \(wind) \(temp1)℃-\(temp2)℃"
    }
    
    var webUrl: String {
        if let code = self.code {
            return String(format: webWeatherUrl, code)
        } else {
            return String(format: baiduWeathUrl, "\(name) 天气")
        }
    }
    
    var description: String {
        return "\(name): \(detail) \(code)"
    }
    
    init?(dict: [String: String]) {
        guard let name = dict["cityname"],
            let pyName = dict["pyName"],
            let weather = dict["stateDetailed"],
            let wind = dict["windState"],
            let temp1 = dict["tem1"],
            let temp2 = dict["tem2"]
        else { return nil }
        self.name = name
        self.pyName = pyName
        self.weather = weather
        self.wind = wind
        self.temp1 = temp1
        self.temp2 = temp2
        self.code = dict["url"]
    }
    
    
}


let session = URLSession(configuration: URLSessionConfiguration.default)

class WeatherCenter: AnyObject {
    public static let shared = WeatherCenter()
    
    var cities: [CityInfo] = []
    
    func fetchCities(_ completion: (() -> Void)?) {
        let url = URL(string: apiCitiesUrl)!
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let cities = CitiesParser(data: data).parse()
                print("fetchCities success")
                self.cities = cities
                DispatchQueue.main.async {
                    completion?()
                }
            }
        }
        task.resume()
    }
    
}

class CitiesParser: NSObject, XMLParserDelegate {
    let data:Data
    var cities: [CityInfo] = []
    
    init(data: Data) {
        self.data = data
    }
    
    func parse() -> [CityInfo] {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return self.cities
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
//        print("CityParser didStartElement \(elementName) \(attributeDict)")
        if elementName == "city" {
            if let city = CityInfo(dict: attributeDict) {
                self.cities.append(city)
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
//        print("CityParser didEndElement \(elementName)")
    }
}
