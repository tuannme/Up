//
//  NearbyViewController.swift
//  Up+
//
//  Created by Dreamup on 3/6/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit

class NearbyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backAction(_ sender: Any) {
       self.navigationController!.popViewController(animated: true)
    }

}
