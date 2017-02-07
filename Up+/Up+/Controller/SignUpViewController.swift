//
//  SignUpViewController.swift
//  Up
//
//  Created by Dreamup on 2/7/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var repasswordTf: UITextField!
    @IBOutlet weak var signUpBt: UIButton!
    @IBOutlet weak var policyLb: UILabel!
    
    @IBAction func signUpAction(_ sender: Any) {
        
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpBt.layer.cornerRadius = 3.0
        signUpBt.clipsToBounds = true
        signUpBt.layer.masksToBounds = false
        signUpBt.layer.shadowOpacity = 1.0
        signUpBt.layer.shadowOffset = CGSize(width: 0, height: 6)
        signUpBt.layer.shadowColor = UIColor(red: 254.0/255.0, green: 181/255.0, blue: 173/255.0, alpha: 1.0).cgColor

        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(policyAction))
        policyLb.isUserInteractionEnabled = true
        policyLb.addGestureRecognizer(tapGesture)
    }

    func policyAction()  {
        let alert = UIAlertController(title: "this is policy", message: "hello", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { action in

        }
        alert.addAction(action)
        self .present(alert, animated: true, completion: nil)
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
