//
//  ViewController.swift
//  WeatherGrab
//
//  Created by Yaxin Yuan on 16/4/30.
//  Copyright © 2016年 Yaxin Yuan. All rights reserved.
//

import UIKit

class WeatherGrabViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    let Location = LocationGrabController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Location.getLocation()
    }
    
    @IBAction func refresh() {
    

    }
}

