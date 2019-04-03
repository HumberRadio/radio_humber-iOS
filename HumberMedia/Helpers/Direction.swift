//
//  Direction.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/25/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import Foundation


class Direction {
    var directionName:String
    var direction:String
    var number:String
    var predictions:[Prediciton] = []
    init() {
        self.directionName = "N/A"
        self.direction = "N/A"
        self.number = "N/A"
//        self.predictions = [Prediciton]
        
    }
    init(directionName:String) {
        self.directionName = directionName
        self.direction = directionName.components(separatedBy: " ").first ?? "South"
        self.predictions = [Prediciton()]
        self.number = "N/A"
    }
    init(directionName:String, predictions:[Prediciton] , fullDirectionName:String) {
        self.directionName = fullDirectionName
        self.direction = directionName.components(separatedBy: " ").first ?? "South"
        self.number = directionName.components(separatedBy: " ").last ?? "N/A"
        self.predictions = predictions
        
    }
    func setDirection(directionName:String)
    {
        self.directionName = directionName
        self.direction =  directionName.components(separatedBy: " ").first ?? "South"
        self.number = "N/A"
    }
    
    
}
