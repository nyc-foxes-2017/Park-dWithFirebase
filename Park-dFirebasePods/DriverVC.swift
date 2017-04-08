//
//  DriverVC.swift
//  Park-dFirebasePods
//
//  Created by Sophia Pignatelli on 4/8/17.
//  Copyright © 2017 Sophia Pignatelli. All rights reserved.
//

import UIKit

class DriverVC: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func checkIn(_ sender: Any) {
    }

    @IBAction func taken(_ sender: Any) {
    }
    

    @IBAction func logout(_ sender: Any) {
        if AuthProvider.Instance.logOut() {
            dismiss(animated: true, completion: nil)
        } else {
            alertTheUser(title: "Could not log out", message: "Logout unsuccessful. Please try again later.")
        }
    }
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil)
    }


} //class
