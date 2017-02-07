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
    
    let messageVC:MessageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MessageViewController") as! MessageViewController
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let sb = UIStoryboard(name: "Main", bundle: nil)
        //messageVC = sb.instantiateViewController(withIdentifier: "MessageViewController") as? MessageViewController
        self.windows .addSubview((messageVC.view)!)
        self .addChildViewController(messageVC)
        
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
        
    }
    
    func contactAction(){
        
    }
    
    func timelineAction(){
        
    }
    
    func moreAction(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
