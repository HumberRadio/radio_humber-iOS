//
//  Campus.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/4/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import Foundation


class Campus {
    var campusName: String
//    {
//        get { return self.campusName }
//        set {self.campusName = newValue}
//    }
   

    private let campusCoordinateY:String
    private let campusCoordinatX:String
    
    init(campusName:String, campusCoordinateY:String, campusCoordinateX:String) {
        self.campusName = campusName
       
        self.campusCoordinateY = campusCoordinateY
        self.campusCoordinatX = campusCoordinateX
    }

    private func loadDummyData() -> [Campus] {
        
        let humberCampusNames:[String] = ["North Campus","Lakeshore Campus","Orangevile Campus","Career Drive"];
    
        var campusResults:[Campus] = []
        var campus:Campus = Campus.init(campusName: "test", campusCoordinateY: "test", campusCoordinateX: "test")
        
        for campusName:String in humberCampusNames
        {
            switch campusName
            {
            case "North Campus":
//               campus = Campus.init(campusName: campusName, campusCoordinateY: String, campusCoordinateX: <#T##String#>)
                break;
            case "Lakeshore Campus":
                break;
            case "Orangevile Campus":
                break;
            case "Career Drive":
                break;
            default:
                break;
            }
            
            
            campusResults.append(campus)
        }
        
        
        return campusResults
    }
    
    
    
}
