//
//  Bus.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/19/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import Foundation
class Bus {
    var branch:String
    var minutes:String
    var affectedByLayover:Bool = false
    var time:String
    
    init() {
        branch = "N/A"
        minutes = "N/A"
       //get hout
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a" // "a" prints "pm" or "am"
        time = formatter.string(from: Date()) // "12 AM"
    }
    init(branch:String, minutes:String, layover:Bool , time:String) {
        self.branch = branch
        self.minutes = minutes
        self.affectedByLayover = layover
        self.time = time
    }
    
    public func get927South()->[Bus]
    {
        let busList:[Bus] = [Bus]()
        return busList
    }
    public func getTimeFromTimestamp(timestamp:Double) ->String
    {
        let date = Date(timeIntervalSince1970: timestamp)
        //get hout
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a" // "a" prints "pm" or "am"
        return formatter.string(from: date) // "12 AM"
        
    }
}
