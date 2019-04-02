//
//  BusParcer.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/26/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import Foundation
import SwiftHTTP


class BusParcer:  NSObject, XMLParserDelegate {
    
    var buses: [Bus] = []
    var brunch = String()
    var minutes = String()
    
    lazy var directions:[Direction] = []
    lazy var predictions:[Prediciton] = []
    var direction:Direction = Direction()
    lazy var prediction:Prediciton = Prediciton()
    
    
    //    // a constants that identify what element names we're looking for in the XML
    //    let dictionaryKeys = Set<String>(["artist", "songtitle", "albumart"])
    //    let dictionaryKeysTrasport = Set<String>(["predictions","minutes"])
    //
    // a few variables to hold the results as we parse the XML
    var results = [[String: String]]()    // the whole array of dictionaries
    //    var currentDictionary: [String: String]? // the current dictionary
    var currentValue: String?                // the current value for one of the keys in the dictionary
    //    ----------------------------
    
    
    public func parce927South() -> [Direction]
    {
        // create the semaphore get it background value 0 and start it
        let semaphore = DispatchSemaphore(value: 0)
        var directionsResult = [Direction]()
        let url = URL(string: URLConstants.Domains.ttc927South)
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            if parser.parse() {
                directionsResult = self.directions
                print(self.results.count )
                // we signal the semaphore to stop waiting
                semaphore.signal()
            }
        }
        task.resume()
        //when we signal we get semaphore to stop waiting and proceed to next line
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        
//        directionsResult = getTopPredictions(directions: directionsResult)
        
        
        
        
        
        return directionsResult;
    }
    public func getTop3Busses(forDirection:[Direction], busDirection:String) -> Direction
    {
        var topPredictions = getTopPredictions(directions: forDirection)
        let directionResult:Direction = Direction.init(directionName: busDirection, predictions: topPredictions)
        return directionResult
        
    }
    
    public func parce927North() -> [Direction]
    {
        // create the semaphore get it background value 0 and start it
        let semaphore = DispatchSemaphore(value: 0)
        var directionsResult = [Direction]()
        let url = URL(string: URLConstants.Domains.ttc927North)
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            if parser.parse() {
                directionsResult = self.directions
                print(self.results.count )
                // we signal the semaphore to stop waiting
                semaphore.signal()
            }
        }
        task.resume()
        //when we signal we get semaphore to stop waiting and proceed to next line
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return directionsResult;
    }
    
    public func parce96East() -> [Direction]
    {
        // create the semaphore get it background value 0 and start it
        let semaphore = DispatchSemaphore(value: 0)
        var directionsResult = [Direction]()
        let url = URL(string: URLConstants.Domains.ttc96East)
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            if parser.parse() {
                directionsResult = self.directions
                print(self.results.count )
                // we signal the semaphore to stop waiting
                semaphore.signal()
            }
        }
        task.resume()
        //when we signal we get semaphore to stop waiting and proceed to next line
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return directionsResult;
    }
    public func parce96West() -> [Direction]
    {
        // create the semaphore get it background value 0 and start it
        let semaphore = DispatchSemaphore(value: 0)
        var directionsResult = [Direction]()
        let url = URL(string: URLConstants.Domains.ttc96West)
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            if parser.parse() {
                directionsResult = self.directions
                print(self.results.count )
                // we signal the semaphore to stop waiting
                semaphore.signal()
            }
        }
        task.resume()
        //when we signal we get semaphore to stop waiting and proceed to next line
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return directionsResult;
    }
    public func parce36East() -> [Direction]
    {
        // create the semaphore get it background value 0 and start it
        let semaphore = DispatchSemaphore(value: 0)
        var directionsResult = [Direction]()
        let url = URL(string: URLConstants.Domains.ttc36East)
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            if parser.parse() {
                directionsResult = self.directions
                print(self.results.count )
                // we signal the semaphore to stop waiting
                semaphore.signal()
            }
        }
        task.resume()
        //when we signal we get semaphore to stop waiting and proceed to next line
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return directionsResult;
    }
    public func parce36West() -> [Direction]
    {
        // create the semaphore get it background value 0 and start it
        let semaphore = DispatchSemaphore(value: 0)
        var directionsResult = [Direction]()
        let url = URL(string: URLConstants.Domains.ttc36West)
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            if parser.parse() {
                directionsResult = self.directions
                print(self.results.count )
                // we signal the semaphore to stop waiting
                semaphore.signal()
            }
        }
        task.resume()
        //when we signal we get semaphore to stop waiting and proceed to next line
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return directionsResult;
    }
    //*****************************************************************
    // XMLParcerDelegate: functions to parce the returned results in result array for dictionalries.
    //*****************************************************************
    // initialize results structure
    
    func parserDidStartDocument(_ parser: XMLParser) {
        results = []
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
      
        switch elementName {
        case "direction":
            direction = Direction()
            direction.setDirection(directionName: attributeDict["title"]!) 
            
            break;
        case "prediction":
            prediction = Prediciton()
            prediction.setTime(time: attributeDict["epochTime"]!)
            prediction.affectedByLayover =  (attributeDict["affectedByLayover"] ?? "false").boolValueFromString()
            prediction.isDeparture = (attributeDict["isDeparture"]?.boolValueFromString())!
            prediction.branch = attributeDict["branch"]!
            prediction.seconds = attributeDict["seconds"]!
            prediction.minutes = attributeDict["minutes"]!
            prediction.tripTag = attributeDict["tripTag"]!
            prediction.vehicle = attributeDict["vehicle"]!
            direction.predictions.append(prediction)
            break;
        default:
            break;
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            if self.brunch == "minutes" {
                print (string)
            }
   
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        switch elementName {
        case "direction":
            self.directions.append(self.direction)
            
            print("end direction")
            break;
        case "prediction":
            self.predictions.append(self.prediction)
            print("end prediction")
            
            break;
        default:
            break;
        }
    }
    // error handling
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
        // TO DO:
    }
    private func getTopPredictions(directions:[Direction])->[Prediciton]
    {
        var topPredictions:[Prediciton] = [Prediciton]()
        var allPredictions:[Prediciton] = [Prediciton]()
        var predictionResult:[Prediciton] = [Prediciton]()
        for direction in directions {
            for preditcion in direction.predictions
            {
                allPredictions.append(preditcion)
            }
        }
        // love siwft one liners :)
        topPredictions = allPredictions.sorted(by: {Int($0.seconds)  ?? 0 < Int($1.seconds) ?? 0 })
        for index in 0..<3
        {
            let isIndexValid = allPredictions.indices.contains(index)
            var testTop:Prediciton = Prediciton()
            if isIndexValid { testTop = allPredictions[index]}
            predictionResult.append(testTop)
        }
        /*
         for index in 0..<3
         {
         let isIndexValid = allObjects.indices.contains(index)
         var yourObject:Class = Class()
         if isIndexValid { yourObject = allObjects[index]}
         resultArray.append(yourObject)
         }
         !!!! Code Published on stackOverflow
         https://stackoverflow.com/a/55465002/1078845
 */
        
        return predictionResult
    }
    
}

