//
//  FetchWeatherController.swift
//  Swift-Weather
//
//  Created by Mike Mannix on 3/6/16.
//  Copyright © 2016 Northwoods. All rights reserved.
//

import UIKit
import CoreLocation

class FetchWeatherController: UIViewController, CLLocationManagerDelegate {

    var data: AnyObject?
    var lat = "40.1024362"
    var lon = "-83.1483597"

    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.requestAlwaysAuthorization()
            locationManager!.startUpdatingLocation()
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if let coordinate = manager.location?.coordinate {
            lat = "\(coordinate.latitude)"
            lon = "\(coordinate.longitude)"
        }
        getWeather()
    }

    func getWeather() {
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let url = NSURL(string: "http://forecast.weather.gov/MapClick.php?lat=\(lat)&lon=\(lon)&FcstType=json")
        session.dataTaskWithURL(url!) { (data, response, error) in
            if error == nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
                    self.data = json
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    self.performSegueWithIdentifier("weatherDetailSegue", sender: self)
                })
            }
        }.resume()
    }




    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? WeatherViewController {
            vc.inputData = self.data
        }
    }


}
