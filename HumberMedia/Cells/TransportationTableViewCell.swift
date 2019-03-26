//
//  TransportationTableViewCell.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/19/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import UIKit
import FoldingCell
class TransportationTableViewCell: FoldingCell{

    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
        // Initialization code
    }
    var number: Int = 0 {
        didSet {
//            closeNumberLabel.text = String(number)
//            openNumberLabel.text = String(number)
        }
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureTransportationCell(teamMember: TeamMember) {
      
        
        
    }
}
