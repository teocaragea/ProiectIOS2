//
//  AddViewcontrollerViewController.swift
//  ProiectIOS2
//
//  Created by Caragea, Theodor on 19.03.2022.
//

import UIKit
import FirebaseDatabase

class AddViewcontrollerViewController: UIViewController {
    
    var refContacts: DatabaseReference!

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    
    @IBOutlet weak var succes: UILabel!
    @IBAction func btnAdd(_ sender: Any) {
        addContact()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add a product"
        succes.text = ""
        
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = UIColor.systemBlue.cgColor
        animation.toValue = UIColor.white.cgColor
        animation.duration = 1
        view.layer.add(animation, forKey: "backgroundColor")
        
        refContacts = Database.database().reference().child("contacts")
        
        
        
    }
    
    func addContact(){
        let key = refContacts.childByAutoId().key
        let contact = ["id":key,
                      "Name": textFieldName.text! as String,
                      "Phone": textFieldPhone.text! as String]
        refContacts.child(key! ?? "test").setValue(contact)
        succes.text="Product successfully added!"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
