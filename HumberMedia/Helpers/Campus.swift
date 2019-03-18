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
    var zoom:Float
    var address:String
    var url:String
    var image:String
    
    init()
    {
        self.campusName = "firstcampusName"
        self.longitute = 1.0
        self.latitute = 1.0
        self.zoom = 16.0
        self.address = ""
        self.url = ""
        self.image = ""
        
    }
    init(campusName:String, longitute:Float, latitute:Float) {
        
        self.campusName = campusName
        self.longitute = longitute
        self.latitute = latitute
        self.zoom = 16.0
        self.address = ""
        self.url = ""
        self.image = ""

    }
    init(campusName:String, longitute:Float, latitute:Float, zoom:Float, address:String, url:String, image:String) {
        
        self.campusName = campusName
        self.longitute = longitute
        self.latitute = latitute
        self.zoom = zoom
        self.address = ""
        self.url = ""
        self.image = ""
        
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
//                campus.latitute = 43.7344449
//                campus.longitute = -79.612143
                campus.latitute = 43.7287697
                campus.longitute = -79.6078194
                self.address = ""
                self.url = ""
                self.image = ""
                break;
            case "Lakeshore Campus":
                campus.campusName = "Lakeshore Campus"
                campus.latitute = 43.7344449
                campus.longitute = -79.612143
                self.address = ""
                self.url = ""
                self.image = ""
                break;
            case "Orangevile Campus":
                campus.campusName = "Orangevile Campus"
                campus.latitute = 43.7344449
                campus.longitute = -79.612143
                self.address = ""
                self.url = ""
                self.image = ""
                break;
            case "Career Drive":
                campus.campusName = "Career Drive"
                campus.latitute = 43.5956909
                campus.longitute = -79.5155826
                self.address = ""
                self.url = "43.5956909"
                self.image = ""
                break;
            default:
                break;
            }
            
            
            campusResults.append(campus)
        }
        
        
        return campusResults
    }
    public mutating func loadDummyDataEnabler() -> [Campus] {
        
        
        var campusResults:[Campus] = []
        
        
        let campusLooper = ["North Campus","Lakeshore Campus", "Orangevile Campus", "Career Drive"]
        var campus = Campus.init()
        for campusName:String in campusLooper
        {
            switch campusName
            {
            case "North Campus":
                campus.campusName = "North Campus"
                //                campus.latitute = 43.7344449
                //                campus.longitute = -79.612143
                campus.latitute = 43.7287697
                campus.longitute = -79.6078194
                campus.zoom = 16.0
                campus.address = ""
                campus.url = ""
                campus.image = ""
                break;
            case "Lakeshore Campus":
                campus.campusName = "Lakeshore Campus"
                campus.latitute = 43.7344449
                campus.longitute = -79.612143
                campus.zoom = 16.0
                campus.address = ""
                campus.url = ""
                campus.image = ""
                break;
            case "Orangevile Campus":
                campus.campusName = "Orangevile Campus"
                campus.latitute = 43.7344449
                campus.longitute = -79.612143
                campus.zoom = 16.0
                campus.address = ""
                campus.url = ""
                campus.image = ""
                break;
            case "Career Drive":
                campus.campusName = "Career Drive"
                campus.latitute = 43.5956909
                campus.longitute = -79.5155826
                campus.zoom = 16.0
                campus.address = ""
                campus.url = "43.5956909"
                campus.image = ""
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
