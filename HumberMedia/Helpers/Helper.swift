//
//  Helper.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 2/7/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
class Helper {
    public func getTimeFromTimestamp(timestamp:Double) ->String
    {
        let date = Date(timeIntervalSince1970: timestamp)
        //get hout
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a" // "a" prints "pm" or "am"
        return formatter.string(from: date) // "12 AM"
        
    }
    func showToast( view:UIView) {
        let message = "Data Saved."
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 75, y: view.frame.size.height-180, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    public func getBackgroundList() ->[String]
    {
        let backgroudnNameList:[String] = ["light_blue_background", "purple_background.png", "navy_blue_background.png", "dark_yellow_background.png", "blue_background.png"]
        return backgroudnNameList
    }
    public func getSimpsonslist() ->[String]
    {
        let simpsonsList:[String] = ["Bart_Simpsons", "Apu_Nahasapeemapetilon", "Homer_Simpsons", "Lisa_Simpsons.png", "Maggie_Simpsons.png", "Marge_Simpsons.png", "Montgomery_Burns.png", "Ned_Flanders.png", "Otto_Mann.png"]
        return simpsonsList
    }

    public func getCurrentlyPlayingInfo() -> Track
    {
        // init the class with N/A
        let track = Track(title: "N/A", artist: "N/A");
        
        
        
        return track;
        
    }
}


    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    extension UIViewController {
        func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    }
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
    }
    //This method checks if headphones are plugged in.

    func areHeadphonesPluggedIn()->Bool
    {
        var availableOutputs = AVAudioSession.sharedInstance().currentRoute.outputs
        for portDescription in availableOutputs
        {
            if portDescription.portType == AVAudioSession.Port.headphones
            {
                return true
            }
        }
        return false
    }
    func checkForPermissionAudio()
    {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)

        switch authorizationStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.audio) { granted in
                if granted {
                    print("access granted")
                }
                else {
                    print("access denied")
                }
            }
        case .authorized:
            print("Access authorized")
        case .denied, .restricted:
            print("restricted")
            
        }
    }


class ImageLoader {
    
    private static let cache = NSCache<NSString, NSData>()
    
    class func image(for url: URL, completionHandler: @escaping(_ image: UIImage?) -> ()) {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            
            if let data = self.cache.object(forKey: url.absoluteString as NSString) {
                DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
                return
            }
            
            guard let data = NSData(contentsOf: url) else {
                DispatchQueue.main.async { completionHandler(nil) }
                return
            }
            
            self.cache.setObject(data, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
        }
    }
    
   
    
}
extension String {
    func boolValueFromString() -> Bool {
        return NSString(string: self).boolValue
    }
}




