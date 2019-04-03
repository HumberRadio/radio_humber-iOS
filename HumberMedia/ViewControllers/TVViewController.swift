//
//  TVViewController.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 2/8/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TVViewController: UIViewController, IndicatorInfoProvider  {
    @IBOutlet weak var imageView: UIImageView!
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {

        return IndicatorInfo(title: "TV");
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage.gif(asset: "construction")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
