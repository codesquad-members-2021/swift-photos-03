//
//  PsuedoDoodleViewDataSource.swift
//  PhotosApp
//
//  Created by 이다훈 on 2021/03/25.
//

import UIKit

extension DoodleViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
        let indexPath = NSIndexPath(row: gestureView.tag, section: 0)
        
        guard let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? CustomCell else { return }
        cell.becomeFirstResponder()
        
        guard let cellImage = cell.imageView.image else { return }
        PhotoManager.shared.doodleClipBoardImage = cellImage
        
        if let rectView = gesture.view {
            let saveMenuItem = UIMenuItem(title: "Save💾", action: #selector(save))
            UIMenuController.shared.menuItems = [saveMenuItem]
            UIMenuController.shared.arrowDirection = .default
            UIMenuController.shared.showMenu(from: rectView, rect: rectView.frame)
        }
    }
    
    @objc func save() {
        let image = PhotoManager.shared.doodleClipBoardImage
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
