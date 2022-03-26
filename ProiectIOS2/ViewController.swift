//
//  ViewController.swift
//  ProiectIOS2
//
//  Created by Caragea, Theodor on 16.03.2022.
//

import UIKit
import UserNotifications
import Firebase
import FBSDKLoginKit
import SQLite
import FirebaseAuth

class ViewController: UIViewController, LoginButtonDelegate {
    
   
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var location: UIButton!
    @IBOutlet weak var showProducts: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnShow: UIButton!
    @IBOutlet weak var btnRecipe: UIButton!
    private let btnWeb: UIButton = {
       let btn = UIButton()
        btn.setTitle("See our web page.", for: .normal)
        btn.backgroundColor = .gray
        btn.setTitleColor( .white, for: .normal)
        return btn
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Log in"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
        
    }()
    
    private let emailField: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = "Email Address"
        emailField.layer.borderColor = UIColor.black.cgColor
        emailField.autocapitalizationType = .none
        emailField.backgroundColor = .white
        emailField.leftViewMode = .always
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        return emailField
        
    }()
    
    private let passField: UITextField = {

        
        let passField = UITextField()
        passField.placeholder = "Pasword"
        passField.layer.borderWidth = 1
        passField.isSecureTextEntry = true
        passField.layer.borderColor = UIColor.black.cgColor
        passField.backgroundColor = .white
        passField.leftViewMode = .always
        passField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        return passField
        
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemCyan
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log in", for: .normal)
        return button
        
    }()

    private let signOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemCyan
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log Out", for: .normal)
        return button
        
    }()
    
    private let loginButton : FBLoginButton={
    let loginButton = FBLoginButton()
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.borderWidth = 0.7
    //loginButton.delegate = self
    // Extend the code sample from 6a. Add Facebook Login to Your Code
    // Add to your viewDidLoad method:
    loginButton.permissions = ["public_profile", "email"]
    return loginButton
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.center = view.center
        
        btnWeb.addTarget(self, action: #selector(didTapBtnWeb), for: .touchUpInside)
        btnWeb.frame = CGRect(x:0, y:0 ,width: 220, height: 50)
        btnWeb.center = view.center
        
        
        //check if user is signed in
        if let token = AccessToken.current,
                !token.isExpired {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token, version: nil, httpMethod: .get)
            request.start(completion: { connection, result, error in
                print("\(String(describing: result))")
                
            })
                // User is logged in, do work such as go to next view controller.
        }
        
        ///ask for permission
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound])
        { (granted, error) in
        }
        
        ///create the notitification content
        let content = UNMutableNotificationContent()
        content.title = "Notification from your fav app"
        content.body = "Please come back"
        
        ///notification trigger
        let date = Date().addingTimeInterval(5)
        
        let dateComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        
        ///create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        /// Register the request
        center.add(request) { error in
            
        }
        
        
        view.addSubview(label)
        view.addSubview(emailField)
        view.addSubview(passField)
        view.addSubview(button)
        view.addSubview(signOutButton)
        view.addSubview(loginButton)
        view.addSubview(btnWeb)
        view.backgroundColor = .systemBlue
        
        button.addTarget(self, action: #selector(didTapButton) , for: .touchUpInside)
        
        if FirebaseAuth.Auth.auth().currentUser != nil{
            label.isHidden = true
            emailField.isHidden = true
            passField.isHidden = true
            button.isHidden = true
            btnWeb.isHidden = true
            self.btnRecipe.isHidden = false
            signOutButton.isHidden = false
            loginButton.isHidden = true
            self.btnAdd.isHidden = false
            self.btnShow.isHidden = false
            showProducts.isHidden = false
            location.isHidden = false
            img.isHidden = false
            
            
            
            view.addSubview(signOutButton)
            signOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        }else{
            self.btnAdd.isHidden = true
            self.btnShow.isHidden = true
            self.signOutButton.isHidden = true
            self.btnRecipe.isHidden = true
            self.showProducts.isHidden = true
            self.location.isHidden = true
            self.img.isHidden = true
        }
        
    }
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token, version: nil, httpMethod: .get)
        request.start(completion: { connection, result, error in
            print("\(String(describing: result))")
            
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    @objc private func logOutTapped(){
        do{
            try FirebaseAuth.Auth.auth().signOut()
            label.isHidden = false
            emailField.isHidden = false
            passField.isHidden = false
            button.isHidden = false
            btnWeb.isHidden = false
            loginButton.isHidden = false
            btnAdd.isHidden = true
            btnShow.isHidden = true
            btnRecipe.isHidden = true
            signOutButton.isHidden = true
            showProducts.isHidden = true
            location.isHidden = true
            img.isHidden = true
            
            //signOutButton.removeFromSuperview()
        }
        catch{
            printContent("An error occurred")
        }
        
    }
    
    @objc private func didTapBtnWeb(){
        guard let url = URL(string: "https://google.com") else {
            return
        }
        let vc = WebViewController(url: url, title: "Google")
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        label.frame = CGRect(x: 0 , y: 100, width: view.frame.size.width, height: 80)
        emailField.frame = CGRect(x: 20 ,
                                  y: label.frame.origin.y + label.frame.size.height + 10,
                                  width: view.frame.size.width - 40,
                                  height: 50)
        passField.frame = CGRect(x: 20 ,
                                 y: emailField.frame.origin.y + emailField.frame.size.height + 10,
                                 width: view.frame.size.width - 40,
                                 height: 50)
        button.frame = CGRect(x: 20 ,
                              y: passField.frame.origin.y + passField.frame.size.height + 30,
                              width: view.frame.size.width - 40,
                              height: 52)
        
        loginButton.frame = CGRect(x: 20 ,
                              y: button.frame.origin.y + button.frame.size.height + 50,
                              width: view.frame.size.width - 40,
                              height: 52)
        
        btnWeb.frame = CGRect(x:20,
                              y: loginButton.frame.origin.y + loginButton.frame.size.height + 100,
                              width: view.frame.size.width - 40,
                              height: 52)
        /*showProducts.frame = CGRect(x:20,
                                    y:btnShow.frame.origin.y + btnShow.frame.size.height + 30,
                                    width: view.frame.size.width - 40,
                                    height: 50)*/
        
        
        signOutButton.frame = CGRect(x: 20,
                                     y: view.frame.size.height - 90,
                                     width: view.frame.size.width-40,
                                     height: 52)
        
        
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if FirebaseAuth.Auth.auth().currentUser == nil{
            emailField.becomeFirstResponder()
        }
    }
    
    @objc private func didTapButton(){
        print("Buton apasat")
        guard let email = emailField.text, !email.isEmpty,
              let password = passField.text, !password.isEmpty else{
                  printContent("Missing field data")
                  return
              }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self]result, error in
            guard let strongSelf = self else{
                return
            }
            guard error == nil else{
                
                strongSelf.showCreateAccount(email: email, password: password)
                return
            }
                    
                    
        print("You have signed in")
            strongSelf.label.isHidden = true
            strongSelf.emailField.isHidden = true
            strongSelf.passField.isHidden = true
            strongSelf.button.isHidden = true
            strongSelf.btnWeb.isHidden = true
            strongSelf.loginButton.isHidden = true
            strongSelf.signOutButton.isHidden = false
            strongSelf.btnAdd.isHidden = false
            strongSelf.btnShow.isHidden = false
            strongSelf.btnRecipe.isHidden = false
            strongSelf.showProducts.isHidden = false
            strongSelf.location.isHidden = false
            strongSelf.img.isHidden = false
            strongSelf.emailField.resignFirstResponder()
            strongSelf.passField.resignFirstResponder()
        })
        
    
    }
    func showCreateAccount(email: String, password: String){
        let alert = UIAlertController(title: "Create Account",
                                      message: "Would you like to create an account",
                                      preferredStyle:  .alert)
        
        alert.addAction(UIAlertAction(title: "Continue",
                                      style:  .default,
                                      handler: {_ in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {[weak self]result, error in
                guard let strongSelf = self else{
                    return
                }
                guard error == nil else{
                    print("Account creation failed")
                    return
                }
                        
                        
            print("You have signed in")
                strongSelf.label.isHidden = true
                strongSelf.emailField.isHidden = true
                strongSelf.passField.isHidden = true
                strongSelf.button.isHidden = true
                strongSelf.loginButton.isHidden = true
                strongSelf.btnRecipe.isHidden = false
                strongSelf.showProducts.isHidden = false
                strongSelf.location.isHidden = false
                strongSelf.img.isHidden = false
                strongSelf.btnShow.isHidden = false
                strongSelf.btnWeb.isHidden = true
                strongSelf.btnAdd.isHidden = false
                strongSelf.signOutButton.isHidden = false
                
            })
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style:  .cancel,
                                      handler: {_ in
            
        }))
    present(alert, animated: true)
    }
    
    
    @IBAction func btnAdd(_ sender: Any) {
    
    }
    
    @IBAction func btnShow(_ sender: Any) {
    }
}

