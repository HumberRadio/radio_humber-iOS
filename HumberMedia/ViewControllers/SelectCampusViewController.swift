//
//  SelectCampusViewController.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/12/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialNavigationBar

class SelectCampusViewController: UIViewController {
   
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var topNavigationItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       
        
        let backUIBar = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(backTapped))
//        let playUIBar = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(playTapped))
         topNavigationItem.leftBarButtonItem = backUIBar
        

        // Do any additional setup after loading the view.
    }
    @objc func backTapped()
    {
        
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
