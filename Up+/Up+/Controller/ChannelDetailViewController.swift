//
//  ChannelDetailViewController.swift
//  Up+
//
//  Created by Dreamup on 3/6/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit
import SendBirdSDK


class ChannelDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate{
    
    var channelURL:String!
    var openChannel:SBDOpenChannel?
    
    @IBOutlet weak var inputViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tbView: UITableView!
    
    
    @IBOutlet weak var listenView: UIView!
    
    @IBOutlet weak var messageLb: UILabel!
    
    
    @IBOutlet weak var keyboardSpaceBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputTv: UITextView!
    
    @IBOutlet weak var typingMsgView: UIView!
    @IBOutlet weak var typingLeadingSpaceContraint: NSLayoutConstraint!
    @IBOutlet weak var mediaMsgLeadingSpaceConstraint: NSLayoutConstraint!
    
    
    let INPUT_VIEW_MAX_HEIGHT:CGFloat = 70
    let BOTTOM_MARGIN:CGFloat = 0
    let INPUT_SIZE_MIN:CGFloat = 40
    let LINE_HEIGHT:CGFloat = 22.5
    
    var accessoryView:InputAccessoryView?
    
    override var shouldAutorotate: Bool {
        return false
    }
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        accessoryView = InputAccessoryView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height:self.INPUT_VIEW_MAX_HEIGHT))
        accessoryView?.isUserInteractionEnabled = false
        self.inputTv.inputAccessoryView = accessoryView
        self.inputTv.isUserInteractionEnabled = true
        self.inputTv.delegate = self;
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.touchOnInputView))
        self.listenView.isUserInteractionEnabled = true
        self.listenView.addGestureRecognizer(gesture)
        
        typingMsgView.layer.cornerRadius = 10
        typingMsgView.clipsToBounds = true
        typingMsgView.layer.borderColor = UIColor.lightGray.cgColor
        typingMsgView.layer.borderWidth = 1
        
        
        tbView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.interactive
        
        accessoryView?.inputAcessoryViewFrameChangedBlock = {
            (inputAccessoryViewFrame) -> Void in
            let value = self.view.frame.height - inputAccessoryViewFrame.minY - (self.inputTv.inputAccessoryView?.frame.height)! + self.BOTTOM_MARGIN
            self.keyboardSpaceBottomConstraint.constant = max(self.BOTTOM_MARGIN, value);
        }
        
        SBDOpenChannel.getWithUrl(channelURL) { (channel, error) in
            if error != nil {
                NSLog("Error: %@", error!)
                return
            }
            
            self.openChannel = channel
            
            channel?.enter(completionHandler: { (error) in
                if error != nil {
                    NSLog("Error: %@", error!)
                    return
                }
                
            })
        }
        
        
    }
    
    func touchOnInputView(){
        
        if(keyboardSpaceBottomConstraint.constant == 0 && listenView.isHidden == false){
            self.inputTv.becomeFirstResponder()
        }
        
        self.listenView.isHidden = true
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.typingLeadingSpaceContraint.constant = 60
            self.mediaMsgLeadingSpaceConstraint.constant = -150
            self.view.layoutIfNeeded()
            
        }, completion: {
            (finish:Bool) in
            
        })
    }
    
    @IBAction func showMediaMessageAction(_ sender: Any) {
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.typingLeadingSpaceContraint.constant = 150
            self.mediaMsgLeadingSpaceConstraint.constant = 0
            self.view.layoutIfNeeded()
            
        }, completion: {
            (finish:Bool) in
            
        })
        
        self.listenView.isHidden = false
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if(self.mediaMsgLeadingSpaceConstraint.constant == 0){
            self.listenView.isHidden = true
            UIView .animate(withDuration: 0.2, animations: {
                self.typingLeadingSpaceContraint.constant = 60
                self.mediaMsgLeadingSpaceConstraint.constant = -150
                self.view.layoutIfNeeded()
            })
            
        }
        
        let message = textView.text
        let font = UIFont (name: "Helvetica Neue", size: 17)
        let minSize = "A".heightWithConstrainedWidth(width: textView.frame.width, font: font!)
        let height = message?.heightWithConstrainedWidth(width: textView.frame.width, font: font!)
        
        let numberLine = Int(height!/minSize)
        
        if(numberLine >= 5){
            self.inputTv.isScrollEnabled = true
        }else{
            self.inputViewHeightConstraint.constant = INPUT_SIZE_MIN + LINE_HEIGHT*CGFloat((numberLine-1))
            self.inputTv.isScrollEnabled = false
        }
    }
    
    
    func keyboardWillShow(notification:NSNotification){
        
        let animationCurve = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! Int
        let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! CGFloat
        
        let keyboardFrame =  notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as! CGRect
        
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: UIViewAnimationOptions(rawValue: UInt(animationCurve)), animations: {
            
            self.keyboardSpaceBottomConstraint.constant = keyboardFrame.size.height - self.INPUT_VIEW_MAX_HEIGHT
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
        
    }
    
    func keyboardWillHide(notification:NSNotification){
        let animationCurve = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! Int
        let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! CGFloat
        
        if(self.inputTv.text.characters.count == 0){
            self.listenView.isHidden = false
            UIView .animate(withDuration: 0.2, animations: {
                self.typingLeadingSpaceContraint.constant = 150
                self.mediaMsgLeadingSpaceConstraint.constant = 0
                self.view.layoutIfNeeded()
            })
            
        }
        
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: UIViewAnimationOptions(rawValue: UInt(animationCurve)), animations: {
            
            self.keyboardSpaceBottomConstraint.constant = self.BOTTOM_MARGIN
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController!.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "msgInCell")! as UITableViewCell
        return cell;
    }
    
}
