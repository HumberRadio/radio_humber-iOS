//
//  CampusTableViewCell.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/14/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import UIKit

class CampusTableViewCell: UITableViewCell {
    @IBOutlet weak var titleTextView: UILabel!
    @IBOutlet weak var backGroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //style
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 78/255, green: 82/255, blue: 93/255, alpha: 0.6)
        selectedBackgroundView  = selectedView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     func configureCampusCell(campus: Campus) {
        self.titleTextView.text = campus.campusName
        
    }
    

}
