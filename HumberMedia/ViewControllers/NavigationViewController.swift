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
import anim
import RZTransitions
import SDWebImage
import Firebase
import FirebaseDatabase

class NavigationViewController: ButtonBarPagerTabStripViewController, XMLParserDelegate, FRadioPlayerDelegate, CircleMenuDelegate  {
    
    
    //firebase DB
    var ref: DatabaseReference!
    
    // UI outlets
    
    //Buttons
    @IBOutlet weak var playbutton: FaveButton!
    @IBOutlet weak var stopbutton: FaveButton!
    @IBOutlet weak var infobutton: FaveButton!
    @IBOutlet weak var infoMenuButton: CircleMenu!
    @IBOutlet weak var likebutton: FaveButton!
    
    
    //Labels
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    //Views
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var infoTextView: UIView!
    @IBOutlet weak var recentlyPlayedContainerView: UIView!
    
    @IBOutlet weak var radioImageView: UIImageView!
    @IBOutlet weak var blurView: UIView!
    
    
    //specific UI constains (needed for animation)
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    
    //button View constrains
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
    
    @IBOutlet weak var heightContainerView: NSLayoutConstraint!
    
    //properties
    
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    var headphonesStatus:Bool = false
    var isradioOpen:Bool = false
    let player = FRadioPlayer.shared
    var player2: AVPlayer?
    var isblured:Bool = false;
    var isbluredBottom:Bool = false;
    var isLiked = false;
    

    
    
    //more info buttons colors
    //    let colors = [UIColor.redColor(), UIColor.grayColor(), UIColor.greenColor(), UIColor.purpleColor()]
    let items: [(icon: String, color: UIColor)] = [
        ("icon_home", UIColor.humberPurple),
        ("teamInfobutton", UIColor.humberLightBlue),
        ("notifications-btn", UIColor.humberNavy),
//        ("schedule_icon", UIColor.humberNavy),
        ("settings-btn", UIColor.humberLightGreen),
        ("nearby-btn", UIColor.humberMagenta)]

    
    
    
    override func viewDidLoad() {
        self.prepareUI()
        ref = Database.database().reference()

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

        
//        headphonesStatus = areHeadphonesPluggedIn()
//        if headphonesStatus{
//            playbutton.sendActions(for: .touchUpInside)
//        }
        
        //love one liners :)
//        toglePlayButton(isPlaying: player.isPlaying)
        
       
        
        
        
        
        
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        player.stop()
        if !self.infoMenuButton.isHidden
        {
            self.infoMenuButton.sendActions(for: .touchUpInside)
        }
        if !isblured
        {    //blur efect on UI view
            let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
            visualEffectView.frame = self.blurView.bounds
            self.blurView.addSubview(visualEffectView)
            isblured = true
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
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_radio = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "radio");
        let child_tv = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tv");
        let child_news = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "news")
        return [child_radio, child_tv, child_news];
    }
    
    
    @IBAction func playbuttonClick(_ sender: Any){
        if !player.isPlaying {isUpdateAvaliable()}
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(isUpdateAvaliable), userInfo: nil, repeats: true)
    }
    @objc private func isUpdateAvaliable()
    {
        let xmlparser = XMLParserHelper.init();
        let currentlyPlayingTrack = xmlparser.parceCurentlyPlaying();
        if (currentlyPlayingTrack.artist == artistNameLabel.text){  print("Up to date")}
        else{
            isLiked = false;
            likebutton.setSelected(selected: false, animated: true)
            likebutton.isUserInteractionEnabled = true;
            self.updateSongInfo()
        }
    }
    
    
    private func updateSongInfo()
    {
        let xmlparser = XMLParserHelper.init();
        let currentlyPlayingTrack = xmlparser.parceCurentlyPlaying();
        songTitleLabel.text = currentlyPlayingTrack.title
        artistNameLabel.text = currentlyPlayingTrack.artist
        var imageURL = currentlyPlayingTrack.imageUrl
        //image update section
        if imageURL.contains("albumart") {
            _ = String(imageURL.removeFirst())
            _ = String(imageURL.removeFirst())
            imageURL = "https://" + imageURL
            if let url = URL(string: imageURL) {
              
                self.radioImageView.sd_setImage(
                    with: url,
                    placeholderImage: UIImage(named: "RadioThumbID"),
                    options: SDWebImageOptions(rawValue: 0),
                    completed:
                    { (img, err, cacheType, imgURL) in
                        // code
                        //                        if err
                        print("TO DO: is this error ?")
                        //                        print("test:" + (err?.localizedDescription)! )
                }
                    
                )
                
            }
            
        } else if imageURL != "" {
            radioImageView.image = UIImage(named: imageURL as String)
            
        } else {
            radioImageView.image = UIImage(named: "Radio_Humber_Logo")
        }
        
        radioImageView.applyShadow()
        
        
        
        
//        self.radioImageView.image = UIImage.init()
        
//        self.radioImageView.image = UIImage.init(imageLiteralResourceName: "Radio_Humber_Logo")
    }
    
    private func prepareUI()
    {
        
        //disable like until  radio is played
        likebutton.isUserInteractionEnabled = false;
        //cutsom trasition - butble from center
        RZTransitionsManager.shared().defaultPresentDismissAnimationController = RZCirclePushAnimationController()
        RZTransitionsManager.shared().defaultPushPopAnimationController = RZCirclePushAnimationController()
      
        //button style
        settings.style.buttonBarBackgroundColor = UIColor.clear;
        settings.style.buttonBarItemBackgroundColor  = UIColor.black;
        settings.style.selectedBarBackgroundColor = UIColor.indicatorColor
        
        settings.style.selectedBarVerticalAlignment = .bottom
        
        // buttonBar minimumInteritemSpacing value, note that button bar extends from UICollectionView
        settings.style.buttonBarMinimumInteritemSpacing = 5
        // buttonBar minimumLineSpacing value
        settings.style.buttonBarMinimumLineSpacing = 5
        // buttonBar flow layout left content inset value
        settings.style.buttonBarLeftContentInset = 2
        // buttonBar flow layout right content inset value
        settings.style.buttonBarRightContentInset = 2
        // selected bar view is created programmatically so it's important to set up the following 2 properties properly
        settings.style.selectedBarHeight = 3.5
        // each buttonBar item is a UICollectionView cell of type ButtonBarViewCell
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 18)
        // helps to determine the cell width, it represent the space before and after the title label
        settings.style.buttonBarItemLeftRightMargin = 8
        //        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemTitleColor = UIColor.white;
        // in case the barView items do not fill the screen width this property stretch the cells to fill the screen
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
//        self.headerView.tintColor = UIColor.white
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
                break;
            case "TV":
                self?.headerView.backgroundColor = .black;
                oldCell?.label.textColor = .white
                newCell?.label.textColor = .white
                self?.headerImageView.image = UIImage(named: "logo_radio_humber")
//                self?.headerView.backgroundColor = UIColor.humberPurple;
//                oldCell?.label.textColor = .black
//                newCell?.label.textColor = .black
//                self?.headerImageView.image = UIImage(named: "logo_humber_hawks")
                //                self?.settings.style.buttonBarItemTitleColor = .black
                //                self?.settings.style.buttonBarBackgroundColor = .white;
                //                self?.settings.style.buttonBarItemBackgroundColor  = .gray
                //                self?.settings.style.selectedBarBackgroundColor = UIColor.white
                break;
            case "NEWS":
                self?.headerView.backgroundColor = .black;
                oldCell?.label.textColor = .white
                newCell?.label.textColor = .white
                self?.headerImageView.image = UIImage(named: "logo_radio_humber")
//                self?.headerView.backgroundColor = .white;
//                oldCell?.label.textColor = .black
//                newCell?.label.textColor = .black
//                self?.headerImageView.image = UIImage(named: "logo_etc")
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
        if !isradioOpen
        {
            animateRadioBarOpen()
//            scrollView = BubbleScrollView.create()
//            self.view.addSubview(scrollView)
//            scrollView.size(withMainView: self.view)
        }
        else
        {
            animateRadioBarClose()
        }
       
        
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
            self.infoMenuButton.alpha = 0.5
            
            self.blurView.alpha = 1.0
            
        }, completion: {_ in
            self.infoMenuButton.sendActions(for: .touchUpInside)
            self.blurView.isHidden = false
            self.infoMenuButton.isHidden = false
        })
      
        
    }
    @IBAction func infoMenuButtonClciked(_ sender: CircleMenu, forEvent event: UIEvent) {
        if sender.isSelected == false{
            self.infobutton.setSelected(selected: false, animated: true)
            UIButton.animate(withDuration: 0.4, animations: {
                self.infoMenuButton.alpha = 0
                self.blurView.alpha = 0
                
            }, completion: {_ in
                self.infoMenuButton.isHidden = true
                self.blurView.isHidden = true
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
        
        switch atIndex {
        case 0:
            print("this is Home")
            break;
        case 1:
            print("this is People")
            break;
        case 2:
            print("this is alarm")
            break;
        case 3:
            print("this is settings")
            break;
        case 4:
            print("this is Maps ")
            break;
        default:
            print("this is default")
            break;
        }
    }
    
    func circleMenu(_: CircleMenu, buttonDidSelected _: UIButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
        switch atIndex {
        case 0:
            print("this is Home")
            if Reachability.isConnectedToNetwork(){
                print("Internet Connection Available!")
                self.transitioningDelegate = RZTransitionsManager.shared()
                let transportationViewController:TransportationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransportationID") as! TransportationViewController
                let nextViewController = transportationViewController
                nextViewController.transitioningDelegate = RZTransitionsManager.shared()
                self.present(nextViewController, animated:true)
            }else{
                print("Internet Connection not Available!")
                self.transitioningDelegate = RZTransitionsManager.shared()
                let noConnectionViewController:NoConnectionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoInternetID") as! NoConnectionViewController
                let nextViewController = noConnectionViewController
                nextViewController.transitioningDelegate = RZTransitionsManager.shared()
                self.present(nextViewController, animated:true)
            }
            break;
        case 1:
            print("this is People")
            self.transitioningDelegate = RZTransitionsManager.shared()
            let aboutUsViewController:AboutUsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutUsID") as! AboutUsViewController
            let nextViewController = aboutUsViewController
            nextViewController.transitioningDelegate = RZTransitionsManager.shared()
            self.present(nextViewController, animated:true)
            
            break;
        case 2:
            print("this is alarm")
          
            
            break;
        case 3:
            print("this is settings")
//            self.transitioningDelegate = RZTransitionsManager.shared()
//            let mapsViewController:CampusNavigationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CampusNavigationID") as! CampusNavigationViewController
//            let nextViewController = mapsViewController
//            nextViewController.transitioningDelegate = RZTransitionsManager.shared()
//            self.present(nextViewController, animated:true)
            break;
        case 4:
            print("this is Maps ")
            self.transitioningDelegate = RZTransitionsManager.shared()
                       let selectCampusViewController:SelectCampusViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectCampusID") as! SelectCampusViewController
            let nextViewController = selectCampusViewController
            nextViewController.transitioningDelegate = RZTransitionsManager.shared()
            self.present(nextViewController, animated:true)
            break;
        default:
            print("this is default")
            break;
        }
    }
    
    //MARK: <FRadioPlayerDelegate>
    func radioPlayer(_ player: FRadioPlayer, playerStateDidChange state: FRadioPlayerState) {
        
    }
    
    func radioPlayer(_ player: FRadioPlayer, playbackStateDidChange state: FRadioPlaybackState) {
        
    }
    
    //*****************************************************************
    // MARK: - RADIO BAR ANIMATIONS
    //*****************************************************************
    
    private func animateRadioBarOpen()
    {
        
     
        UIView.animate(withDuration: 1.0, animations:{
           self.bottomView.backgroundColor = UIColor(white: 1, alpha: 1.0)
            if !self.isbluredBottom
            {    //blur efect on UI view
                let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
                visualEffectView.frame = self.bottomView.bounds
                self.bottomView.addSubview(visualEffectView)
                self.isbluredBottom = true
                
            }
            
            // bring whole bottme view to top
            self.bottomViewHeight.constant = self.view.frame.height * 0.70
            
            self.heightContainerView.constant = self.view.frame.height * 0.35
            self.recentlyPlayedContainerView.alpha = 1
            
            //animate buttons
            self.trailingButtonView.constant = self.view.frame.width * 0.32
            self.topButtonsView.constant = (self.view.frame.width * 0.36) + 65

            //animate info text
            self.leadingInfoViuew.constant = self.view.frame.width * 0.15
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
            self.isradioOpen = true
            
//            NSLayoutConstraint.activate([
//                recentlyPlayedViewContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
//                recentlyPlayedViewContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
//                recentlyPlayedViewContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
//                recentlyPlayedViewContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
//                ])
//              let child_news = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "news")
//            recentlyPlayedViewContainer.addSubview(UIView)
//            self.bottomView.addSubview(recentlyPlayedViewContainer)
            
        })
        
        
    }
    private func animateRadioBarClose()
    {
        self.isradioOpen = true
       
        UIView.animate(withDuration: 1.0, animations:{
            
            // bring whole bottme view to top
            self.bottomViewHeight.constant = 80
            self.heightContainerView.constant = 0
            self.recentlyPlayedContainerView.alpha = 0
            
            //animate buttons
            self.trailingButtonView.constant = 0
            self.topButtonsView.constant = 0
            
            //animate info text
            self.leadingInfoViuew.constant = 70
            self.trailingInfoView.constant = 145
            self.topInfoTextView.constant = 15
            
            //animate imageview
            self.widthRadioImage.constant = 50
            self.heightRadioImage.constant = self.widthRadioImage.constant
            self.topRadioImage.constant = 15
            self.leadingRadioImage.constant = 15
            
            self.view.layoutIfNeeded()
            
            
        }, completion: {_ in
            print("done")
             self.isradioOpen = false
        })
       
        
        
    }
    @IBAction func likeTap(_ sender: Any) {
        
        if (shouldLike())
        {
            //TO DO: Logic
            guard let key = ref.child("likes").childByAutoId().key else { return }
            
            let now = Date()
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone.current
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: now)
            
            
            
            let song = ["deviceId": UIDevice.current.identifierForVendor!.uuidString,
                        "trackName": self.songTitleLabel.text ?? "N/A",
                        "trackArtist": self.artistNameLabel.text,
                        "timestamp": dateString]
            
            let childUpdates = ["/likes/\(key)": song]
            ref.updateChildValues(childUpdates)
            isLiked = true;
            likebutton.isUserInteractionEnabled = false;
        }
        
 
    }
    
    private func shouldLike() ->Bool{
        
        
        
        var result = false
    
        if ((self.songTitleLabel.text?.contains("Radio Humber"))!)
        {
            result = false
        }
        
        else if (isLiked)
        {
            result = false
        }
        else
        {
            result = true
        }
        
        return result
    }
    

}



