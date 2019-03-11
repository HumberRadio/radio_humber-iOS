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
import XLPagerTabStrip


class RadioViewController: UIViewController, WKNavigationDelegate, IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
         return IndicatorInfo(title: "RADIO");
    }
    @IBOutlet weak var weatherView: UIView!
    
    @IBOutlet weak var twitterWebView: WKWebView!

    @IBOutlet weak var instagramWebView: WKWebView!
    @IBOutlet weak var weatherWebView: WKWebView!
    final var valueRadius = 12;
//    var webContentWeather =  """
//    <a class="weatherwidget-io" href="https://forecast7.com/en/43d65n79d38/toronto/" data-label_1="TORONTO" data-font="Roboto" data-icons="Climacons Animated" data-theme="weather_one" >TORONTO</a><script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src='https://weatherwidget.io/js/widget.min.js';fjs.parentNode.insertBefore(js,fjs);}}(document,'script','weatherwidget-io-js');</script>
//    """
    
    var webContentWeather = """
                    <a class="weatherwidget-io" href="https://forecast7.com/en/43d65n79d38/toronto/" data-label_1="TORONTO" data-label_2="WEATHER" data-font="Roboto" data-icons="Climacons Animated" data-days="5" data-theme="weather_one" >TORONTO WEATHER</a>
        <script>
        !function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src='https://weatherwidget.io/js/widget.min.js';fjs.parentNode.insertBefore(js,fjs);}}(document,'script','weatherwidget-io-js');
        </script>
    """
    
    var webContentWeather1 =  """
    <iframe src="https://www.meteoblue.com/en/weather/widget/three?geoloc=detect&nocurrent=0&noforecast=0&days=7&tempunit=CELSIUS&windunit=KILOMETER_PER_HOUR&layout=image"  frameborder="0" scrolling="NO" allowtransparency="true" sandbox="allow-same-origin allow-scripts allow-popups allow-popups-to-escape-sandbox" style="width: 400px;height: 80px"></iframe><div><!-- DO NOT REMOVE THIS LINK --><a href="https://www.meteoblue.com/en/weather/forecast/week?utm_source=weather_widget&utm_medium=linkus&utm_content=three&utm_campaign=Weather%2BWidget" target="_blank">meteoblue</a></div>
    """
    var webContentInstagram =  """
    <a class="weatherwidget-io" href="https://forecast7.com/en/43d65n79d38/toronto/" data-label_1="TORONTO" data-font="Roboto" data-icons="Climacons Animated" data-theme="weather_one" >TORONTO</a><script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src='https://weatherwidget.io/js/widget.min.js';fjs.parentNode.insertBefore(js,fjs);}}(document,'script','weatherwidget-io-js');</script>
    """
    
    var webContentTwitter = """
    <meta name='viewport' content='initial-scale=1.0'/>
        <a class="twitter-timeline" href="https://twitter.com/RadioHumber?ref_src=twsrc%5Etfw">Tweets by RadioHumber</a> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
    """
    
    
    ///
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
////        bottomView.setDefaultElevation()
//        let tabBar = MDCTabBar(frame: view.bounds)
//        tabBar.items = [
//            UITabBarItem(title: "Radio", image: UIImage(named: "radio_black"), tag: 0),
//            UITabBarItem(title: "Tv", image: UIImage(named: "radio_black"), tag: 1),
//            UITabBarItem(title: "Journalism", image: UIImage(named: "radio_black"), tag: 2),
//        ]
//        tabBar.itemAppearance = .titledImages
//        tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
//        tabBar.sizeToFit()
//        view.addSubview(tabBar)
        //embade web view twitter
        twitterWebView.navigationDelegate = self;
        twitterWebView.loadHTMLString(webContentTwitter, baseURL: nil);
//
//        instagramWebView.navigationDelegate = self;
//        instagramWebView.loadHTMLString(webContentInstagram, baseURL: nil);
        
        weatherWebView.navigationDelegate = self;
        weatherWebView.loadHTMLString(webContentWeather, baseURL: nil);
        
        
        //bottom view shadow
//        bottomView.layer.cornerRadius = CGFloat(valueRadius);
//        bottomView.layer.masksToBounds = false;
//        bottomView.layer.shadowColor = hexStringToUIColor(hex: "#80555555").cgColor
////        bottomView.layer.shadowOpacity = 1
//        
//        bottomView.layer.shadowOffset = CGSize(width: 0, height: -3.0)
//        bottomView.layer.shadowOpacity = 0.6
//        bottomView.layer.shadowRadius = 0.1
//        
//        
//        //setting inset fab
//        buttonVolume.setElevation(ShadowElevation(rawValue: 6), for: .normal);
//        buttonVolume.setElevation(ShadowElevation(rawValue: 12), for: .highlighted);
//        buttonVolume.isset
//        buttonVolume.
//        let buttonVerticalInset =
//            min(0, -(kMinimumAccessibleButtonSize.height - button.bounds.height) / 2);
//        let buttonHorizontalInset =
//            min(0, -(kMinimumAccessibleButtonSize.width - button.bounds.width) / 2);
//        buttonVolume.hitAreaInsets =
//            UIEdgeInsetsMake(buttonVerticalInset, buttonHorizontalInset,
//                             buttonVerticalInset, buttonHorizontalInset);

        
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

