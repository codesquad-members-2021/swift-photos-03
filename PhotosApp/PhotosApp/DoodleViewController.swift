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
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Doodle"

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "close", style: .plain, target: self, action: #selector(closeButtonPushed))
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
        
        let longPressRecognizer = UITapGestureRecognizer(target: self, action: #selector(longPressedCell(gesture:)))
        longPressRecognizer.cancelsTouchesInView = false
        cell.imageView.tag = indexPath.row // add this
        longPressRecognizer.numberOfTapsRequired = 1 // add this
        longPressRecognizer.delegate = self
        cell.imageView.isUserInteractionEnabled = true  // add this
        cell.imageView.addGestureRecognizer(longPressRecognizer)
        
        return cell
    }
    
    @objc func longPressedCell(gesture: UITapGestureRecognizer) {
        let indexPath = NSIndexPath(row: gesture.view!.tag, section: 0)
        let cell = collectionView.cellForItem(at: indexPath as IndexPath)! as! CustomCell
        cell.becomeFirstResponder()
        PhotoManager.shared.doodleClipBoardImage = cell.imageView.image!
        
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
