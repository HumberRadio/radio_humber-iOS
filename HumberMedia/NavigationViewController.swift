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
import FRadioPlayer
import AVFoundation
import CircleMenu

class NavigationViewController: ButtonBarPagerTabStripViewController, XMLParserDelegate, FRadioPlayerDelegate, CircleMenuDelegate  {
   
    
   
    // layout constrains
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    
    // UI outlets
    
    @IBOutlet weak var playbutton: FaveButton!
    @IBOutlet weak var stopbutton: FaveButton!
    @IBOutlet weak var infobutton: FaveButton!
    
    @IBOutlet weak var infoMenuButton: CircleMenu!
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
 
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var infoTextView: UIView!
    
    
    //specific UI constains (needed for animation)
    @IBOutlet weak var trailingButtonView: NSLayoutConstraint!
     @IBOutlet weak var topButtonsView: NSLayoutConstraint!
    
    @IBOutlet weak var widthButtonView: NSLayoutConstraint!
    @IBOutlet weak var heightButtonView: NSLayoutConstraint!
    // infotext View constrains
    @IBOutlet weak var trailingInfoView: NSLayoutConstraint!
    
    @IBOutlet weak var leadingInfoViuew: NSLayoutConstraint!
    
    @IBOutlet weak var topInfoTextView: NSLayoutConstraint!
    
    // radio imageview constains
    @IBOutlet weak var widthRadioImage: NSLayoutConstraint!
    @IBOutlet weak var heightRadioImage: NSLayoutConstraint!
    
    @IBOutlet weak var leadingRadioImage: NSLayoutConstraint!
    
    @IBOutlet weak var topRadioImage: NSLayoutConstraint!
    
   
    
    @IBOutlet weak var radioImageView: UIImageView!
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    var headphonesStatus:Bool = false
    let player = FRadioPlayer.shared
    var player2: AVPlayer?
    
    //more info buttons colors
    //    let colors = [UIColor.redColor(), UIColor.grayColor(), UIColor.greenColor(), UIColor.purpleColor()]
    let items: [(icon: String, color: UIColor)] = [
        ("icon_home", UIColor(red: 0.19, green: 0.57, blue: 1, alpha: 1)),
        ("teamInfobutton", UIColor(red: 0.22, green: 0.74, blue: 0, alpha: 1)),
        ("notifications-btn", UIColor(red: 0.96, green: 0.23, blue: 0.21, alpha: 1)),
        ("settings-btn", UIColor(red: 0.51, green: 0.15, blue: 1, alpha: 1)),
        ("nearby-btn", UIColor(red: 1, green: 0.39, blue: 0, alpha: 1))]
    
    
    override func viewDidLoad() {
          self.prepareUI()
        
        super.viewDidLoad()
        //setup ui logic
      
//seting up radio player
//        let player = FRadioPlayer.shared
//        player.delegate = self
//        player.radioURL = URL(string: URLConstants.Domains.radioStreamUrl);
//        player.stop()
       
        //checkup to see if headphones are connected
//        checkForPermissionAudio()
        
        guard let url = URL.init(string: URLConstants.Domains.radioStreamUrl)
            else {
                return
        }
        let playerItem = AVPlayerItem.init(url: url)
        player2 = AVPlayer.init(playerItem: playerItem)
//        player2?.play()

        
        headphonesStatus = areHeadphonesPluggedIn()
        if headphonesStatus{
            playbutton.sendActions(for: .touchUpInside)
        }
        
        //love one liners :)
//        toglePlayButton(isPlaying: player.isPlaying)
        
        
        
        
        
        
        
     
    }
    override func viewDidAppear(_ animated: Bool) {
        player.stop()
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
        
        self.updateSongInfo()
        
    }
    
    private func updateSongInfo()
    {
        let xmlparser = XMLParserHelper.init();
        let currentlyPlayingTrack = xmlparser.parceCurentlyPlaying();
        songTitleLabel.text = currentlyPlayingTrack.title
        artistNameLabel.text = currentlyPlayingTrack.artist
    }
    
    private func prepareUI()
    {
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
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(NavigationViewController.tapDetectedImage))
        radioImageView.isUserInteractionEnabled = true
        radioImageView.addGestureRecognizer(singleTap)
        
    }
    
   
    @objc func tapDetectedImage() {
//        print("Imageview Clicked")
        UIView.animate(withDuration: 3.0, animations:{
//            self.bottomView.setheig = 500.0
            // bring whole bottme view to top
            self.bottomViewHeight.constant = self.view.frame.height * 0.70
            //animate buttons
            self.trailingButtonView.constant = self.view.frame.width * 0.32
//            self.widthButtonView.constant = self.view.frame.width * 0.33
//            self.heightButtonView.constant = 120
            self.topButtonsView.constant = (self.view.frame.width * 0.36) + 65
            
            
            
            //animate info text
            self.self.leadingInfoViuew.constant = self.view.frame.width * 0.15
            self.trailingInfoView.constant = self.view.frame.width * 0.15
            self.topInfoTextView.constant = 15
            
            //animate imageview
            self.widthRadioImage.constant = self.view.frame.width * 0.36
            self.heightRadioImage.constant = self.widthRadioImage.constant
            self.topRadioImage.constant = 80
            self.leadingRadioImage.constant = self.view.frame.width * 0.32
        
            self.view.layoutIfNeeded()
            

           
            
        }, completion: {_ in
            print("done")
        })
        
    }
    
    
    @IBAction func playButtonPressed(_ sender: Any) {
        
        
    
    }
    @IBAction func playButtonClick(_ sender: FaveButton, forEvent event: UIEvent) {
        
        UIButton.animate(withDuration: 0.4,
                       animations: {
                        self.playbutton.alpha = 0
        },
                       completion: { _ in
                        UIButton.animate(withDuration: 0.1) {
                            self.stopbutton.isHidden = false;
                            self.playbutton.isHidden = true;
                            self.stopbutton.alpha = 1;
                        }
        })
//        player.play()
        player2?.play()
        sender.isSelected = false
    }
  
    @IBAction func stopButtonClicked(_ sender: FaveButton, forEvent event: UIEvent) {
        UIButton.animate(withDuration: 0.4,
                         animations: {
                            self.stopbutton.alpha = 0
        },
                         completion: { _ in
                            UIButton.animate(withDuration: 0.1) {
                                self.playbutton.isHidden = false;
                                self.stopbutton.isHidden = true;
                                self.playbutton.alpha = 1;
                            }
        })
//        player.stop()
        player2?.pause()
        sender.isSelected = false
        
    }
    
    
    @IBAction func infoButtonClick(_ sender: FaveButton, forEvent event: UIEvent) {
        
        UIButton.animate(withDuration: 0.4, animations: {
            self.infoMenuButton.alpha = 1
            self.infoMenuButton.isHidden = false
        }, completion: {_ in
            self.infoMenuButton.sendActions(for: .touchUpInside)
        })
    }
    @IBAction func infoMenuButtonClciked(_ sender: CircleMenu, forEvent event: UIEvent) {
        if sender.isSelected == false{
            self.infobutton.setSelected(selected: false, animated: true)
            UIButton.animate(withDuration: 0.4, animations: {
                self.infoMenuButton.alpha = 0
                
            }, completion: {_ in
                self.infoMenuButton.isHidden = true
            })
        }
        // will nedeve be executed cause menu button is hidden by logic
        if sender.isSelected == true{
            self.infobutton.setSelected(selected: true, animated: true)
        }
    }
    
    
    
    // MARK: <CircleMenuDelegate>
    
    func circleMenu(_: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color
        
        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
        
        // set highlited image
        let highlightedImage = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(highlightedImage, for: .highlighted)
        button.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func circleMenu(_: CircleMenu, buttonWillSelected _: UIButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
    }
    
    func circleMenu(_: CircleMenu, buttonDidSelected _: UIButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
    }
    
    //MARK: <FRadioPlayerDelegate>
    func radioPlayer(_ player: FRadioPlayer, playerStateDidChange state: FRadioPlayerState) {
        
    }
    
    func radioPlayer(_ player: FRadioPlayer, playbackStateDidChange state: FRadioPlaybackState) {
        
    }
}
