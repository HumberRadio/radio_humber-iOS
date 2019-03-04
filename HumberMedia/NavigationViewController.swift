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

class NavigationViewController: ButtonBarPagerTabStripViewController, XMLParserDelegate, FRadioPlayerDelegate, CircleMenuDelegate  {
    // UI outlets
    
    //Buttons
    @IBOutlet weak var playbutton: FaveButton!
    @IBOutlet weak var stopbutton: FaveButton!
    @IBOutlet weak var infobutton: FaveButton!
    @IBOutlet weak var infoMenuButton: CircleMenu!
    //Labels
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    //Views
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var infoTextView: UIView!
    
    @IBOutlet weak var radioImageView: UIImageView!
    
    
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
    
   
    //properties
    
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    var headphonesStatus:Bool = false
    var isradioOpen:Bool = false
    let player = FRadioPlayer.shared
    var player2: AVPlayer?
    var scrollView: BubbleScrollView!
    
    
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
        if !isradioOpen
        {
            animateRadioBarOpen()
            scrollView = BubbleScrollView.create()
            self.view.addSubview(scrollView)
            scrollView.size(withMainView: self.view)
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
    
    //*****************************************************************
    // MARK: - RADIO BAR ANIMATIONS
    //*****************************************************************
    
    private func animateRadioBarOpen()
    {
        UIView.animate(withDuration: 3.0, animations:{
           
            // bring whole bottme view to top
            self.bottomViewHeight.constant = self.view.frame.height * 0.70
            
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
        })
        
    }
    private func animateRadioBarClose()
    {
        self.isradioOpen = true
        UIView.animate(withDuration: 3.0, animations:{
            
            // bring whole bottme view to top
            self.bottomViewHeight.constant = 80
            
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
    

}


// MARK: - Conversation Bubble

class ConversationBubble: UIButton {
    
    static fileprivate let outAnimationDuration: TimeInterval = 0.35
    static fileprivate let inAnimationDuration: TimeInterval = 1
    
    private(set) var positionConstraints: BubbleConstraints!
    private(set) var floatingContainer: UIView!
    private var animation: anim?
    
    class func create() -> ConversationBubble {
        let view = ConversationBubble()
        
        view.floatingContainer = UIView()
        view.addSubview(view.floatingContainer)
        view.floatingContainer.backgroundColor = UIColor.lightGray
        view.floatingContainer.isUserInteractionEnabled = false
        
        view.positionConstraints = BubbleConstraints(for: view)
        view.backgroundColor = UIColor.clear
        
        view.addTarget(view, action: #selector(self.tapAction), for: .touchUpInside)
        NotificationCenter.default.addObserver(view, selector: #selector(self.scrollHandler), name: AnimEvent.conversationScroll, object: nil)
        
        return view
    }
    
    func position(on parent: UIView, under: ConversationBubble? = nil) {
        positionConstraints.place(at: parent, under: under)
    }
    
    
    // MARK: View Overrides
    
    override func layoutSubviews() {
        super.layoutSubviews()
        positionConstraints.updateCornerRadius()
    }
    
    
    // MARK: Floating Animation
    
    func animateFloating() {
        self.floatToNewPosition()
    }
    
    private func floatToNewPosition() {
        guard let parent = positionConstraints.parent else {
            return
        }
        
        let randomPosition = CGFloat(10).randomPointWithRadius
        
        let randomDuration = DoubleRange(min: 1.2, max: 3.3).random
        let randomDelay = DoubleRange(min: 0, max: 0.2).random
        
        animation = anim(constraintParent: parent) { (settings) -> animClosure in
            settings.ease = .easeInOutSine
            settings.duration = randomDuration
            settings.delay = randomDelay
            settings.isUserInteractionsEnabled = true
            settings.completion = self.floatToNewPosition
            return {
                self.positionConstraints.positionFloatingContainer(x: randomPosition.x, y: randomPosition.y)
            }
        }
        
    }
    
    
    // MARK: Position / Animate (Shared)
    
    func stopAnimation() {
        animation?.stop()
        animation = nil
    }
    
    
    // MARK: Bounce On Edge Animation
    
    private func bounceOnEndScroll(withVelocity velocity: CGFloat) {
        guard let parent = positionConstraints.parent else {
            return
        }
        
        stopAnimation()
        
        let initialDuration = DoubleRange(min: 0.18, max: 0.28).random
        let initialHorizontalDrift = DoubleRange(min: -0.4, max: 0.4).random.cgFloat
        let initialVelocityMultiplier = DoubleRange(min: 2.1, max: 2.9).random.cgFloat
        
        animation = anim(constraintParent: parent) { (settings) -> animClosure in
            settings.ease = .easeOutQuad
            settings.duration = initialDuration
            settings.isUserInteractionsEnabled = true
            return {
                self.positionConstraints.positionFloatingContainer(x: velocity*initialHorizontalDrift, y: -velocity*initialVelocityMultiplier)
            }
            }
            .then(constraintParent: parent, { (settings) -> animClosure in
                settings.ease = .easeInOutQuad
                settings.duration = 0.4
                settings.isUserInteractionsEnabled = true
                return {
                    self.positionConstraints.positionFloatingContainer(x: 0, y: velocity*0.3)
                }
            })
            .then(constraintParent: parent, { (settings) -> animClosure in
                settings.ease = .easeInOutSine
                settings.duration = 0.5
                settings.isUserInteractionsEnabled = true
                return {
                    self.positionConstraints.positionFloatingContainer(x: 0, y: 0)
                }
            })
            .callback {
                self.animateFloating()
        }
    }
    
    
    // MARK: In Animation
    
    func prepareAnimateIn() {
        stopAnimation()
        
        self.positionConstraints.positionFloatingContainer(x: 0, y: 200)
        self.alpha = 0
    }
    
    func animateIn(delay: TimeInterval) {
        guard let parent = positionConstraints.parent else {
            return
        }
        
        anim { (settings) -> (animClosure) in
            settings.duration = 0.4
            settings.delay = delay
            return {
                self.alpha = 1
            }
        }
        
        anim(constraintParent: parent) { (settings) -> animClosure in
            settings.duration = ConversationBubble.inAnimationDuration * 0.5
            settings.ease = .easeOutQuint
            settings.delay = delay
            return {
                self.positionConstraints.positionFloatingContainer(x: 0, y: -10)
            }
            }
            .then(constraintParent: parent, { (settings) -> animClosure in
                settings.duration = ConversationBubble.inAnimationDuration * 0.5
                settings.ease = .easeInOutQuad
                return {
                    self.positionConstraints.positionFloatingContainer(x: 0, y: 0)
                }
            })
            .callback {
                self.animateFloating()
        }
        
    }
    
    
    // MARK: Out Animation
    
    func animateOut(delay: TimeInterval) {
        guard let parent = positionConstraints.parent else {
            return
        }
        
        stopAnimation()
        
        anim { (settings) -> (animClosure) in
            settings.duration = ConversationBubble.outAnimationDuration
            settings.ease = .easeInQuint
            settings.delay = delay
            return {
                self.alpha = 0
            }
        }
        
        anim(constraintParent: parent) { (settings) -> animClosure in
            settings.duration = ConversationBubble.outAnimationDuration
            settings.ease = .easeInQuint
            settings.delay = delay
            return {
                self.positionConstraints.positionFloatingContainer(x: 0, y: 200)
            }
        }
    }
    
    
    // MARK: Down Animation
    
    func animateDown(_ completion: @escaping ()->Void) {
        
        
        anim { (settings) -> (animClosure) in
            settings.duration = 0.15
            settings.ease = .easeOutQuint
            return {
                self.transform = CGAffineTransform.identity.scaledBy(x: 0.93, y: 0.93)
                self.floatingContainer.backgroundColor = UIColor.lightGray
            }
            }
            .callback {
                completion()
        }
    }
    
    func restoreAnimateDown() {
        self.transform = CGAffineTransform.identity
        self.floatingContainer.backgroundColor = UIColor.lightGray
    }
    
    
    // MARK: Actions / Handlers
    
    @objc
    func tapAction() {
        NotificationCenter.default.post(name: AnimEvent.navigateToConversation, object: self)
    }
    
    @objc
    func scrollHandler(notification: Notification) {
        guard let velocity = notification.userInfo?["velocity"] as? CGPoint else {
            return
        }
        
        let limit: CGFloat = 28
        let velocityY = max(min(velocity.y, limit), -limit)
        bounceOnEndScroll(withVelocity: velocityY)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        removeTarget(self, action: #selector(self.tapAction), for: .touchUpInside)
    }
}


// MARK: - Bubble Scroll View

class BubbleScrollView: UIScrollView, UIScrollViewDelegate {
    
    static fileprivate let bubbleCount = 13
    static fileprivate let inAnimationDelayBetweenBubbles = 0.08
    static fileprivate let outAnimationDelayBetweenBubbles = 0.04
    
    private(set) var bubbleContainer: UIView!
    private var previousOffset: CGPoint?
    private var velocity: CGPoint = CGPoint.zero
    private var bubbles: [ConversationBubble]?
    
    var bubblesInScreen: [ConversationBubble] {
        guard let bubbles = bubbles else {
            return [ConversationBubble]()
        }
        
        var array = [ConversationBubble]()
        for bubble in bubbles {
            if !(bubble.frame.origin.y+bubble.frame.size.height < contentOffset.y || bubble.frame.origin.y > contentOffset.y+frame.size.height) {
                array.append(bubble)
            }
        }
        
        return array
    }
    
    class func create() -> BubbleScrollView {
        let view = BubbleScrollView()
        
        view.delegate = view
        view.bounces = false
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        
        view.bubbleContainer = UIView()
        view.bubbleContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view.bubbleContainer)
        
        view.bubbles = [ConversationBubble]()
        var lastBubble: ConversationBubble? = nil
        for _ in 0..<bubbleCount {
            let bubble = ConversationBubble.create()
            bubble.position(on: view.bubbleContainer, under: lastBubble)
            bubble.animateFloating()
            view.bubbles?.append(bubble)
            lastBubble = bubble
        }
        
        return view
    }
    
    func size(withMainView mainView: UIView) {
        self.snapEdges(to: mainView)
        
        guard let lastBubble = bubbles?.last else {
            return
        }
        
        mainView.addConstraints([
            NSLayoutConstraint(item: bubbleContainer, attribute: .width, relatedBy: .equal, toItem: mainView, attribute: .width, multiplier: 1, constant: 0)
            ])
        
        self.addConstraints([
            NSLayoutConstraint(item: bubbleContainer, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: bubbleContainer, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: bubbleContainer, attribute: .bottom, relatedBy: .equal, toItem: lastBubble, attribute: .bottom, multiplier: 1, constant: 0)
            ])
    }
    
    // MARK: View Overrides
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let containerFrame = subviews.first?.frame else {
            return
        }
        
        contentSize = containerFrame.size
    }
    
    
    // MARK: Scroll View Delegates
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        defer {
            previousOffset = contentOffset
        }
        
        guard let previousOffset = previousOffset else {
            return
        }
        
        if contentOffset.y <= 0 || contentOffset.y + scrollView.frame.size.height - contentInset.bottom >= contentSize.height  {
            NotificationCenter.default.post(name: AnimEvent.conversationScroll, object: nil, userInfo: ["velocity": velocity])
        }
        
        let currentVelocity = contentOffset - previousOffset
        velocity = CGPoint.lerp(current: velocity, target: currentVelocity, t: 0.5)
    }
    
    
    // MARK: Position / Animate
    
    func prepareAnimateIn() {
        bubbles?.forEach { (bubble) in
            bubble.prepareAnimateIn()
        }
    }
    
    func animateIn() {
        guard let bubbles = bubbles else {
            return
        }
        
        for (index, bubble) in bubbles.enumerated() {
            bubble.animateIn(delay: Double(index) * BubbleScrollView.inAnimationDelayBetweenBubbles)
        }
    }
    
    func animateOut() {
        let bubblesReverseEnumerated = bubblesInScreen.reversed().enumerated()
        for (index, bubble) in bubblesReverseEnumerated {
            bubble.animateOut(delay: Double(index) * BubbleScrollView.outAnimationDelayBetweenBubbles)
        }
    }
}

