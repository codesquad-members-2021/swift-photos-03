//
//  CollectionViewDataSource.swift
//  PhotosApp
//
//  Created by Issac on 2021/03/23.
//

import UIKit
import Photos

class CollectionViewDataSource: NSObject {
    var allPhotos : PHFetchResult<PHAsset>?
    
}

extension CollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? CustomCell
        else {
            return UICollectionViewCell()
        }
        
        self.allPhotos = PHAsset.fetchAssets(with: nil)
        let asset : PHAsset = (self.allPhotos?.object(at: indexPath.item))!
        let imageManager = PHCachingImageManager()
        let option = PHImageRequestOptions()
        
        cell.representedAssetIdentifirer = asset.localIdentifier
        
        imageManager.requestImage(for: asset, targetSize: CGSize.init(width: 80, height: 80), contentMode: .aspectFit, options: option, resultHandler: { image, _ in
            print(image)
            if cell.representedAssetIdentifirer == asset.localIdentifier {
                cell.imageView.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
                cell.imageView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
                cell.imageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
                cell.imageView.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
                cell.imageView.image = image!
                
            }
            
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
        return CGSize(width: 80, height: 80)
    }
}
