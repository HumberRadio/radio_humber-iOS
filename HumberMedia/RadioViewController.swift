//
//  RadioViewController.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 1/25/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import UIKit
import MaterialComponents
import WebKit

class RadioViewController: UIViewController, WKNavigationDelegate{
    @IBOutlet weak var twitterWebView: WKWebView!
    @IBOutlet weak var bottomView: UIView!
  
    
    var webContentTwitter = """
<meta name='viewport' content='initial-scale=1.0'/>
<a class="twitter-timeline" href="https://twitter.com/RadioHumber?ref_src=twsrc%5Etfw">Tweets by RadioHumber</a> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
"""
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
        //embade web view twitter
        twitterWebView.navigationDelegate = self;
        twitterWebView.loadHTMLString(webContentTwitter, baseURL: nil);
        
        
        
        
        
    }
    
    
    //  delegate method for web view
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated  {
            if let url = navigationAction.request.url,
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                print(url)
                print("Redirected to browser. No need to open it locally")
                decisionHandler(.cancel)
            } else {
                print("Open it locally")
                decisionHandler(.allow)
            }
        } else {
            print("not a user click")
            decisionHandler(.allow)
        }
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

