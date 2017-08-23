//
//  CameraKeyBoardViewController.swift
//  Up+
//
//  Created by Dream on 8/23/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit
import Photos

private let photoCell = "photoCell"
private let cameraCell = "cameraCell"
private let optionCell = "optionCell"

protocol CameraKeyBoardDeleagete:class {
    func willSendPhoto(photo:UIImage)
    func willShowCamera()
    func willShowPhotoLibrary()
}

class CameraKeyBoardViewController: UIViewController {

    weak var delegate:CameraKeyBoardDeleagete?
    
    var collectionView:UICollectionView!
    var assetCollection: PHAssetCollection!
    var photosAsset: PHFetchResult<PHAsset>!
    let photoSize = CGSize(width: KEYBOARD_HEIGHT/2 - 0.5, height: KEYBOARD_HEIGHT/2 - 0.5)
    let assetThumbnailSize = CGSize(width: 200, height: 200)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: KEYBOARD_HEIGHT)
        self.view.backgroundColor = UIColor.green
        
        let fetchOptions = PHFetchOptions()
        self.photosAsset = PHAsset.fetchAssets(with: fetchOptions)
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:5)
        layout.scrollDirection = .horizontal
        
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = UIColor.white
        
        self.collectionView.register(PhotoViewCell.self, forCellWithReuseIdentifier: photoCell)
        self.collectionView.register(CameraViewCell.self, forCellWithReuseIdentifier: cameraCell)
        self.collectionView.register(OptionViewCell.self, forCellWithReuseIdentifier: optionCell)
        
        self.view.addSubview(collectionView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.setContentOffset(CGPoint(x: 150, y: 0), animated: false)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



extension CameraKeyBoardViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0,1:
            return 1
        default:
            return self.photosAsset.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let option = collectionView.dequeueReusableCell(withReuseIdentifier: optionCell, for: indexPath) as! OptionViewCell
            option.addEventAction(completion: {
                [weak self] option in
                guard let _self = self else{return}
                if option == .camera{
                    _self.delegate?.willShowCamera()
                }else{
                    _self.delegate?.willShowPhotoLibrary()
                }
                
            })
            return option
        case 1:
            let camera = collectionView.dequeueReusableCell(withReuseIdentifier: cameraCell, for: indexPath) as! CameraViewCell
            camera.addEventSelectPhoto(completion: { [weak self](image) in
                guard let _self = self else{return}
                _self.delegate?.willSendPhoto(photo: image)
            })
            return camera
        default:
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: photoCell, for: indexPath) as! PhotoViewCell
            
            let asset: PHAsset = self.photosAsset[indexPath.item]
            
            PHImageManager.default().requestImage(for: asset, targetSize: self.assetThumbnailSize, contentMode: .aspectFit, options: nil, resultHandler: {(image, info)in
                if image != nil {
                    DispatchQueue.main.async {
                        item.imageView.image = image
                    }
                }
            })
            
            return item
        }
    }
    
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: 150, height: KEYBOARD_HEIGHT)
        case 1:
            return CGSize(width: 170, height: KEYBOARD_HEIGHT)
        default:
            return photoSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            break
        case 1:
            break
        default:
            let asset: PHAsset = self.photosAsset[indexPath.item]
            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 500, height: 500), contentMode: .aspectFit, options: nil, resultHandler: {(image, info)in
                if let _image = image {
                    self.delegate?.willSendPhoto(photo: _image)
                }
            })
            
            break
        }
    }
    
}
