//
//  Prediction.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/25/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import Foundation

class Prediciton {
    var branch:String = "N/A"
    var minutes:String = "N/A"
    var seconds:String = "N/A"
    var isDeparture:Bool = false
    var vehicle:String = "N/A"
    var tripTag:String = "N/A"
    var affectedByLayover:Bool = false
    var time:String
    
   
    init(busTime:String) {
        self.time = busTime
    }
  
    init() {
       
        //get hout
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a" // "a" prints "pm" or "am"
        self.time = formatter.string(from: Date()) // "12 AM"
       
    }
    init(branch:String, minutes:String, layover:Bool , time:String) {
        self.branch = branch
        self.minutes = minutes
        self.affectedByLayover = layover
        self.time = time
    }
    public func setTime(time:String)
    {
        let helper:Helper = Helper()
        self.time = helper.getTimeFromTimestamp(timestamp:Double(time)!)
        
    }
  
    
    
}
