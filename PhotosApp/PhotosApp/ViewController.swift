//
//  ViewController.swift
//  PhotosApp
//
//  Created by Issac on 2021/03/22.
//

import UIKit
import Photos

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.reloadData()
    }
}
