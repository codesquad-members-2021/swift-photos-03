//
//  ViewController.swift
//  PhotosApp
//
//  Created by Issac on 2021/03/22.
//

import UIKit
import Photos

class ViewController: UIViewController, PHPhotoLibraryChangeObserver {
    @IBOutlet weak var collectionView: PhotosColectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.reloadData()
        PHPhotoLibrary.shared().register(self)
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        var assetCollection = collectionView.collecitonViewDataSource.allPhotos
        
        DispatchQueue.main.sync {
            guard let changes = changeInstance.changeDetails(for: assetCollection!)
            else {
                return
            }
            
            assetCollection = changes.fetchResultAfterChanges
            
            if changes.hasIncrementalChanges {
                collectionView.performBatchUpdates({
                    if let removed = changes.removedIndexes , removed.count > 0 {
                        collectionView.deleteItems(at: removed.map { IndexPath(item: $0, section:0) })
                    }
                    if let inserted = changes.insertedIndexes , inserted.count > 0 {
                        collectionView.insertItems(at: inserted.map { IndexPath(item: $0, section:0) })
                    }
                    if let changed = changes.changedIndexes , changed.count > 0 {
                        collectionView.reloadItems(at: changed.map { IndexPath(item: $0, section:0) })
                    }
                    changes.enumerateMoves { fromIndex, toIndex in
                        self.collectionView.moveItem(at: IndexPath(item: fromIndex, section: 0),
                                                     to: IndexPath(item: toIndex, section: 0))
                    }
                })
            } else {
                collectionView.reloadData()
            }
        }
    }
    
}
