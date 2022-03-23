//
//  UIImageView.swift
//  ProiectIOS2
//
//  Created by Caragea, Theodor on 19.03.2022.
//

import Foundation
import UIKit

extension UIImageView{
    func makeRounded(){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}

