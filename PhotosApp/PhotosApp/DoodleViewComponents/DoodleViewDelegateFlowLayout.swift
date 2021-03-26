//
//  DoodleViewDelegateFlowLayout.swift
//  PhotosApp
//
//  Created by 이다훈 on 2021/03/25.
//

import UIKit

class DoodleViewDelegateFlowLayout : NSObject, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 50)
    }
}
