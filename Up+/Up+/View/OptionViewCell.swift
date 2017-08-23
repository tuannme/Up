//
//  OptionCell.swift
//  Up+
//
//  Created by Dream on 8/23/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit

enum Option{
    case camera
    case photoLib
}

class OptionViewCell: UICollectionViewCell {
    
    var optionCallBack : ((Option) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let cameraView = UIView(frame: CGRect(x: 20, y: 15, width: 110, height: KEYBOARD_HEIGHT/2 - 25))
        cameraView.layer.cornerRadius = 10
        cameraView.clipsToBounds = true
        cameraView.backgroundColor = UIColor.white
        
        let cameraImv = UIImageView(frame: CGRect(x: 35, y: 20, width: 40, height: 30))
        cameraImv.image = UIImage(named: "ic_keyboard_camera.png")
        cameraView.addSubview(cameraImv)
        
        let cameraLb = UILabel(frame: CGRect(x: 0, y: 60, width: 110, height: 20))
        cameraLb.text = "Camera"
        cameraLb.textColor = UIColor.black
        cameraLb.textAlignment = .center
        cameraLb.font = UIFont.systemFont(ofSize: 13)
        cameraView.addSubview(cameraLb)
        
        let photoView = UIView(frame: CGRect(x: 20, y: KEYBOARD_HEIGHT/2 + 10, width: 110, height: KEYBOARD_HEIGHT/2 - 25))
        photoView.layer.cornerRadius = 10
        photoView.clipsToBounds = true
        photoView.backgroundColor = UIColor.white
        
        let photoImv = UIImageView(frame: CGRect(x: 35, y: 20, width: 40, height: 30))
        photoImv.image = UIImage(named: "ic_keyboard_camera.png")
        photoView.addSubview(photoImv)
        
        let photoLb = UILabel(frame: CGRect(x: 0, y: 60, width: 110, height: 20))
        photoLb.text = "Photo Library"
        photoLb.textColor = UIColor.black
        photoLb.textAlignment = .center
        photoLb.font = UIFont.systemFont(ofSize: 12)
        photoView.addSubview(photoLb)
        
        self.contentView.addSubview(cameraView)
        self.contentView.addSubview(photoView)
        
        let cameraGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapCamera))
        cameraView.isUserInteractionEnabled = true
        cameraView.addGestureRecognizer(cameraGesture)
        
        let photoGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapPhotoLibrary))
        photoView.isUserInteractionEnabled = true
        photoView.addGestureRecognizer(photoGesture)
        
        self.backgroundColor = UIColor.init(colorLiteralRed: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didTapCamera(){
        self.optionCallBack?(.camera)
    }
    func didTapPhotoLibrary(){
        self.optionCallBack?(.photoLib)
    }
    
    
    func addEventAction(completion:@escaping ((Option) -> Void)){
        optionCallBack = completion
    }
    
}
