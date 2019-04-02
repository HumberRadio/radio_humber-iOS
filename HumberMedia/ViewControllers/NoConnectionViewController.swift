//
//  NoConnectionViewController.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 4/1/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import UIKit
import SwiftGifOrigin
class NoConnectionViewController: UIViewController {
    @IBOutlet weak var topNavigationBar: UINavigationBar!
    @IBOutlet weak var topNavigationItem: UINavigationItem!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backUIBar = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(backTapped))
        topNavigationItem.leftBarButtonItem = backUIBar
        // Do any additional setup after loading the view.
        imageView.image = UIImage.gif(asset: "caveman")
//        imageView.image = UIImage.gif(name: "caveman")
    }
    

    @IBAction func tryAgain(_ sender: Any) {
        let alertController = UIAlertController (title: "Please allow data on your phone", message: "Go to Settings?", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
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
