//
//  NavigationViewController.swift
//  HumberMedia
//
//  Created by Aleksandar Janakievski on 2/8/19.
//  Copyright © 2019 J-Fat. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import FaveButton

class NavigationViewController: ButtonBarPagerTabStripViewController, XMLParserDelegate{
    
    // UI outlets
    @IBOutlet weak var playbutton: FaveButton!
 
    
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0);
    
    override func viewDidLoad() {
        
        settings.style.buttonBarBackgroundColor = UIColor.clear;
        settings.style.buttonBarItemBackgroundColor  = UIColor.clear;
        settings.style.selectedBarBackgroundColor = UIColor.black
        // buttonBar minimumInteritemSpacing value, note that button bar extends from UICollectionView
        settings.style.buttonBarMinimumInteritemSpacing = 5
        // buttonBar minimumLineSpacing value
        settings.style.buttonBarMinimumLineSpacing = 5
        // buttonBar flow layout left content inset value
        settings.style.buttonBarLeftContentInset = 2
        // buttonBar flow layout right content inset value
        settings.style.buttonBarRightContentInset = 2
        // selected bar view is created programmatically so it's important to set up the following 2 properties properly
        settings.style.selectedBarHeight = 5
        // each buttonBar item is a UICollectionView cell of type ButtonBarViewCell
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 18)
        // helps to determine the cell width, it represent the space before and after the title label
        settings.style.buttonBarItemLeftRightMargin = 8
//        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemTitleColor = UIColor.red;
        // in case the barView items do not fill the screen width this property stretch the cells to fill the screen
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
     
        
        // change selected bar color
//        settings.style.buttonBarBackgroundColor = .none
//        settings.style.buttonBarItemBackgroundColor = .none
//        settings.style.selectedBarBackgroundColor = .black
//        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
//        settings.style.selectedBarHeight = 2.0
//        settings.style.buttonBarMinimumLineSpacing = 5
//        settings.style.buttonBarItemTitleColor = .black
//        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
//        settings.style.buttonBarLeftContentInset = 5
//        settings.style.buttonBarRightContentInset = 5
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
//            oldCell?.label.textColor = .black
//            newCell?.label.textColor = self!.purpleInspireColor;
            switch newCell?.label.text {
            case "RADIO":
                self?.headerView.backgroundColor = .black;
                oldCell?.label.textColor = .white
                newCell?.label.textColor = .white
                self?.headerImageView.image = UIImage(named: "logo_radio_humber")
//                self?.settings.style.buttonBarItemTitleColor = .white
//                self?.settings.style.buttonBarBackgroundColor = .black;
//                self?.settings.style.buttonBarItemBackgroundColor  = .gray
//                self?.settings.style.selectedBarBackgroundColor = UIColor.white
                break;
            case "TV":
                self?.headerView.backgroundColor = .blue;
                oldCell?.label.textColor = .black
                newCell?.label.textColor = .black
                 self?.headerImageView.image = UIImage(named: "logo_humber_hawks")
//                self?.settings.style.buttonBarItemTitleColor = .black
//                self?.settings.style.buttonBarBackgroundColor = .white;
//                self?.settings.style.buttonBarItemBackgroundColor  = .gray
//                self?.settings.style.selectedBarBackgroundColor = UIColor.white
                break;
            case "NEWS":
                self?.headerView.backgroundColor = .white;
                oldCell?.label.textColor = .black
                newCell?.label.textColor = .black
                 self?.headerImageView.image = UIImage(named: "logo_etc")
//                self?.settings.style.buttonBarItemTitleColor = .black
//                self?.settings.style.buttonBarBackgroundColor = .blue;
//                self?.settings.style.buttonBarItemBackgroundColor  = .gray
//                self?.settings.style.selectedBarBackgroundColor = UIColor.white
                break;
            default:
                self?.headerView.backgroundColor = .black;
                oldCell?.label.textColor = .white
                newCell?.label.textColor = .white
//                self?.settings.style.buttonBarItemTitleColor = .white
//                self?.settings.style.buttonBarBackgroundColor = .black;
//                self?.settings.style.buttonBarItemBackgroundColor  = .gray
//                self?.settings.style.selectedBarBackgroundColor = UIColor.white
                break;
            }
        
        
        }
        
        
        
        
        super.viewDidLoad()

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
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_radio = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "radio");
        let child_tv = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tv");
        let child_news = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "news")
        return [child_radio, child_tv, child_news];
    }
    
    
    @IBAction func playbuttonClick(_ sender: Any){
        
        let xmlparser = XMLParserHelper.init();
        let currentlyPlayingTrack = xmlparser.parceCurentlyPlaying();
        print(currentlyPlayingTrack.artist)
        
    }
    


}
