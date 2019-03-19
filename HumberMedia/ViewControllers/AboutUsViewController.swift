//
//  AboutUsViewController.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/14/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import UIKit
import MaterialComponents.MDCBaseCell

class AboutUsViewController: UIViewController {

    @IBOutlet weak var topNavigationBar: UINavigationBar!
    @IBOutlet weak var topNavigationItem: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        let backUIBar = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(backTapped))
        topNavigationItem.leftBarButtonItem = backUIBar
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
    @objc func backTapped(){
        self.dismiss(animated: true, completion: nil)
    }
}

