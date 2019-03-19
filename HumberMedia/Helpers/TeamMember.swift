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
        let helper:Helper = Helper.init()
        let simpsonsList:[String] = helper.getSimpsonslist()
        // populate this
        var teamMemberList:[TeamMember] = [TeamMember]()
        var teamMember:TeamMember = TeamMember.init()
        
//         teamMember = TeamMember.init(name: "Aleksandar Janakievski", role: "iOS developer", profilePic: UIImage.init(imageLiteralResourceName: "Bart_Simpsons"))
        for name in namesList {
            switch name
            {
            case "Alex":
                teamMember = TeamMember.init(name: "Aleksandar Janakievski", role: "iOS developer", profilePic: UIImage.init(imageLiteralResourceName: "Bart_Simpsons"))
                break;
            case "Dean":
                teamMember = TeamMember.init(name: "Dean", role: "Project sponsor", profilePic: UIImage.init(imageLiteralResourceName: simpsonsList[Int.random(in: 0 ... namesList.count)]))
                break;
            case "Kayle":
               teamMember = TeamMember.init(name: "Kayle", role: "Project sponsor", profilePic: UIImage.init(imageLiteralResourceName: simpsonsList[Int.random(in: 0 ... namesList.count)]))
                break;
            case "Noah":
                teamMember = TeamMember.init(name: "Noah", role: "Project sponsor", profilePic: UIImage.init(imageLiteralResourceName: simpsonsList[Int.random(in: 0 ... namesList.count)]))
                break;
            case "Feba":
                teamMember = TeamMember.init(name: "Feba", role: "Android developer", profilePic: UIImage.init(imageLiteralResourceName: simpsonsList[Int.random(in: 0 ... namesList.count)]))
                break;
            case "Jaspreet":
                teamMember = TeamMember.init(name: "Dean", role: "Project management", profilePic: UIImage.init(imageLiteralResourceName: simpsonsList[Int.random(in: 0 ... namesList.count)]))
                break;
            case "Taj":
                teamMember = TeamMember.init(name: "Dean", role: "Android developer", profilePic: UIImage.init(imageLiteralResourceName: simpsonsList[Int.random(in: 0 ... namesList.count)]))
                break;
                
            default:
                teamMember = TeamMember.init(name: "Aleksandar Janakievski", role: "iOS developer", profilePic: UIImage.init(imageLiteralResourceName: "Bart_Simpsons"))
                break;
            }
             teamMemberList.append(teamMember)
        }
       
        return teamMemberList
    }
    
}
