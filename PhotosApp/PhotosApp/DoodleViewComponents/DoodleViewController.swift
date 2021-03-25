//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by 이다훈 on 2021/03/24.
//

import UIKit
import Photos

class DoodleViewController: UICollectionViewController, UIGestureRecognizerDelegate {
    var doodles = [Doodle]()
    let delegateFlowLayout = DoodleViewDelegateFlowLayout()
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = delegateFlowLayout
        
        self.title = "Doodle"
        self.collectionView.backgroundColor = .darkGray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "close", style: .plain, target: self, action: #selector(closeButtonPushed))
        loadDoodles()
    }
    
    func loadDoodles() {
        guard let photosData = NSDataAsset(name: "doodle") else { return }
        do {
            self.doodles = try JSONDecoder().decode([Doodle].self, from: photosData.data)
        } catch {
            self.doodles = [Doodle]()
            return
        }
    }
    
    @objc func closeButtonPushed() {
        self.dismiss(animated: true, completion: nil)
    }
}
