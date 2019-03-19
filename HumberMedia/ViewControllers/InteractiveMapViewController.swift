//
//  InteractiveMapViewController.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 3/18/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import UIKit
import WebKit

class InteractiveMapViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://humber.ca/campus-map/")
        let requestObj = URLRequest(url: url! as URL)
        webView.load(requestObj)

        // Do any additional setup after loading the view.
//        webView.load(URLRequest.init(url: URL.init(string: "https://humber.ca/campus-map/")!))
    
//        webView.load(NSURLRequest(url: NSURL(string: "google.ca")! as URL) as URLRequest);
    }
    
    @IBAction func backPressed(_ sender: Any) {
//    self.navigationController?.popViewController(animated: true)
//        self.transitioningDelegate = RZTransitionsManager.shared()
//        let selectCampusViewController:SelectCampusViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectCampusID") as! SelectCampusViewController
//        let nextViewController = selectCampusViewController
//        nextViewController.transitioningDelegate = RZTransitionsManager.shared()
//        self.present(nextViewController, animated:true)
        self.dismiss(animated: true)
            
        
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
