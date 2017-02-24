//
//  MessageViewController.swift
//  Up+
//
//  Created by Dreamup on 2/7/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var spaceToTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTraillingConstraint: NSLayoutConstraint!

    @IBOutlet weak var userLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var cancelTraillingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var searchTf: UITextField!
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var userBt: UIButton!
    
    var topSpace:CGFloat = 20
    
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
//        userBt.layer.cornerRadius = 25
//        userBt.clipsToBounds = true
//        userBt.layer.borderColor = UIColor.black.cgColor
//        userBt.layer.borderWidth = 1.0
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    
    // tableview delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "MessageTbViewCell") as! MessageTbViewCell
        cell.avatar.image =  UIImage(named: "ic_google.png")
        return cell
    }
    
    func rotated(){
        drawBoundSearchView()
    }

}
