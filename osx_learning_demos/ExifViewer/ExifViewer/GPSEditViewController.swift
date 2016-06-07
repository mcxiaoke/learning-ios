//
//  GPSEditViewController.swift
//  ExifViewer
//
//  Created by mcxiaoke on 16/6/6.
//  Copyright © 2016年 mcxiaoke. All rights reserved.
//

import Cocoa
import CoreLocation
import MapKit

let GPSEditablePropertyDictionary:[String:AnyObject] = [
  kCGImagePropertyGPSLatitude as String: 0.0,
  kCGImagePropertyGPSLongitude as String: 0.0,
  kCGImagePropertyGPSAltitude as String: 0.0,
  kCGImagePropertyGPSTimeStamp as String: "00:00:00",
  kCGImagePropertyGPSDateStamp as String: "2016-06-06",
]

class GPSEditViewController: NSViewController {
  
  var properties = GPSEditablePropertyKeys
  var location: CLLocation?
  var annotation:MKAnnotation?
  var initialized:Bool = false
  
  override var nibName: String?{
    return "GPSEditViewController"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.mapView.showsUserLocation = true
  }
  
  @IBOutlet weak var tableView: NSTableView!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var latitudeText:NSTextField!
  @IBOutlet weak var longitudeText:NSTextField!
  @IBOutlet weak var dateText:NSTextField!
  @IBOutlet weak var timeText:NSTextField!
  
  
  @IBAction func addAnnotation(sender:AnyObject){
    let loc = CLLocationCoordinate2DMake(39.9994132, 116.1734272)
    let title = "Lat:\(loc.latitude) Lon:\(loc.longitude)"
    let point = MapPoint(coordinate: loc, title: title)
    self.mapView.addAnnotation(point)
    self.mapView.setCenterCoordinate(loc, animated: true)
//    let region = MKCoordinateRegionMakeWithDistance(loc, 1000, 1000)
//    self.mapView.setRegion(region, animated: true)
  }
  
  func makeAnnotationAt(coordinate: CLLocationCoordinate2D){
    let title = "makeAnnotationAt Lat:\(coordinate.latitude) Lon:\(coordinate.longitude)"
    let newAnnotaion = MapPoint(coordinate: coordinate, title: title)
    self.mapView.addAnnotation(newAnnotaion)
    self.mapView.setCenterCoordinate(coordinate, animated: true)
    if let oldAnnotation = self.annotation {
      self.mapView.removeAnnotation(oldAnnotation)
    }
    self.annotation = newAnnotaion
  }
  
  override func mouseDown(theEvent: NSEvent) {
    let point = self.view.convertPoint(theEvent.locationInWindow, fromView: nil)
    let coordinate = self.mapView.convertPoint(point, toCoordinateFromView: self.view)
    print("mouseDown \(point.x) \(point.y) \(coordinate.latitude) \(coordinate.longitude)")
    if theEvent.clickCount == 1 {
//      makeAnnotationAt(coordinate)
    }
  }
  
  override func rightMouseDown(theEvent: NSEvent) {
    // must use self.view, not self.mapView, or not working, don't known why
    let point = self.view.convertPoint(theEvent.locationInWindow, fromView: nil)
    let coordinate = self.mapView.convertPoint(point, toCoordinateFromView: self.view)
    print("rightMouseDown x=\(point.x) y=\(point.y) \(coordinate.latitude) \(coordinate.longitude)")
    if theEvent.clickCount == 1 {
      makeAnnotationAt(coordinate)
//      openMapForPlace(coordinate)
    }
  }
  
  func openMapForPlace(coordinate: CLLocationCoordinate2D) {
    let distance:CLLocationDistance = 10000
    let regionSpan = MKCoordinateRegionMakeWithDistance(coordinate, distance, distance)
    let options = [
      MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
      MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
    ]
    let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.openInMapsWithLaunchOptions(options)
    
  }
}

extension GPSEditViewController: NSTableViewDelegate {
  
  func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
    let key = self.properties[row]
    var cellIdentifier = ""
    var stringValue = ""
    if tableView.tableColumnWithIdentifier("KeyCell") == tableColumn {
      cellIdentifier = "KeyCell"
      stringValue = ImagePropertyItem.getImageIOLocalizedString(key)
    }else if tableView.tableColumnWithIdentifier("ValueCell") == tableColumn {
      cellIdentifier = "Empty"
      stringValue = "Value"
    }
    guard let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil)
      as? NSTableCellView else { return nil }
    cell.textField?.stringValue = stringValue
    return cell
  }

}

class MapPoint: NSObject,MKAnnotation {
  var coordinate: CLLocationCoordinate2D
  var title: String?
  
  init(coordinate: CLLocationCoordinate2D, title:String?) {
    self.coordinate = coordinate
    self.title = title
    super.init()
  }
}

extension GPSEditViewController: NSTableViewDataSource {
  
  func numberOfRowsInTableView(tableView: NSTableView) -> Int {
    return properties.count
  }
}

extension GPSEditViewController: MKMapViewDelegate {
  
  func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
    print("didUpdateUserLocation \(userLocation.location)")
//    CLLocationCoordinate2D loc = userLocation.coordinate    //放大地图到自身的经纬度位置。
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
//    [self.mapView setRegion:region animated:YES];
    let coordinate = userLocation.coordinate
    self.location = userLocation.location
    if !self.initialized {
      self.initialized = true
      self.mapView.setCenterCoordinate(coordinate, animated: true)
//      let region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
//      self.mapView.setRegion(region, animated: true)
    }
    
  }

}