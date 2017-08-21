//
//  MessageFriendViewController.swift
//  Up+
//
//  Created by Nguyen Manh Tuan on 8/20/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit
import SendBirdSDK

class MessageFriendViewController:MessageBaseViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SBDMain.add(self as SBDChannelDelegate, identifier: self.description)
        SBDMain.add(self as SBDConnectionDelegate, identifier: self.description)
        
        SBDGroupChannel.createChannel(withUserIds: [memberId], isDistinct: true) { (channel, error) in
            if error != nil {
                NSLog("Error: %@", error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                self.groupChannel = channel
                self.groupChannel?.markAsRead()
                self.loadPreviousMessage()
            })
        }
    }
    
    func loadPreviousMessage(){
        let messageQuery = groupChannel?.createPreviousMessageListQuery()
        messageQuery?.loadPreviousMessages(withLimit: 30, reverse: false, completionHandler: {
            (messages, error) in
            if error != nil || messages?.count == 0 {
                NSLog("Error: \(String(describing: error))")
                return
            }
            
            DispatchQueue.main.async(execute: {
                self.arrMessage = messages!
                self.tbView.reloadData()
                self.tbView.scrollToRow(at: IndexPath(row: self.arrMessage.count-1, section: 0), at: .bottom, animated: false)
            })
        })
    }
    
    override func sendMessageAction(_ sender: Any) {
        if inputTv.text.characters.count > 0{
            
            let message = inputTv.text
            inputTv.text = ""
            autoResizeTypingTextView()
            tbView.reloadData()
            
            groupChannel?.sendUserMessage(message, data:"TEXT_MESSAGE" , customType: "NORMAL", completionHandler: {
                (message, error) in
                if error != nil {
                    return
                }
                
                DispatchQueue.main.async(execute: {
                    self.arrMessage.append(message!)
                    let indexBottom = IndexPath(row: self.arrMessage.count - 1, section: 0)
                    self.tbView.beginUpdates()
                    
                    self.tbView.insertRows(at: [indexBottom], with: .bottom)
                    self.tbView.endUpdates()
                    self.tbView.scrollToRow(at: indexBottom, at: .bottom, animated: true)
                    //self.tbView.reloadData()
                })
                
            })
            
        }
    }
}

extension MessageFriendViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMessage.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = arrMessage[indexPath.row]
        
        var sender:SBDUser
        var messageContent:String
        
        if (message.isKind(of: SBDUserMessage.self)){
            messageContent = (message as! SBDUserMessage).message!
            sender = (message as! SBDUserMessage).sender!
        }else{
            sender = (message as! SBDFileMessage).sender!
            messageContent = ""
        }
        
        if(sender.userId == myId){
            let cell = tbView.dequeueReusableCell(withIdentifier: "MsgOutGoingCell") as! MsgOutGoingCell
            cell.messageLb.text = messageContent
            return cell
        }
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "MsgInCommingCell") as! MsgInCommingCell
        cell.messageLb.text = messageContent
        return cell
        
    }
}

extension MessageFriendViewController:SBDChannelDelegate,SBDConnectionDelegate{
    // ChannelGroup delegate
    func channelDidUpdateReadReceipt(_ sender: SBDGroupChannel) {
        // Refresh messages
    }
    
    func channelDidUpdateTypingStatus(_ sender: SBDGroupChannel) {
        
    }
    
    func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage) {
        //let translations = (message as! SBDUserMessage).translations
        //let esTranslation = translations?["es"]
        
        DispatchQueue.main.async(execute: {
            self.arrMessage.append(message)
            self.tbView.reloadData()
        })
    }
}



