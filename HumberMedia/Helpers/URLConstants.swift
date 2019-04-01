//
//  URLConstants.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 2/23/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

struct URLConstants {
    public struct Domains
    {
        static let curentPlayInfo = "https://xml.leanplayer.com/CKHCFM/nowplaying.xml"
//        static let radioStreamUrl = "https://humber.leanstream.co/CKHCFM" //AAC
        static let radioStreamUrl = "https://humber.leanstream.co/CKHCFM-MP3" //MP3
        static let recentlyPlayed = "https://xml.leanplayer.com/CKHCFM/history.xml"
        
        
        //for ttc
        static let ttc927South = "http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=ttc&stopId=15404"
        static let ttc927North = "http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=ttc&stopId=15406"
        static let ttc96East = "http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=ttc&stopId=15405"
        static let ttc96West = "http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=ttc&stopId=15403"
        static let ttc36East = "http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=ttc&stopId=11049"
        static let ttc36West = "http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=ttc&stopId=7861"
    
    }
} 
