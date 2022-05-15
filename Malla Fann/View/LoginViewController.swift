//
//  LoginViewController.swift
//  Malla Fann
//
//  Created by dorra on 20/4/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    var userViewModel = UserViewModel()
    var email: String?
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        PasswordTextField.isSecureTextEntry = true
        PasswordTextField.text = "1"
        EmailTextField.text = "youssef@jmeaa"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        userViewModel.connexion(email: EmailTextField.text!, password: PasswordTextField.text!,completed: { (success, reponse) in
                    
                    if success {
                        let user = reponse as! User
                        
                        print (user)
                        self.performSegue(withIdentifier: "connectSegue", sender: nil)
 
                    } else {
                     
                    }
                })
    }
    


}
