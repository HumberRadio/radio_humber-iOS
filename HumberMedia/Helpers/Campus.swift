//
//  Campus.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/4/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import Foundation


struct Campus {
     var campusName:String
//    {
//        get { return self.campusName }
//        set {self.campusName = newValue}
//    }
   

     var longitute:Float
     var latitute:Float
    init()
    {
        self.campusName = "firstcampusName"
        self.longitute = 1.0
        self.latitute = 1.0
    }
    init(campusName:String, longitute:Float, latitute:Float) {
        
        self.campusName = campusName
        self.longitute = longitute
        self.latitute = latitute

    }

    public mutating func loadDummyData() -> [Campus] {
        
    
        var campusResults:[Campus] = []
        
    
        let campusLooper = ["North Campus","Lakeshore Campus", "Orangevile Campus", "Career Drive"]
        var campus = Campus.init()
        for campusName:String in campusLooper
        {
            switch campusName
            {
            case "North Campus":
                campus.campusName = "North Campus"
                campus.latitute = 43.7344449
                campus.longitute = -79.612143
                break;
            case "Lakeshore Campus":
                campus.campusName = "Lakeshore Campus"
                campus.latitute = 43.7344449
                campus.longitute = -79.612143
                break;
            case "Orangevile Campus":
                campus.campusName = "Orangevile Campus"
                campus.latitute = 43.7344449
                campus.longitute = -79.612143
                break;
            case "Career Drive":
                campus.campusName = "Career Drive"
                campus.latitute = 43.7344449
                campus.longitute = -79.612143
                break;
            default:
                break;
            }
            
            
            campusResults.append(campus)
        }
        
        
        return campusResults
    }
    
    //getters setter
//    public func getCampusName() -> String
//    {
//        return self.campusName
//    }
//    public func setCampusName (string:String)
//    {
//        self.campusName = string
//    }
//    public func getx() -> String
//    {
//        return self.campusCoordinateX
//    }
//    public func setx (string:String)
//    {
//        self.campusCoordinateX = string
//    }
//    public func gety() -> String
//    {
//        return self.campusCoordinateY
//    }
//    public func sety (string:String)
//    {
//        self.campusCoordinateY = string
//    }
    
    
    
    
}
