//
//  PsuedoDoodleViewDataSource.swift
//  PhotosApp
//
//  Created by 이다훈 on 2021/03/25.
//

import UIKit

class DoodleViewControllerDataSource : NSObject, UICollectionViewDataSource, UIGestureRecognizerDelegate {
    var doodles : [Doodle]
    
    override init() {
        doodles = [Doodle]()
        super.init()
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? CustomCell
        else {
            return UICollectionViewCell()
        }
        
        DispatchQueue.global().async {
            let doodle = self.doodles[indexPath.row]
            let imageURL = doodle.image
            guard let url = URL(string: imageURL) else { return }
            var data = Data()
            do {
                data = try Data(contentsOf: url)
            } catch {
                return
            }
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data)
            }
        }
        
        setTouchRecognizer(To: cell, indexPathRow: indexPath.row)
        
        return cell
    }
    
    func setTouchRecognizer(To cell : CustomCell, indexPathRow : Int) {
        let longPressRecognizer = UITapGestureRecognizer(target: self, action: #selector(longPressedCell(gesture:)))
        longPressRecognizer.cancelsTouchesInView = false
        cell.imageView.tag = indexPathRow // add this
        longPressRecognizer.numberOfTapsRequired = 1 // add this
        longPressRecognizer.delegate = self
        cell.imageView.isUserInteractionEnabled = true  // add this
        cell.imageView.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longPressedCell(gesture: UITapGestureRecognizer) {
        guard let gestureView = gesture.view else { return }
        guard let cell = gestureView.superview?.superview! as? CustomCell else { return }
        cell.showMenu()
    }
}
