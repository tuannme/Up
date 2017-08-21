//
//  TimelineViewController.swift
//  Up+
//
//  Created by Nguyen Manh Tuan on 2/7/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var spaceToTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tbView: UITableView!
    
    var feeds:[String] = [""]
    
    
    var topSpace:CGFloat = 20
    
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        headerView.layer.masksToBounds = true
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect:
            CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 60),
                                      byRoundingCorners:  [.topLeft,.topRight],
                                      cornerRadii: CGSize(width: 5, height: 5)).cgPath
        headerView.layer.mask = maskLayer
        
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func drawBoundSearchView() {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect:
            CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: 60),
                                      byRoundingCorners:  [.topLeft,.topRight],
                                      cornerRadii: CGSize(width: 5, height: 5)).cgPath
        headerView.layer.mask = maskLayer
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
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
    
        return feeds.count
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 15))
        header.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "Cell")
        return cell!
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tbView.deselectRow(at: indexPath, animated: true)
    }
    
    func rotated(){
        drawBoundSearchView()
    }
    
}

