//
//  ViewController.swift
//  WeatherGrab
//
//  Created by Yaxin Yuan on 16/4/30.
//  Copyright © 2016年 Yaxin Yuan. All rights reserved.
//

import UIKit

class WeatherGrabViewController: UIViewController, cityDelegate{
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    let Location = LocationGrabController()
    var cityName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Location.delegate = self
        refresh()
    }
    
    @IBAction func refresh() {
        Location.getLocation()
    }
    
    func showCity(city: String?) {
        cityName = city
        updateLabel()
    }
    
    func updateLabel(){
        if let city = cityName{
            cityLabel.text = city
        }else{
            cityLabel.text = "Unknown"
        }
    }
    
}

