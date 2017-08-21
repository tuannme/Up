//
//  JumpDownSegue.swift
//  Up
//
//  Created by Dreamup on 2/7/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit

class JumpDownSegue: UIStoryboardSegue {

    override func perform() {
        
        let sourceViewController = self.source
        let destinationViewController = self.destination
        
        let screenW = UIScreen.main.bounds.size.width
        let screenH = UIScreen.main.bounds.size.height
        
        var desFrame = CGRect(x: 15, y: -screenH, width: screenW - 30, height: screenH)

        destinationViewController.view.frame = desFrame;
        
        // Add the destination view as a subview, temporarily
        
        sourceViewController.view.addSubview(destinationViewController.view)
        sourceViewController.addChildViewController(destinationViewController)
    
        desFrame.origin.y =  0;
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            destinationViewController.view.frame = desFrame
            
        }, completion: {
            (finish:Bool) in
            
        })
    }
    
}
