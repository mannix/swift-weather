//
//  WeatherViewController.swift
//  Swift-Weather
//
//  Created by Steve Madsen on 2/16/16.
//  Copyright © 2016 Northwoods. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var forecastTableView: UITableView!

    var inputData: AnyObject?
    var weatherData = Dictionary<String, AnyObject>()

    override func viewDidLoad() {
        super.viewDidLoad()

        forecastTableView.dataSource = self
        forecastTableView.delegate = self
        if let weatherData = inputData as? [String: AnyObject] {
            self.weatherData = weatherData
            updateCurrentConditions()
        }
    }

    func updateCurrentConditions() {
        guard let currentObservation = weatherData["currentobservation"] as? [String: String] else { return }
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

    // MARK: Table View Data Source

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData["data"]!.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let forecastCell = tableView.dequeueReusableCellWithIdentifier("forecastCell", forIndexPath: indexPath) as? ForecastTableViewCell {
            let periodNames = weatherData["time"]!["startPeriodName"] as! [String]
            forecastCell.periodLabel.text = periodNames[indexPath.row]

            let temperatures = weatherData["data"]!["temperature"] as! [String]
            forecastCell.temperatureLabel.text = "\(temperatures[indexPath.row])º"

            let summaries = weatherData["data"]!["text"] as! [String]
            forecastCell.summaryLabel.text = summaries[indexPath.row]

            forecastCell.layoutIfNeeded()
            return forecastCell
        }
        return UITableViewCell()
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}

