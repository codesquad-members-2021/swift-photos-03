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
    
    @IBAction func addButtonPushed(_ sender: Any) {
        let doodleStoryboard = UIStoryboard.init(name: "Doodle", bundle: nil)
        guard let doodleVC = doodleStoryboard.instantiateViewController(identifier: "DoodleViewController") as? DoodleViewController else {return}
        
        let navigationController = UINavigationController(rootViewController: doodleVC)
        
        present(navigationController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PhotoManager.shared.requestPhotos()
        PhotoManager.shared.checkAuthorizationStatus()
        self.collectionView.reloadData()
        PHPhotoLibrary.shared().register(self)
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {        
        DispatchQueue.main.async {
            guard let changes = changeInstance.changeDetails(for: PhotoManager.shared.allPhotos)
            else {
                return
            }
            
            PhotoManager.shared.allPhotos = changes.fetchResultAfterChanges
            
            if changes.hasIncrementalChanges {
                self.collectionView.performBatchUpdates({
                    if let removed = changes.removedIndexes , removed.count > 0 {
                        self.collectionView.deleteItems(at: removed.map { IndexPath(item: $0, section:0) })
                    }
                    if let inserted = changes.insertedIndexes , inserted.count > 0 {
                        self.collectionView.insertItems(at: inserted.map { IndexPath(item: $0, section:0) })
                    }
                    if let changed = changes.changedIndexes , changed.count > 0 {
                        self.collectionView.reloadItems(at: changed.map { IndexPath(item: $0, section:0) })
                    }
                    changes.enumerateMoves { fromIndex, toIndex in
                        self.collectionView.moveItem(at: IndexPath(item: fromIndex, section: 0),
                                                     to: IndexPath(item: toIndex, section: 0))
                    }
                })
            } else {
                self.collectionView.reloadData()
            }
        }
    }
    
}
