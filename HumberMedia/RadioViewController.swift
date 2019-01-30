//
//  RadioViewController.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 1/25/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import UIKit
import MaterialComponents

class RadioViewController: UIViewController {
    @IBOutlet weak var bottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        bottomView.setDefaultElevation()
        let tabBar = MDCTabBar(frame: view.bounds)
        tabBar.items = [
            UITabBarItem(title: "Radio", image: UIImage(named: "radio_black"), tag: 0),
            UITabBarItem(title: "Tv", image: UIImage(named: "radio_black"), tag: 1),
            UITabBarItem(title: "Journalism", image: UIImage(named: "radio_black"), tag: 2),
            UITabBarItem(title: "Information", image: UIImage(named: "radio_black"), tag: 3),
        ]
        tabBar.itemAppearance = .titledImages
        tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.sizeToFit()
        view.addSubview(tabBar)
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

