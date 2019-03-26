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
    
    var directions:[Direction] = [Direction()]
    var predictions:[Prediciton] = [Prediciton()]
    var direction:Direction = Direction()
    var prediction:Prediciton = Prediciton()
    
    
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
                // parce completed sucessfuly
                //                self.results.count
                //                var track = Track(title: "N/A",artist: "N/A")
                //                for songinfo in self.results
                //                {
                //                    for (key,value) in songinfo{
                //                        switch key {
                //                        case "artist":
                ////                            track.resetTrack()
                ////                            track.artist = value
                //                            break;
                //                        case "songtitle":
                ////                            track.title = value
                //                            break;
                //                        case "albumart":
                ////                            track.imageUrl = value
                ////                            tracks.append(track)
                //                            break;
                //                        default:
                //                            break;
                //                        }
                //                    }
                //
                //                }
                directionsResult = self.directions
                print(self.results.count )
                // we signal the semaphore to stop waiting
                semaphore.signal()
            }
            
            //            print( NSString(data: data, encoding: String.Encoding.utf8.rawValue))
        }
        
        task.resume()
        
        //when we signal we get semaphore to stop waiting and proceed to next line
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return directionsResult;
    }
    public func get927South() ->[Direction]
    {
        // create the semaphore get it background value 0 and start it
        let semaphore = DispatchSemaphore(value: 0)
        var busesList = [Bus]()
        let url = URL(string: URLConstants.Domains.ttc927South)
        
        HTTP.GET(URLConstants.Domains.ttc927South) { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return //also notify app of failure as needed
            }
            print("opt finished: \(response.description)")
            
            guard let data = response.description.data(using: .utf8) else{return}
            let parser = XMLParser.init(data: data)
            let parcer1 = XMLParser.init(contentsOf: url!)
            parcer1!.delegate = self
            if parcer1!.parse() {
                //                var bus = Bus()
                //                for busInfo in self.results{
                for direction in self.results
                {
                    for (key,value) in direction{
                        switch key {
                        case "direction":
                            print(value)
                            //                                track.artist = value
                            break;
                        case "prediction":
                            print(value)
                            //                                track.title = value
                            break;
                        case "predictions":
                            print(value)
                            //                                track.imageUrl = value
                            break;
                        default:
                            break;
                        }
                    }
                }
            
            }
            
            
        }
        
   
        return directions
    }
    
    //*****************************************************************
    // XMLParcerDelegate: functions to parce the returned results in result array for dictionalries.
    //*****************************************************************
    // initialize results structure
    
    func parserDidStartDocument(_ parser: XMLParser) {
        results = []
    }
    // get the current value per node
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        //        if dictionaryKeys.contains(elementName) {
        //            currentValue = ""
        //        }
        //        if dictionaryKeysTrasport.contains(elementName)
        //        {
        //            currentValue = ""
        //        }
        switch elementName {
        case "direction":
            direction = Direction()
            direction.directionName = attributeDict["title"]!
            
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
    
    //    func parser(parse, element, namespace, name, attributes) {
    //        // check for your element and get attributes.
    //        // ..
    //    }
    
    // found characters in fact contains the real value of the nod
    
    //    func parser(_ parser: XMLParser, foundCharacters string: String) {
    //        currentValue? += string
    //    }
    // end element is the func hit last where we need to append results to result array.
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
    
    
}

