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
        self.tabBarItem = UITabBarItem(title: "close", image: nil, tag: 0)
    }
}
