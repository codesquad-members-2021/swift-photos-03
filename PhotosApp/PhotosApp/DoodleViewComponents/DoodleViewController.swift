//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by 이다훈 on 2021/03/24.
//

import UIKit
import Photos

class DoodleViewController: UICollectionViewController, UIGestureRecognizerDelegate {
    
    let delegateFlowLayout = DoodleViewDelegateFlowLayout()
    let dataSource = DoodleViewControllerDataSource()
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = delegateFlowLayout
        self.collectionView.dataSource = dataSource
        
        self.title = "Doodle"
        self.collectionView.backgroundColor = .darkGray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "close", style: .plain, target: self, action: #selector(closeButtonPushed))

    }
    
    
    
    @objc func closeButtonPushed() {
        self.dismiss(animated: true, completion: nil)
    }
}
