//
//  PsuedoDoodleViewDataSource.swift
//  PhotosApp
//
//  Created by 이다훈 on 2021/03/25.
//

import UIKit

class DoodleViewControllerDataSource : NSObject, UICollectionViewDataSource, UIGestureRecognizerDelegate {
    private var doodles : [Doodle]
    private var doodlesImage: [UIImage?]
    
    override init() {
        doodles = [Doodle]()
        doodlesImage = [UIImage?]()
        super.init()
        loadDoodles()
    }
    
    private func loadDoodles() {
        guard let photosData = NSDataAsset(name: "doodle") else { return }
        do {
            self.doodles = try JSONDecoder().decode([Doodle].self, from: photosData.data)
        } catch {
            self.doodles = [Doodle]()
            return
        }
        doodlesImage = Array(repeating: nil, count: doodles.count)
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
            if self.doodlesImage[indexPath.row] == nil {
                let doodle = self.doodles[indexPath.row]
                let imageURL = doodle.image
                guard let url = URL(string: imageURL) else { return }
                let request = URLRequest(url: url)
                URLSession.shared.dataTask(with: request) { (data, _, error) in
                    guard error == nil else { print(error!); return }
                    guard let data = data else { print("안됑"); return }
                    let doodleImage = UIImage(data: data)
                    self.doodlesImage[indexPath.row] = doodleImage ?? UIImage()
                    DispatchQueue.main.async {
                        cell.imageView.image = doodleImage
                        self.setTouchRecognizer(To: cell, indexPathRow: indexPath.row)
                    }
                }.resume()
            } else {
                DispatchQueue.main.async {
                    cell.imageView.image = self.doodlesImage[indexPath.row]
                }
            }
        }
        return cell
    }
    
    func setTouchRecognizer(To cell : CustomCell, indexPathRow : Int) {
        let longPressRecognizer = UITapGestureRecognizer(target: self, action: #selector(longPressedCell(gesture:)))
        longPressRecognizer.cancelsTouchesInView = false
        longPressRecognizer.numberOfTapsRequired = 1
        longPressRecognizer.delegate = self
        cell.imageView.isUserInteractionEnabled = true
        cell.imageView.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longPressedCell(gesture: UITapGestureRecognizer) {
        guard let gestureView = gesture.view else { return }
        guard let cell = gestureView.superview?.superview! as? CustomCell else { return }
        cell.showMenu()
    }
}
