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
    
 
    @IBOutlet weak var messageTabLeadingConstraint: NSLayoutConstraint!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        messageTabLeadingConstraint.constant = 0
    }
    
    func contactAction(){
        messageTabLeadingConstraint.constant = -UIScreen.main.bounds.size.width
    }
    
    func timelineAction(){
        messageTabLeadingConstraint.constant = -2*UIScreen.main.bounds.size.width
    }
    
    func moreAction(){
        messageTabLeadingConstraint.constant = -3*UIScreen.main.bounds.size.width
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
