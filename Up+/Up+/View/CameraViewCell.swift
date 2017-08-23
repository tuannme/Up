//
//  CameraViewCell.swift
//  Up+
//
//  Created by Nguyen Manh Tuan on 8/22/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewCell: UICollectionViewCell {

    var takePhotoCallBack : ((UIImage) -> Void)?
    
    let preview:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 170, height: KEYBOARD_HEIGHT))
    let myButton: UIButton = UIButton()
    
    //Camera Capture requiered properties
    var photoDataOutput:AVCapturePhotoOutput!
    //var videoDataOutput: AVCaptureVideoDataOutput!
    var videoDataOutputQueue: DispatchQueue!
    var previewLayer:AVCaptureVideoPreviewLayer!
    var captureDevice : AVCaptureDevice!
    let session = AVCaptureSession()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        myButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        myButton.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        myButton.layer.masksToBounds = true
        myButton.layer.cornerRadius = 20.0
        myButton.layer.position = CGPoint(x: self.preview.frame.width/2, y:KEYBOARD_HEIGHT - 40)
        myButton.addTarget(self, action: #selector(self.onClickMyButton(sender:)), for: UIControlEvents.touchUpInside)
        
        self.contentView.addSubview(preview)
        self.contentView.addSubview(myButton)
        
        self.setupAVCapture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onClickMyButton(sender:Any) {
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                             kCVPixelBufferWidthKey as String: 160,
                             kCVPixelBufferHeightKey as String: 160]
        settings.previewPhotoFormat = previewFormat
        self.photoDataOutput.capturePhoto(with: settings, delegate: self)
    }
    
    
}

extension CameraViewCell : AVCapturePhotoCaptureDelegate{
    
    func capture(_ output: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            guard let image = UIImage(data: dataImage) else{return}
            takePhotoCallBack?(image)
        }
    }
    
}

extension CameraViewCell{
    
    func addEventSelectPhoto(completion:@escaping ((UIImage) -> Void)){
        takePhotoCallBack = completion
    }
    
    
}

extension CameraViewCell:  AVCaptureVideoDataOutputSampleBufferDelegate{
    func setupAVCapture(){
        session.sessionPreset = AVCaptureSessionPreset640x480
        guard let device = AVCaptureDevice
            .defaultDevice(withDeviceType: .builtInWideAngleCamera,
                           mediaType: AVMediaTypeVideo,
                           position: .back) else{
                            return
        }
        captureDevice = device
        beginSession()
    }
    
    func beginSession(){
        var err : NSError? = nil
        var deviceInput:AVCaptureDeviceInput?
        do {
            deviceInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch let error as NSError {
            err = error
            deviceInput = nil
        }
        if err != nil {
            print("error: \(String(describing: err?.localizedDescription))");
        }
        if self.session.canAddInput(deviceInput){
            self.session.addInput(deviceInput);
        }
        // setting photo mode
        photoDataOutput = AVCapturePhotoOutput()
        if session.canAddOutput(self.photoDataOutput){
            session.addOutput(self.photoDataOutput)
        }
        /* if setting video mode
        videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.alwaysDiscardsLateVideoFrames=true
        videoDataOutputQueue = DispatchQueue(label: "VideoDataOutputQueue")
        videoDataOutput.setSampleBufferDelegate(self, queue:self.videoDataOutputQueue)
        if session.canAddOutput(self.videoDataOutput){
            session.addOutput(self.videoDataOutput)
        }
        videoDataOutput.connection(withMediaType: AVMediaTypeVideo).isEnabled = true
        */
        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        let rootLayer :CALayer = self.preview.layer
        rootLayer.masksToBounds = true
        self.previewLayer.frame = rootLayer.bounds
        rootLayer.addSublayer(self.previewLayer)
        session.startRunning()
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!,
                       didOutputSampleBuffer sampleBuffer: CMSampleBuffer!,
                       from connection: AVCaptureConnection!) {
        // do stuff here
    }
    
    // clean up AVCapture
    func stopCamera(){
        session.stopRunning()
    }
    
}
