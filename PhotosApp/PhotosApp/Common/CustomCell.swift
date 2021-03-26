//
//  CustomCell.swift
//  PhotosApp
//
//  Created by 이다훈 on 2021/03/23.
//

import UIKit

class CustomCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func showMenu() {
        self.becomeFirstResponder()
        let saveMenuItem = UIMenuItem(title: "Save💾", action: #selector(save))
        UIMenuController.shared.menuItems = [saveMenuItem]
        UIMenuController.shared.arrowDirection = .default
        UIMenuController.shared.showMenu(from: self, rect: self.bounds)
    }
    
    @objc func save() {
        PhotoManager.shared.saveImageToAlbum(with :self.imageView.image!)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(save)
    }
}
