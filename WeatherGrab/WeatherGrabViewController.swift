//
//  ViewController.swift
//  WeatherGrab
//
//  Created by Yaxin Yuan on 16/4/30.
//  Copyright © 2016年 Yaxin Yuan. All rights reserved.
//

import UIKit

class WeatherGrabViewController: UIViewController, cityDelegate, networkDelegate{
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    let Location = LocationGrabController()
    var network: NetworkGrab?
    var cityName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Location.delegate = self
        refresh()
    }
    
    
    @IBAction func refresh() {
        weatherLabel.text = "Loading..."
        tempLabel.text = "Loading..."
        Location.getLocation()
    }
    
    func showLabel(description: String, degree: Int){
        weatherLabel.text = description
        tempLabel.text = "\(String(degree))℃"
    }
    
    func showCity(city: String?) {
        if let citylocation = city{
            network = NetworkGrab(cityName: citylocation)
            network!.delegate = self
            cityLabel.text = citylocation
        }
    }
    

    
}

