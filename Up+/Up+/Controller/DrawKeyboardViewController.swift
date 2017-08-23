//
//  DrawKeyboardViewController.swift
//  Up+
//
//  Created by Dream on 8/23/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit

class DrawKeyboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.frame =  CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: KEYBOARD_HEIGHT)
        self.view.backgroundColor = UIColor.red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
