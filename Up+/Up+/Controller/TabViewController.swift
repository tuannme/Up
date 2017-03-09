//
//  TabViewController.swift
//  Up+
//
//  Created by Dreamup on 2/7/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit

class TabViewController: UIViewController {
    
    @IBOutlet weak var messageTab: UIView!
    @IBOutlet weak var contactTab: UIView!
    @IBOutlet weak var timelineTab: UIView!
    @IBOutlet weak var moreTab: UIView!
    @IBOutlet weak var lineViewLeadingConstraint: NSLayoutConstraint!
    
    var messageVC:MessageViewController!
    var contactVC:ContactViewController!
    var timeLineVC:TimelineViewController!
    var moreVC:MoreViewController!
    
    var frameW = UIScreen.main.bounds.size.width
    var frameH = UIScreen.main.bounds.size.height
    var currentTab = 0
    var landscape = false
    
    @IBOutlet weak var messageTabLeadingConstraint: NSLayoutConstraint!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(messageAction))
        messageTab.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(contactAction))
        contactTab.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(timelineAction))
        timelineTab.addGestureRecognizer(tap3)
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(moreAction))
        moreTab.addGestureRecognizer(tap4)
        
    }
    
    func messageAction(){
        currentTab = 0
        messageVC.loadChannelList()
        self.rotated()
    }
    
    func contactAction(){
        currentTab = 1
        self.rotated()
    }
    
    func timelineAction(){
        currentTab = 2
        self.rotated()
    }
    
    func moreAction(){
        currentTab = 3
        self.rotated()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rotated() {
        
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            landscape = true
            landscapeAction()
            return
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            landscape = false
            portraitAction()
             return
        }
        
        if(landscape){
            landscapeAction()
        }else{
            portraitAction()
        }
    }
    
    
    func landscapeAction(){
        //print("Landscape")
        landscape = true
        messageTabLeadingConstraint.constant = -CGFloat(currentTab)*frameH
        
        UIView .animate(withDuration: 0.2, animations: {
            self.lineViewLeadingConstraint.constant = CGFloat(self.currentTab)*self.frameH/4;
            self.view.layoutIfNeeded()
        })
    }
    
    func portraitAction(){
        //print("Portrait")
        landscape = false
        messageTabLeadingConstraint.constant = -CGFloat(currentTab)*frameW

        UIView .animate(withDuration: 0.2, animations: {
            self.lineViewLeadingConstraint.constant = CGFloat(self.currentTab)*self.frameW/4;
            self.view.layoutIfNeeded()
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case "message":
            messageVC = segue.destination as! MessageViewController
        case "contact":
            contactVC = segue.destination as! ContactViewController
        case "timeline":
            timeLineVC = segue.destination as! TimelineViewController
        case "more":
            moreVC = segue.destination as! MoreViewController
        default: break
            
        }
    }
}
