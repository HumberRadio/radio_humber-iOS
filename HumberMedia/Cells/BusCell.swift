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

    @IBAction func buttonHandler(_: AnyObject) {
        print("tap")
    }
}
