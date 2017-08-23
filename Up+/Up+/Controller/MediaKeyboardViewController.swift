//
//  MediaKeyboardViewController.swift
//  Up+
//
//  Created by Dream on 8/23/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit

class MediaKeyboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.frame =  CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: KEYBOARD_HEIGHT)
        self.view.backgroundColor = UIColor.blue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
