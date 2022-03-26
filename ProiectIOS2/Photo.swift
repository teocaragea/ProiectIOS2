//
//  Photo.swift
//  ProiectIOS2
//
//  Created by Caragea, Theodor on 22.03.2022.
//

import UIKit

struct Photo{
    let title: String?
    let image: UIImage?
    init(title:String?, image: UIImage?){
        self.title = title;
        self.image = image;

    }
}
let photos: [Photo] = [
    Photo(title: "Pasta", image: #imageLiteral(resourceName: "paste")),
    Photo(title: "Pizza", image: #imageLiteral(resourceName: "pizza")),
    Photo(title: "Chicken Fingers", image: #imageLiteral(resourceName: "chicken")),
    Photo(title: "Beef", image: #imageLiteral(resourceName: "vita")),
    Photo(title: "Soup", image: #imageLiteral(resourceName: "supa")),
    Photo(title: "Cheesecake", image: #imageLiteral(resourceName: "prajitura"))
]
