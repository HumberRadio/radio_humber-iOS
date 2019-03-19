//
//  TeamMember.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/19/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import Foundation
import UIKit

class TeamMember {
    var name:String
    var role:String
    var qrCode:UIImage
    var profilePic:UIImage
    
    init() {
        self.name = ""
        self.role = ""
        self.qrCode = UIImage.init(imageLiteralResourceName: "lakeshore_campus_thumbnail")
        self.profilePic = UIImage.init(imageLiteralResourceName: "lakeshore_campus_thumbnail")
    }
    init(name:String, role:String, qrCode:UIImage, profilePic:UIImage) {
        self.name = name
        self.role = role
        self.qrCode = qrCode
        self.profilePic = profilePic
    }
    
}
