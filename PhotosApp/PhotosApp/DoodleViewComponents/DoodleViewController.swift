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
    var dataSource: DoodleViewControllerDataSource!

    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let doodles = loadDoodles()
        self.dataSource = DoodleViewControllerDataSource(doodles: doodles)
        self.collectionView.delegate = delegateFlowLayout
        self.collectionView.dataSource = dataSource
        
        self.title = "Doodle"
        self.collectionView.backgroundColor = .darkGray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "close", style: .plain, target: self, action: #selector(closeButtonPushed))

    }
    
    private func loadDoodles() -> [Doodle] {
        var doodles = [Doodle]()
        guard let photosData = NSDataAsset(name: "doodle") else { return [Doodle]() }
        do {
            doodles = try JSONDecoder().decode([Doodle].self, from: photosData.data)
        } catch {
            return [Doodle]()
        }
        return doodles
    }
    
    @objc func closeButtonPushed() {
        self.dismiss(animated: true, completion: nil)
    }
}
