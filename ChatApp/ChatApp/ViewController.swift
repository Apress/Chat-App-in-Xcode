//
//  ViewController.swift
//  ChatApp
//
//  Created by Tihomir RAdeff on 11.03.24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let name = UserDefaults.standard.object(forKey: "name") as? String
        if name != nil {
            performSegue(withIdentifier: "OpenChat", sender: self)
        }
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        if nameField.text?.count ?? 0 > 0 {
            UserDefaults.standard.set(nameField.text, forKey: "name")
            performSegue(withIdentifier: "OpenChat", sender: self)
        }
    }
    
}

