//
//  WeatherViewController.swift
//  Swift-Weather
//
//  Created by Steve Madsen on 2/16/16.
//  Copyright © 2016 Northwoods. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet weak var forecastImage: UIImageView!

    var data: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let weatherData = data as? [String: AnyObject] {
            updateCurrentConditions(weatherData)
        }
    }

    func updateCurrentConditions(json: [String: AnyObject]) {
        guard let currentObservation = json["currentobservation"] as? [String: String] else { return }

        setWeatherImage(currentObservation)

        temperatureLabel.text = "\(currentObservation["Temp"]!)º"
        feelsLikeLabel.text = "Feels like \(currentObservation["WindChill"]!)º"
        weatherLabel.text = currentObservation["Weather"]
    }

    func setWeatherImage(currentObservation: [String: String]) {
        if let weatherImage = currentObservation["Weatherimage"] {
            if let imageUrl = NSURL(string: "http://forecast.weather.gov/newimages/medium/\(weatherImage)") {
                NSURLSession.sharedSession().dataTaskWithURL(imageUrl) { (data, response, error) in
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        guard let data = data where error == nil else { return }
                        self.forecastImage.image = UIImage(data: data)
                        self.forecastImage.layer.cornerRadius = self.forecastImage.frame.height/6.4
                        self.forecastImage.clipsToBounds = true
                    }
                }.resume()
            }
        }
    }
    
}

