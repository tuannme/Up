//
//  ImageCache.swift
//  Up+
//
//  Created by Dreamup on 3/8/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit

class ImageCache: NSObject {

    static let shareInstance:ImageCache = {

        let cache = ImageCache()
        return cache
        
    }()
    
    func getImageURL(url:String,completion:@escaping (UIImage?) -> ()) -> Void {
        
        let image = getImageLocal(url: url)
        if(image == nil){
        
            DispatchQueue.global().async(execute: {
                let data = try? Data(contentsOf: URL(string: url)!)
                let image = UIImage(data: data!)
                
                if let data = data{
                    self.saveImageURL(url: url, data: data)
                }
                
                completion(image)
            })
        }else{
            completion(image)
        }
    }
    
    private func saveImageURL(url:String,data:Data){
        let imgName = url.replacingOccurrences(of: "/", with: "_")
        let imgPath = getDocumentsDirectory().appendingPathComponent(imgName)

        do{
           try data.write(to: imgPath)
        }catch let error{
            print(error)
        }
    }
    
    private func getImageLocal(url:String) -> UIImage?{
        
        let imgName = url.replacingOccurrences(of: "/", with: "_")
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let urlImg = NSURL(fileURLWithPath: path)
        let filePath = urlImg.appendingPathComponent(imgName)?.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath!) {
            let image    = UIImage(contentsOfFile: filePath!)
            return image
        }
        return nil
    }
    
    private func getDocumentsDirectory() -> URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        print("path : " + (path?.absoluteString)!)
        return path!
    }
    
    func listDocumentDirectoryfiles() {
        
        let filemanager:FileManager = FileManager()
        let files = filemanager.enumerator(atPath: NSHomeDirectory())
        while let file = files?.nextObject() {
            print(file)
        }
    }
}

extension Data {
    var format: String {
        let array = [UInt8](self)
        let ext: String
        switch (array[0]) {
        case 0xFF:
            ext = "jpg"
        case 0x89:
            ext = "png"
        case 0x47:
            ext = "gif"
        case 0x49, 0x4D :
            ext = "tiff"
        default:
            ext = "unknown"
        }
        return ext
    }
}
