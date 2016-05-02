//
//  NetworkGrab.swift
//  WeatherGrab
//
//  Created by Yaxin Yuan on 16/5/2.
//  Copyright © 2016年 Yaxin Yuan. All rights reserved.
//

import Foundation

protocol networkDelegate {
    func showLabel(description: String, degree: Int)
}



class NetworkGrab{
    
    var delegate: networkDelegate?
    var city: String?
    private let apiKey = "72e96bce8488e5bb1ae04bbf9d33d601"
    var description: String!
    var degree: Int!
    
    
    
    init(cityName: String){
        city = cityName
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&APPID=\(apiKey)")
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        let request = NSURLRequest(URL: url!)
        let dataTask = session.dataTaskWithRequest(request, completionHandler: {
            data, response, error in
                let dictionary = self.parseJSON(data!)!
                let description = dictionary["weather"]![0]["description"]!!
                let temp = Int(dictionary["main"]!["temp"]!! as! Double - 273.15)
                self.description = description as! String
                self.degree = temp
                self.delegate?.showLabel(self.description, degree: self.degree)
            })
        dataTask.resume()
    }
    
    func parseJSON(data: NSData) -> [String: AnyObject]? {
        do{
            return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: AnyObject]
        }catch{
            print("Error JSON")
            return nil
        }
    }
    
    
    
    
    
    
}
