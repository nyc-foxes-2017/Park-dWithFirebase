//
//  SignInVC.swift
//  Park-dFirebasePods
//
//  Created by Sophia Pignatelli on 4/8/17.
//  Copyright © 2017 Sophia Pignatelli. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController {
    private let DRIVER_SEGUE = "DriverVC";

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            AuthProvider.Instance.login(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
                if message != nil {
                    self.alertTheUser(title: "Problem With Authentication", message: message!);
                } else {
                    print("Login Successfull")
                }
            });
                }
           }
    
    @IBAction func register(_ sender: Any) {
    }
   
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil)
    }


} //class


