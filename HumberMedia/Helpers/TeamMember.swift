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
//                teamMember = TeamMember.init(name: "Aleksandar Janakievski", role: "iOS developer", profilePic: UIImage.init(imageLiteralResourceName: "Bart_Simpsons"))
                teamMember = TeamMember.init(name: "Aleksandar Janakievski", role: "iOS developer", profilePic: UIImage.init(imageLiteralResourceName: "alex"))
                break;
            case "Dean":
//                teamMember = TeamMember.init(name: "Dean Sinclair", role: "Project sponsor", profilePic: UIImage.init(imageLiteralResourceName: simpsonsList[Int.random(in: 0 ... namesList.count)]))
                teamMember = TeamMember.init(name: "Dean Sinclair", role: "Project sponsor", profilePic: UIImage.init(imageLiteralResourceName: "dean"))
                break;
            case "Kayle":
//               teamMember = TeamMember.init(name: "Kylee Winn", role: "Project sponsor", profilePic: UIImage.init(imageLiteralResourceName: simpsonsList[Int.random(in: 0 ... namesList.count)]))
               teamMember = TeamMember.init(name: "Kylee Winn", role: "Project sponsor", profilePic: UIImage.init(imageLiteralResourceName: "kylee"))
                break;
            case "Noah":
//                teamMember = TeamMember.init(name: "Noah", role: "Project sponsor", profilePic: UIImage.init(imageLiteralResourceName: simpsonsList[Int.random(in: 0 ... namesList.count)]))
                  teamMember = TeamMember.init(name: "Noah", role: "Project sponsor", profilePic: UIImage.init(imageLiteralResourceName: "noah"))
                break;
            case "Feba":
//                teamMember = TeamMember.init(name: "Feba Mary Raj", role: "Android developer", profilePic: UIImage.init(imageLiteralResourceName: simpsonsList[Int.random(in: 0 ... namesList.count)]))
                 teamMember = TeamMember.init(name: "Feba Mary Raj", role: "Android developer", profilePic: UIImage.init(imageLiteralResourceName: "feba"))
                break;
            case "Jaspreet":
//                teamMember = TeamMember.init(name: "Jaspreet Kaur Rainu", role: "Project manager", profilePic: UIImage.init(imageLiteralResourceName: simpsonsList[Int.random(in: 0 ... namesList.count)]))
                  teamMember = TeamMember.init(name: "Jaspreet Kaur Rainu", role: "Project manager", profilePic: UIImage.init(imageLiteralResourceName: "jaspreet"))
                break;
            case "Taj":
//                teamMember = TeamMember.init(name: "Tajwane Campbell ", role: "Android developer", profilePic: UIImage.init(imageLiteralResourceName: simpsonsList[Int.random(in: 0 ... namesList.count)]))
                teamMember = TeamMember.init(name: "Tajwane Campbell ", role: "Android developer", profilePic: UIImage.init(imageLiteralResourceName: "taj"))
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
