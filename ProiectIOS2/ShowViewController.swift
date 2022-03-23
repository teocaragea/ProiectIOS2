//
//  ShowViewController.swift
//  ProiectIOS2
//
//  Created by Caragea, Theodor on 19.03.2022.
//

import UIKit
import FirebaseDatabase
import Firebase
import Foundation

class ShowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableContact2: UITableView!
    //@IBOutlet weak var tableContact2: UITableView!
   // @IBOutlet weak var tableContact: UITableView!
    var refContacts: DatabaseReference!
    var contactsList = [Contact]()
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contact = contactsList[indexPath.row]
        let alertController = UIAlertController(title: contact.name, message:"Give a new values to update product", preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "Update", style: .default){(_) in
            
            let id = contact.id
            let name = alertController.textFields?[0].text
            let phone = alertController.textFields?[1].text
            self.updateContact(id: id!, name: name!, phone: phone!)
    
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default){(_) in
            self.deleteContact(id: contact.id!)
        }
        
        alertController.addTextField{(textField) in
                                     textField.text = contact.name
            
        }
        
        alertController.addTextField{(textField) in
            textField.text = contact.phone
            
        }
        
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
        
        
        
        
    }
    public func deleteContact(id: String){
        refContacts.child(id).setValue(nil)
    }
    
    public func updateContact(id: String, name: String, phone: String){
        let contact = [
            "id": id,
            "Name": name,
            "Phone": phone]
        
        refContacts.child(id).setValue(contact)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let contact: Contact
        
        contact = contactsList[indexPath.row]
        cell.lblName.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        cell.lblName.text = "Name: " + contact.name!
        cell.lblPhone.text = "Price: " + contact.phone! + " lei"
        
        return cell
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsList.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "View products"
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.y"
        animation.values = [0, 260, 0]
        animation.keyTimes = [0, 0.5, 1]
        animation.duration = 1.7
        animation.isAdditive = true

        view.layer.add(animation, forKey: "move")
        
        refContacts = Database.database().reference().child("contacts")
        refContacts.observe(.value, with: { snapshot in
            if snapshot.childrenCount>0{
                self.contactsList.removeAll()
                for contacts in  snapshot.children.allObjects as![DataSnapshot]{
                    let contactObject = contacts.value as? [String: AnyObject]
                    let name = contactObject?["Name"]
                    let phone = contactObject?["Phone"]
                    let id = contactObject?["id"]
                    
                    let contact = Contact(id: id as! String?, name: name as! String?, phone: phone as! String?)
                    self.contactsList.append(contact)
                    
                    
                }
                self.tableContact2.reloadData()
            }
            
        })
        
        
        
        
    }


}
