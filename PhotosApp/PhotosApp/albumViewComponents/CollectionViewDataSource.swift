//
//  CollectionViewDataSource.swift
//  PhotosApp
//
//  Created by Issac on 2021/03/23.
//

import UIKit
import Photos

class CollectionViewDataSource: NSObject {
}

extension CollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotoManager.shared.allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? CustomCell
        else {
            return UICollectionViewCell()
        }
        
        let asset : PHAsset = PhotoManager.shared.allPhotos.object(at: indexPath.item)
        let imageManager = PHCachingImageManager()
        imageManager.requestImage(for: asset,
                                  targetSize: CGSize.init(width: 100, height: 100),
                                  contentMode: .aspectFill,
                                  options: nil,
                                  resultHandler: { image, _ in
                                    cell.imageView.image = image
                                  })
        return cell
    }
}

extension CollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
