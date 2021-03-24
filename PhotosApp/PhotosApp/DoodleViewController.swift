//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by 이다훈 on 2021/03/24.
//

import UIKit

class DoodleViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Doodle"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "close", style: .plain, target: self,
                 action: #selector(closeButtonPushed))
        self.collectionView.backgroundColor = .darkGray
        
    }
    
    @objc func closeButtonPushed() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DoodleViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 50)
    }
}
