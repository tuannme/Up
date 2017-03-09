//
//  MessageViewController.swift
//  Up+
//
//  Created by Dreamup on 2/7/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit
import AFNetworking
import SendBirdSDK

class MessageViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource,
    UITextFieldDelegate,
    SBDConnectionDelegate,SBDChannelDelegate {
    
    @IBOutlet weak var spaceToTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTraillingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var userLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var cancelTraillingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var searchTf: UITextField!
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var userBt: UIButton!
    
    
    var timeTry:Double = 0
    
    var topSpace:CGFloat = 20
    var channelList:[SBDGroupChannel] = []
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SBDMain.add(self as SBDChannelDelegate, identifier: self.description)
        SBDMain.add(self as SBDConnectionDelegate, identifier: self.description)
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        cancelTraillingConstraint.constant = -70
        
        searchContainerView.layer.masksToBounds = true
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect:
            CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 60),
                                      byRoundingCorners:  [.topLeft,.topRight],
                                      cornerRadii: CGSize(width: 5, height: 5)).cgPath
        searchContainerView.layer.mask = maskLayer
        
        searchTf.delegate = self;
        searchTf.placeholder = "Search"
        searchTf.textAlignment = NSTextAlignment.center
        
        loadChannelList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // channel connect delegate
    func didStartReconnection() {
        print("Network has been disconnected. Auto reconnecting starts")
        
    }
    
    func didSucceedReconnection() {
        print("Auto reconnecting succeeded")
    }
    
    func didFailReconnection() {
        print("Auto reconnecting failed. You should call `connect` to reconnect to SendBird.")
 
    }
    
    
    func loadChannelList()  {
        let query = SBDGroupChannel.createMyGroupChannelListQuery()!
        query.includeEmptyChannel = false
        
        query.loadNextPage(completionHandler: { (channels, error) in
            if (error != nil) {
                print(error!)
                
                self.timeTry = self.timeTry + 1
                self.perform(#selector(self.loadChannelList), with: nil, afterDelay: 1)
                
                return;
            }
            
            DispatchQueue.main.async(execute: {
                self.channelList = channels!
                self.tbView.reloadData()
            })
        })
    }
    
    func rotated(){
        drawBoundSearchView()
    }
    
    

    func drawBoundSearchView() {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect:
            CGRect(x: 0, y: 0, width: searchContainerView.frame.size.width, height: 60),
                                      byRoundingCorners:  [.topLeft,.topRight],
                                      cornerRadii: CGSize(width: 5, height: 5)).cgPath
        searchContainerView.layer.mask = maskLayer
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    
    // TextFied Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2, animations: {
            self.searchTraillingConstraint.constant = 70
            self.searchLeadingConstraint.constant = 10
            self.cancelTraillingConstraint.constant = 0;
            self.userLeadingConstraint.constant = -40;
            self.searchTf.textAlignment = NSTextAlignment.left
            self.view.layoutIfNeeded()
        })
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        
        searchTf.resignFirstResponder()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.searchTraillingConstraint.constant = 40
            self.searchLeadingConstraint.constant = 50
            self.cancelTraillingConstraint.constant = -70;
            self.userLeadingConstraint.constant = 0;
            self.searchTf.textAlignment = NSTextAlignment.center
            self.view.layoutIfNeeded()
        })
    }
    
    // Scroll delegate
    
    var oldContentOffset = CGPoint(x: 0, y: 0)
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta =  scrollView.contentOffset.y - oldContentOffset.y
        
        //we compress the top view
        if delta > 0 && spaceToTopConstraint.constant > topSpace && scrollView.contentOffset.y > 0 {
            
            let temp = spaceToTopConstraint.constant - delta
            spaceToTopConstraint.constant = temp > topSpace ? temp : topSpace
        }
        
        //we expand the top view
        if delta < 0 && spaceToTopConstraint.constant < 120 && scrollView.contentOffset.y < 0{
            
            let temp = spaceToTopConstraint.constant - delta
            spaceToTopConstraint.constant = temp > 120 ? 120 : temp
        }
        
        oldContentOffset = scrollView.contentOffset
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(spaceToTopConstraint.constant > 20){
            UIView.animate(withDuration: 0.2, animations: {
                self.spaceToTopConstraint.constant = 20
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(spaceToTopConstraint.constant > 20){
            UIView.animate(withDuration: 0.1, animations: {
                self.spaceToTopConstraint.constant = 20
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = tbView.indexPathForSelectedRow
        
        if let index = index{
            let channel = channelList[index.row]
            let user = channel.members?.lastObject
            
            if let user = user {
                
                let userId = (user as! SBDUser).userId
                let messageVC = segue.destination as! DetailMessageViewController
                messageVC.memberId = userId
                
            }
        }
    }
    
    
    // tableview delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "MessageTbViewCell") as! MessageTbViewCell
        cell.avatar.image =  UIImage(named: "ic_google.png")
        
        let groupChannel = channelList[indexPath.row]
        let lastMessage = groupChannel.lastMessage
        
        let mesgOwn = cell.contentView.viewWithTag(222) as! UILabel
        let user = groupChannel.members?.lastObject as! SBDUser
        mesgOwn.text = user.nickname
        
        if let lastMessage = lastMessage{
            let mesgContent = cell.contentView.viewWithTag(333) as! UILabel
            mesgContent.text = (lastMessage as! SBDUserMessage).message
        }
        
       
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tbView.deselectRow(at: indexPath, animated: true)
        
    }
}
