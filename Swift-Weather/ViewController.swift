//
//  ViewController.swift
//  Swift-Weather
//
//  Created by Steve Madsen on 2/16/16.
//  Copyright © 2016 Northwoods. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet weak var loadingLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        getWeather()
    }

    func getWeather() {
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let url = NSURL(string: "http://forecast.weather.gov/MapClick.php?lat=40.1024362&lon=-83.1483597&FcstType=json")
        session.dataTaskWithURL(url!) { (data, response, error) in
            if error == nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
                    self.updateCurrentConditions(json as! [String: AnyObject])
                })
            }
        }.resume()
    }

    func updateCurrentConditions(json: [String: AnyObject]) {
        guard let currentObservation = json["currentobservation"] as? [String: String] else { return }
        
        temperatureLabel.text = "\(currentObservation["Temp"]!)º"
        feelsLikeLabel.text = "Feels like \(currentObservation["WindChill"]!)º"
        weatherLabel.text = currentObservation["Weather"]

        loadingLabel.hidden = true
        temperatureLabel.hidden = false
        feelsLikeLabel.hidden = false
        weatherLabel.hidden = false
    }

}

