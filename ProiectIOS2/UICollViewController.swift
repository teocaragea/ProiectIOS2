//
//  UICollViewController.swift
//  ProiectIOS2
//
//  Created by Caragea, Theodor on 22.03.2022.
//

import UIKit

class UICollViewController: UIViewController {
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "See photos with our food"
        
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = UIColor.systemBlue.cgColor
        animation.toValue = UIColor.white.cgColor
        animation.duration = 1
        view.layer.add(animation, forKey: "backgroundColor")
        
        collectionView.dataSource = self
      
    }
    

}
extension UICollViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        cell.setup(with: photos[indexPath.row])
        return cell
    }
}
