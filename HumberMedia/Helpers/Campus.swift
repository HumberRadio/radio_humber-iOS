//
//  Campus.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/4/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import Foundation
import UIKit


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
    var phone:String
    var url:String
    var image:UIImage
    
    init()
    {
        self.campusName = "firstcampusName"
        self.longitute = 1.0
        self.latitute = 1.0
        self.zoom = 16.0
        self.address = ""
        self.phone = "(416) 675-3111"
        self.url = ""
        self.image = UIImage.init(imageLiteralResourceName: "lakeshore_campus_thumbnail")
//            Bundle.main.url(forResource: "Radio_Humber_Logo", withExtension: "jpg")!
        
    }
    init(campusName:String, longitute:Float, latitute:Float) {
        
        self.campusName = campusName
        self.longitute = longitute
        self.latitute = latitute
        self.zoom = 16.0
        self.address = ""
        self.phone = "(416) 675-3111"
        self.url = ""
        self.image = UIImage.init(imageLiteralResourceName: "lakeshore_campus_thumbnail")

    }
    init(campusName:String, longitute:Float, latitute:Float, zoom:Float, address:String, url:String, image:URL) {
        
        self.campusName = campusName
        self.longitute = longitute
        self.latitute = latitute
        self.zoom = zoom
        self.address = ""
        self.phone = "(416) 675-3111"
        self.url = ""
        self.image =  UIImage.init(imageLiteralResourceName: "lakeshore_campus_thumbnail")
        
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
                campus.latitute = 43.7287697
                campus.longitute = -79.6078194
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
                campus.latitute = 43.5956909
                campus.longitute = -79.5155826
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
                campus.latitute = 43.7287697
                campus.longitute = -79.6078194
                campus.zoom = 16.0
                campus.address = "205 Humber College Blvd"
                campus.phone = "(416) 675-3111"
                campus.url = ""
                campus.image = UIImage.init(imageLiteralResourceName: "lakeshore_campus_thumbnail")
//                    Bundle.main.url(forResource: "humber_north_campus_thumb2", withExtension: "jpg")!
                break;
            case "Lakeshore Campus":
                campus.campusName = "Lakeshore Campus"
                campus.latitute = 43.5956909
                campus.longitute = -79.5155826
                campus.zoom = 17.0
                campus.address = "2 Colonel Samuel Smith Park Drive, Toronto, Ontario, Canada M8V 4B6"
                campus.phone = "(416) 675-6622"
                campus.url = ""
                campus.image = UIImage.init(imageLiteralResourceName: "lakeshore_campus_thumbnail")
//                    Bundle.main.url(forResource: "lakeshore_campus_thumbnail", withExtension: "jpg")!
                break;
            case "Orangevile Campus":
                campus.campusName = "Orangevile Campus"
                campus.latitute = 43.9060121
                campus.longitute = -80.1273669
                campus.zoom = 16.0
                campus.address = "2nd Floor, 275 Alder St, Orangeville, ON L9W 5H6"
                campus.phone = "(416) 675-3111"
                campus.url = ""
                campus.image = UIImage.init(imageLiteralResourceName: "lakeshore_campus_thumbnail")
//                    Bundle.main.url(forResource: "orangeville_at_night", withExtension: "jpg")!
                break;
            case "Career Drive":
                campus.campusName = "Career Drive"
                campus.latitute = 43.7398309
                campus.longitute = -79.6118819
                campus.zoom = 18.0
                campus.address = "110 Carrier Dr, Etobicoke, ON M9W 5R1"
                campus.phone = "(416) 675-3111"
                campus.url = ""
                campus.image = UIImage.init(imageLiteralResourceName: "lakeshore_campus_thumbnail")
//                    Bundle.main.url(forResource: "lakeshore_campus_thumbnail", withExtension: "jpg")!
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
