//
//  NearbyViewController.swift
//  Up+
//
//  Created by Dreamup on 3/6/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseDatabase


class NearbyViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var nearbyUsers:[User] = []
    
    @IBOutlet weak var tbView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchNearBy()
    }
    
    func searchNearBy()  {
        nearbyUsers.removeAll()
        let ref = FIRDatabase.database().reference()
        ref .child("account").observeSingleEvent(of: .value, with: {
            snapshot -> Void in
            
            if let value = snapshot.value as? NSDictionary{
                
                let arrUser:NSArray = value.allValues as NSArray
                
                for userDic in arrUser{
                    if let userDic = userDic as? NSDictionary{
                        let user = User()
                        user.userId = userDic.object(forKey: "userId") as! String!
                        user.photoURL = userDic.object(forKey: "photoURL") as! String!
                        user.username = userDic.object(forKey: "username") as! String!
                        user.lat = userDic.object(forKey: "lat") as! String!
                        user.lgn = userDic.object(forKey: "lgn") as! String!
                        user.updateAt = userDic.object(forKey: "updateAt") as! String!
                        
                        let mLat = LocationManager.shareInstace.getLatitude()
                        let mLgn = LocationManager.shareInstace.getLongitude()
                        
                        let coordinate1 = CLLocation(latitude: mLat, longitude: mLgn)
                        let coordinate2 = CLLocation(latitude: Double(user.lat!)!, longitude:Double(user.lgn!)!)
                        
                        let distance = coordinate1.distance(from: coordinate2)
                        user.distance = String(distance)
                        
                        self.nearbyUsers.append(user)
                    }
                }
            }
            
            DispatchQueue.main.async(execute: {
                self.tbView.reloadData()
            })
            
        })

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController!.popViewController(animated: true)
    }
    
    // tableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearbyUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let user = nearbyUsers[indexPath.row]
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "Cell")
        
        let avatar = cell?.contentView.viewWithTag(111) as! UIImageView
        avatar.layer.cornerRadius = 20
        avatar.clipsToBounds = true
        
        ImageCache.shareInstance.getImageURL(url: user.photoURL!, completion: {
            image -> Void in
            DispatchQueue.main.async(execute: {
                avatar.image = image
            })
        })
        
        let username = cell?.contentView.viewWithTag(222) as! UILabel
        username.text = user.username
        
        let distance = cell?.contentView.viewWithTag(333) as! UILabel
        distance.text = user.distance
        
        
        return cell!
    }
    
    
    
}
