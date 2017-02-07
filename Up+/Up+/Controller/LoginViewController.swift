//
//  LoginViewController.swift
//  Up
//
//  Created by Dreamup on 2/7/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var loginBt: UIButton!
    @IBOutlet weak var fbLoginBt: UIButton!
    @IBOutlet weak var googleLoginBt: UIButton!
    
    @IBOutlet weak var loginSpaceBottomConstraint: NSLayoutConstraint!
    
    
    @IBAction func forgotAction(_ sender: Any) {
    }
    
    @IBAction func loginAction(_ sender: Any) {
    }
    
    @IBAction func createAccountAction(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        fbLoginBt.delegate = self;
        //        fbLoginBt.layer.cornerRadius = 20;
        //        fbLoginBt.clipsToBounds = YES;
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        loginBt.layer.cornerRadius = 5.0
        loginBt.clipsToBounds = true
        loginBt.layer.masksToBounds = false
        loginBt.layer.shadowOpacity = 1.0
        loginBt.layer.shadowOffset = CGSize(width: 0, height: 6)
        loginBt.layer.shadowColor = UIColor(red: 254.0/255.0, green: 181/255.0, blue: 173/255.0, alpha: 1.0).cgColor
        
        emailTf.delegate = self
        passwordTf.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
    func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("Landscape")
            loginSpaceBottomConstraint.constant = 150
            
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
            let height = 195 + 170*(view.frame.height/568)
            loginSpaceBottomConstraint.constant = view.frame.size.height - height
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == emailTf){
            passwordTf.becomeFirstResponder()
        }else{
            self.view.endEditing(true)
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
