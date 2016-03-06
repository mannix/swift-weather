//
//  FetchWeatherController.swift
//  Swift-Weather
//
//  Created by Mike Mannix on 3/6/16.
//  Copyright © 2016 Northwoods. All rights reserved.
//

import UIKit

class FetchWeatherController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        getWeather()
    }

    func getWeather() {
        
        performSegueWithIdentifier("weatherDetailSegue", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
