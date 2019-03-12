//
//  XMLParserHelper.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 2/23/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import Foundation

class XMLParserHelper:  NSObject, XMLParserDelegate {
    
    
    
    
    // a constants that identify what element names we're looking for in the XML
    let dictionaryKeys = Set<String>(["artist", "songtitle", "albumart"])
    // a few variables to hold the results as we parse the XML
    var results = [[String: String]]()    // the whole array of dictionaries
    //    var currentDictionary: [String: String]? // the current dictionary
    var currentValue: String?                // the current value for one of the keys in the dictionary
    //    ----------------------------
    
    
    
    public func parceCurentlyPlaying () -> Track
    {
        // create the semaphore gie it background value 0 and start it
      let semaphore = DispatchSemaphore(value: 0)
       
        
        
        var track = Track(title: "N/A",artist: "N/A")
        let url = URL(string: URLConstants.Domains.curentPlayInfo)
        
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
                for songinfo in self.results
                {
                    for (key,value) in songinfo{
                        switch key {
                            case "artist":
                                track.artist = value
                                break;
                            case "songtitle":
                                track.title = value
                                break;
                            case "albumart":
                                track.imageUrl = value
                                break;
                            default:
                                break;
                        }
                    }
                }
                
                print(self.results.count )
                // we signal the semaphore to stop waiting
                semaphore.signal()
            }
            
            //            print( NSString(data: data, encoding: String.Encoding.utf8.rawValue))
        }
        
        task.resume()
        
        //when we signal we get semaphore to stop waiting and proceed to next line
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return track;
    }
    public func parceRecentlyPlayed () -> [Track]
    {
        // create the semaphore get it background value 0 and start it
        let semaphore = DispatchSemaphore(value: 0)
        
        
        var tracks = [Track]()
       
        let url = URL(string: URLConstants.Domains.recentlyPlayed)
        
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
                var track = Track(title: "N/A",artist: "N/A")
                for songinfo in self.results
                {
                    for (key,value) in songinfo{
                        switch key {
                        case "artist":
                            track.resetTrack()
                            track.artist = value
                            break;
                        case "songtitle":
                            track.title = value
                            break;
                        case "albumart":
                            track.imageUrl = value
                            tracks.append(track)
                            break;
                        default:
                            break;
                        }
                    }
                 
                }
                print(self.results.count )
                // we signal the semaphore to stop waiting
                semaphore.signal()
            }
            
            //            print( NSString(data: data, encoding: String.Encoding.utf8.rawValue))
        }
        
        task.resume()
        
        //when we signal we get semaphore to stop waiting and proceed to next line
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return tracks;
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
        if dictionaryKeys.contains(elementName) {
            currentValue = ""
        }
    }
    // found characters in fact contains the real value of the nod
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentValue? += string
    }
    // end element is the func hit last where we need to append results to result array.
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if dictionaryKeys.contains(elementName) {
            let currentDictionary: [String: String] = [elementName:currentValue!]
            results.append(currentDictionary)
            currentValue = nil
        }
    }
    // error handling
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
        // TO DO:
    }
  
    
}
