//
//  CollectionViewDataSource.swift
//  PhotosApp
//
//  Created by Issac on 2021/03/23.
//

import UIKit
import Photos

class CollectionViewDataSource: NSObject {
    var allPhotos : PHFetchResult<PHAsset>
    
    override init() {
            self.allPhotos = PHFetchResult<PHAsset>()
            super.init()
            self.requestPhotos()
            self.checkAuthorizationStatus()
        }
        
        private func checkAuthorizationStatus() {
            let status = PHPhotoLibrary.authorizationStatus()
            switch status {
            case .authorized:
                self.allPhotos = PHAsset.fetchAssets(with: nil)
            default:
                break
            }
        }
        
        private func requestPhotos() {
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    self.allPhotos = PHAsset.fetchAssets(with: nil)
                default:
                    break
                }
            }
        }
}

extension CollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? CustomCell
        else {
            return UICollectionViewCell()
        }
        
        let asset : PHAsset = self.allPhotos.object(at: indexPath.item)
        let imageManager = PHCachingImageManager()
        imageManager.requestImage(for: asset,
                                  targetSize: CGSize.init(width: 100, height: 100),
                                  contentMode: .aspectFill,
                                  options: nil,
                                  resultHandler: { image, _ in
                                    cell.imageView.image = image!
                                  })
        cell.backgroundColor = getRandomColor()
        return cell
    }
    
    func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}

extension CollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
