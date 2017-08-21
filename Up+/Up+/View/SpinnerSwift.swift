//
//  SpinnerSwift.swift
//  Up+
//
//  Created by Nguyen Manh Tuan on 2/26/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SpinnerSwift{
    
    
    let spinner = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60), type: .ballSpinFadeLoader, color: .white, padding: 0)
    private let blueView = UIView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    var isPlaying = false
    static let sharedInstance:SpinnerSwift = {
        let instance = SpinnerSwift()
        
        instance.spinner.center = (UIApplication.shared.keyWindow?.center)!
        
        let background = UIView(frame:instance.blueView.frame)
        background.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        instance.blueView.addSubview(background)
        instance.blueView.addSubview(instance.spinner)
        return instance
    }()
    
    private func setSpinner() {

        
    }
    
    func startAnimating(){
        stopAnimating()
        spinner.startAnimating()
        UIApplication.shared.keyWindow?.addSubview(blueView)
    
    }

    func  stopAnimating(){
        blueView.removeFromSuperview()
        spinner.stopAnimating()
    }
    

}
