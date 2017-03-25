//
//  ViewController.swift
//  MyLocation
//
//  Created by Marcel Harvan on 2017-03-24.
//  Copyright © 2017 The Marcel's fake Company. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var speed: UILabel!
    
    static let numberFormatter: NumberFormatter =  {
        let number = NumberFormatter()
        number.minimumFractionDigits = 0
        number.maximumFractionDigits = 0
        return number
    }()
    
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        myMap.setRegion(region, animated: true)
        
        
        if(location.speed > 0) {
            let kmh = location.speed / 1000.0 * 60.0 * 60.0
            if let speed = ViewController.numberFormatter.string(from: NSNumber(value: kmh)) {
                self.speed.text = "\(speed) km/h"
            }
        }
        else {
            self.speed.text = "---"
        }

        
        
        self.myMap.showsUserLocation = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

