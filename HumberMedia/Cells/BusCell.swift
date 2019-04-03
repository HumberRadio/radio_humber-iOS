//
//  DemoCell.swift
//  FoldingCell
//
//  Created by Alex K. on 25/12/15.
//  Copyright © 2015 Alex K. All rights reserved.
//

import FoldingCell
import UIKit

class BusCell: FoldingCell {

    @IBOutlet var closeNumberLabel: UILabel!
    @IBOutlet var openNumberLabel: UILabel!
    @IBOutlet weak var fullDirectionNameTopLabel: UILabel!
    @IBOutlet weak var fullDirectionNameLeftLabel: UILabel!
    @IBOutlet weak var fullDirectionNameRightLabel: UILabel!
    @IBOutlet weak var fullDirectionNameBottomLabel: UILabel!
    @IBOutlet weak var topTimeLable: UILabel!
 
    @IBOutlet weak var bottomTimeLabel: UILabel!
    @IBOutlet weak var directionLeftLabel: UILabel!
    @IBOutlet weak var directionRightLabel: UILabel!
    @IBOutlet weak var leftBusLabel1: UILabel!
    @IBOutlet weak var leftBusLabel2: UILabel!
    @IBOutlet weak var leftBusLabel3: UILabel!
    @IBOutlet weak var rightBusLabel1: UILabel!
    @IBOutlet weak var rightBusLabel2: UILabel!
    @IBOutlet weak var rightBusLabel3: UILabel!
    @IBOutlet weak var leftTimeLabel2: UILabel!
    @IBOutlet weak var leftTimeLabel3: UILabel!
    @IBOutlet weak var leftTimeLabel1: UILabel!
    @IBOutlet weak var rightTimeLabel1: UILabel!
    @IBOutlet weak var rightTimeLabel2: UILabel!
    @IBOutlet weak var rightTimeLabel3: UILabel!
    
    //
    var routeNumber:String = ""
//    var routeNumber: Int = 0 {
//        didSet {
//            // do all setting per cell here
//            closeNumberLabel.text = String(routeNumber)
//            openNumberLabel.text = String(routeNumber)
//        }
//    }

    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }

    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}

// MARK: - Actions ⚡️

extension BusCell {

}
