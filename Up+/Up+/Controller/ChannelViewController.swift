//
//  ChannelViewController.swift
//  Up+
//
//  Created by Dreamup on 3/6/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit
import SendBirdSDK
import AFNetworking

class ChannelViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tbView: UITableView!
    var arrChannel:[SBDOpenChannel]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = SBDOpenChannel.createOpenChannelListQuery()!
        query.loadNextPage(completionHandler: { (channels, error) in
            if error != nil {
                NSLog("Error: %@", error!)
                return
            }
            
            self.arrChannel = channels
            
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
    
    // tableView delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numbercount %d",arrChannel.count)
        return arrChannel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView .dequeueReusableCell(withIdentifier: "cell")
        let name = cell!.contentView.viewWithTag(111) as! UILabel
        
        let channel = arrChannel[indexPath.row]
        name.text = channel.name
        
        let avatar = cell!.contentView.viewWithTag(222) as! UIImageView
        let url = URL(string: channel.coverUrl!)
        avatar.setImageWith(url!, placeholderImage: nil)
        avatar.layer.cornerRadius = avatar.frame.width/2
        avatar.clipsToBounds = true
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tbView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = tbView.indexPathForSelectedRow
        let channel = arrChannel[index!.row]
        
        let destinationVC = segue.destination as! ChannelDetailViewController
        destinationVC.channelURL = channel.channelUrl
        
    }
    
}
