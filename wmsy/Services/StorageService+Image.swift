//
//  StorageService+Image.swift
//  wmsy
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit
import Toucan
import FirebaseStorage

extension StorageService {
    func storeImage(_ image: UIImage, imageID: String) -> StorageUploadTask? {
        let ref = getImagesRef().child(imageID)
        guard let imageData = UIImageJPEGRepresentation(image, 1) else {
            return nil
        }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        return ref.putData(imageData, metadata: metaData, completion: { (storageMetaData, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    
    public func storeUserImage(image: UIImage?, userID: String, completion: @escaping (String) -> Void){
        var downloadURLStr = ""
        guard let image = image else {
            print("no image")
            return
        }
        guard let uploadTask = StorageService.manager.storeImage(image, imageID: userID) else {
            print("error uploading image")
            return
        }
        uploadTask.observe(.success) { (taskSnapshot) in
            guard let downloadURL = taskSnapshot.metadata?.downloadURL() else {
                print("could not download image")
                return
            }
            downloadURLStr = downloadURL.absoluteString
            DBService.manager.addImageToUser(url: downloadURLStr, userID: userID)
            completion(downloadURLStr)
        }
    }
    
    
    
    
    
}

