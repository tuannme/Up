//
//  DetailMessageViewController.swift
//  Up+
//
//  Created by Dreamup on 2/24/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit

class DetailMessageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var keyboardSpaceBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputTv: UITextView!
    
    let INPUT_VIEW_MAX_HEIGHT:CGFloat = 70
    let BOTTOM_MARGIN:CGFloat = 30
    var accessoryView:InputAccessoryView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        accessoryView = InputAccessoryView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height:self.INPUT_VIEW_MAX_HEIGHT))
        accessoryView?.isUserInteractionEnabled = false
        self.inputTv.inputAccessoryView = accessoryView
        self.inputTv.isUserInteractionEnabled = true
        
        tbView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.interactive
        
        accessoryView?.inputAcessoryViewFrameChangedBlock = { (inputAccessoryViewFrame) -> Void in
            let value = self.view.frame.height - inputAccessoryViewFrame.minY - (self.inputTv.inputAccessoryView?.frame.height)! + self.BOTTOM_MARGIN
            self.keyboardSpaceBottomConstraint.constant = max(self.BOTTOM_MARGIN, value);
        }
        
    }
    
    func keyboardWillShow(notification:NSNotification){
        
        let animationCurve = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! Int
        let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! CGFloat
        
        let keyboardFrame =  notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect
  
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: UIViewAnimationOptions(rawValue: UInt(animationCurve)), animations: {
            
            self.keyboardSpaceBottomConstraint.constant = keyboardFrame.size.height + self.BOTTOM_MARGIN
            print(keyboardFrame.size.height)
          
            
        }, completion: nil)
        
    }
    
    func keyboardWillHide(notification:NSNotification){
        
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
