//
//  FetchWeatherController.swift
//  Swift-Weather
//
//  Created by Mike Mannix on 3/6/16.
//  Copyright © 2016 Northwoods. All rights reserved.
//

import UIKit

class FetchWeatherController: UIViewController {

    var data: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        getWeather()
    }

    func getWeather() {
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let url = NSURL(string: "http://forecast.weather.gov/MapClick.php?lat=40.1024362&lon=-83.1483597&FcstType=json")
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
        if let vc = segue.destinationViewController as? ViewController {
            vc.data = self.data
        }
    }


}
