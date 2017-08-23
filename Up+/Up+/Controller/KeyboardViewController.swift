//
//  KeyboardViewController.swift
//  Up+
//
//  Created by Dreamup on 2/24/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit

enum KEYBOARD_TYPE{
    case NONE
    case CAMERA
    case DRAW
    case MEDIA
}

class KeyboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setKeyboardType(type:KEYBOARD_TYPE){
        
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        
        switch type {
        case .CAMERA:
            let cameraVC = CameraKeyBoardViewController()
            cameraVC.delegate = self
            self.view.addSubview(cameraVC.view)
            self.addChildViewController(cameraVC)
            break
        case .DRAW:
            let drawVC = DrawKeyboardViewController()
            self.view.addSubview(drawVC.view)
            self.addChildViewController(drawVC)
            break
        case .MEDIA:
            let mediaVC = MediaKeyboardViewController()
            self.view.addSubview(mediaVC.view)
            self.addChildViewController(mediaVC)
            break
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension KeyboardViewController:CameraKeyBoardDeleagete{
    func willShowPhotoLibrary() {
        
    }
    func willShowCamera() {
        
    }
    
    func willSendPhoto(photo: UIImage) {
        
    }
    
}


