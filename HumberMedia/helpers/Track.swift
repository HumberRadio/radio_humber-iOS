//
//  Track.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 2/23/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//
import UIKit

struct Track {
    var title: String
    var artist: String
    var artworkImage: UIImage?
    var artworkLoaded = false
    
    init(title: String, artist: String) {
        self.title = title
        self.artist = artist
    }
}

