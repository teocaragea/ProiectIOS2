//
//  PhotoCollectionViewCell.swift
//  ProiectIOS2
//
//  Created by Caragea, Theodor on 22.03.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func setup(with photo: Photo){
        image.image = photo.image
        title.text = photo.title
        title.font = UIFont.boldSystemFont(ofSize: 19.0)
    }
}
