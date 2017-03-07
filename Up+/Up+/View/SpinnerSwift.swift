//
//  SpinnerSwift.swift
//  Up+
//
//  Created by Nguyen Manh Tuan on 2/26/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit

class SpinnerSwift{
    
    private let spinner:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    private let blueView = UIView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    var isPlaying = false
    static let sharedInstance:SpinnerSwift = {
        let instance = SpinnerSwift()
        instance.setSpinner()
        instance.blueView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        instance.blueView.addSubview(instance.spinner)
        return instance
    }()
    
    private func setSpinner() {
        
        let imageView = UIImageView(frame: spinner.frame)
        imageView.image = UIImage(named: "spinner.png")
        self.spinner.addSubview(imageView)
        self.spinner.center = (UIApplication.shared.keyWindow?.center)!
    }
    
    func startAnimating(){

        if(!isPlaying){
            self.playSpinner(delay: 0)
            UIApplication.shared.keyWindow?.addSubview(blueView)
        }

        isPlaying = true
    }
    
    func playSpinner(delay:TimeInterval) {
        UIView.animate(withDuration: 0.2, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.spinner.transform = self.spinner.transform.rotated(by: CGFloat(M_PI))
            
        }, completion: {
            finish in
            if(self.isPlaying){
                self.playSpinner(delay: 0)
            }
        })
    }
    
    func  stopAnimating(){
        isPlaying = false
        blueView.removeFromSuperview()
    }
    

}
