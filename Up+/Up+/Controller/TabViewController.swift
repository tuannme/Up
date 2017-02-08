//
//  TabViewController.swift
//  Up+
//
//  Created by Dreamup on 2/7/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit

class TabViewController: UIViewController {
    
    @IBOutlet weak var windows: UIView!
    @IBOutlet weak var messageTab: UIView!
    @IBOutlet weak var contactTab: UIView!
    @IBOutlet weak var timelineTab: UIView!
    @IBOutlet weak var moreTab: UIView!
    
    var frameW = UIScreen.main.bounds.size.width
    var frameH = UIScreen.main.bounds.size.height
    var currentTab = 0
    
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
            print("Landscape")
            messageTabLeadingConstraint.constant = -CGFloat(currentTab)*frameH
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
            messageTabLeadingConstraint.constant = -CGFloat(currentTab)*frameW
        }
        
    }
    
    
    
    
}
