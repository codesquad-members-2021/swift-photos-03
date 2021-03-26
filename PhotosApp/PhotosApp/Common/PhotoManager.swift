//
//  PhotoManager.swift
//  PhotosApp
//
//  Created by 이다훈 on 2021/03/25.
//
import UIKit
import Photos

class PhotoManager {
    var allPhotos : PHFetchResult<PHAsset>
    static var shared = PhotoManager()
    
    private init() {
        allPhotos = PHFetchResult<PHAsset>()
    }
    
    func checkAuthorizationStatus() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            self.allPhotos = PHAsset.fetchAssets(with: nil)
        default:
            break
        }
    }
    
    func requestPhotos() {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                self.allPhotos = PHAsset.fetchAssets(with: nil)
            default:
                break
            }
        }
    }
    
    func saveImageToAlbum(with image : UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
