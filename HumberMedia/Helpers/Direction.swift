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
    var predictions:[Prediciton];
    init() {
        self.directionName = "N/A";
        self.predictions = [Prediciton()]
        
    }
    init(directionName:String) {
        self.directionName = directionName
        self.predictions = [Prediciton()]
    }
    init(directionName:String, predictions:[Prediciton]) {
        self.directionName = directionName
        self.predictions = predictions
    }
    
    
}
