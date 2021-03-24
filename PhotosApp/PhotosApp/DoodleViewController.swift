//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by 이다훈 on 2021/03/24.
//

import UIKit
import Photos

class DoodleViewController: UICollectionViewController {
    var doodles = [Doodle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Doodle"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "close", style: .plain, target: self,
                 action: #selector(closeButtonPushed))
        self.collectionView.backgroundColor = .darkGray
        
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

extension DoodleViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? CustomCell
        else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = getRandomColor()
        
        return cell
    }
    
    func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}

extension DoodleViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 50)
    }
}
