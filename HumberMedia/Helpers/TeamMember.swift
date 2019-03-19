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
    var profilePic:UIImage
    
    init() {
        self.name = ""
        self.role = ""
       
        self.profilePic = UIImage.init(imageLiteralResourceName: "lakeshore_campus_thumbnail")
    }
    init(name:String, role:String, profilePic:UIImage) {
        self.name = name
        self.role = role
        self.profilePic = profilePic
    }
    public func getDummyData()-> [TeamMember]
    {
        // create list of our names
        let namesList:[String] = ["Alex","Dean", "Kayle", "Noah", "Feba", "Jaspreet", "Taj"]
        //create Uimages for team mebers Simpsons
        var teamMemberList:[TeamMember] = [TeamMember]()
        var teamMember:TeamMember = TeamMember.init(name: "Aleksandar Janakievski", role: "iOS developer", profilePic: UIImage.init(imageLiteralResourceName: "Bart_Simpsons"))
//         teamMember = TeamMember.init(name: "Aleksandar Janakievski", role: "iOS developer", profilePic: UIImage.init(imageLiteralResourceName: "Bart_Simpsons"))
        for name in namesList {
            switch name
            {
            case "Alex":
    teamMember = TeamMember.init(name: "Aleksandar Janakievski", role: "iOS developer", profilePic: UIImage.init(imageLiteralResourceName: "Bart_Simpsons"))
                break;
                
            default:
                break;
            }
        }
        teamMemberList.append(teamMember)
        return teamMemberList
    }
    
}
