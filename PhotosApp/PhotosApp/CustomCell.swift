//
//  CustomCell.swift
//  PhotosApp
//
//  Created by 이다훈 on 2021/03/23.
//

import UIKit

class CustomCell: UICollectionViewCell {
    var imageView : UIImageView = {
        var imageView = UIImageView()
        imageView.bounds = CGRect.init(x: 0, y: 0, width: 80, height: 80)
        return imageView
    }()
    var representedAssetIdentifirer : String!
    
}
