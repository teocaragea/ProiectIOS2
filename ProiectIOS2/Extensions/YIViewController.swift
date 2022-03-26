//
//  YIViewController.swift
//  ProiectIOS2
//
//  Created by Caragea, Theodor on 19.03.2022.
//

import Foundation
import UIKit

extension UIViewController{
    func showError( title:String?, mesage: String){
        let alertController = UIAlertController(title: title, message: mesage, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
        
    }
}
