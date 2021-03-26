//
//  PhotosCollectionView.swift
//  PhotosApp
//
//  Created by Issac on 2021/03/23.
//

import UIKit

class PhotosColectionView: UICollectionView {
    private var collecitonViewDataSource = CollectionViewDataSource()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.dataSource = collecitonViewDataSource
        self.delegate = collecitonViewDataSource
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.dataSource = collecitonViewDataSource
        self.delegate = collecitonViewDataSource
    }
}
