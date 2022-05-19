//
//  LoginViewController.swift
//  Malla Fann
//
//  Created by dorra on 20/4/2022.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    let signInConfig = GIDConfiguration.init(clientID: "241172910262-k0ihh3di41lg1828hl1u110daltkgukd.apps.googleusercontent.com")
    
    var userViewModel = UserViewModel()
    var email: String?
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        PasswordTextField.isSecureTextEntry = true


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
    
    @IBAction func signIn(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else {return}
            print(user)
            self.RegisterWithGoogle(id: user.userID!)
            // If sign in succeeded, display the app's main content View.
          }
    }
    
    func RegisterWithGoogle(id: String ){
    
    GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
        guard error == nil else { return }
        guard let user = user else { return }

        let emailAddress = user.profile?.email

        let fullName = user.profile?.name
        let givenName = user.profile?.givenName
        let familyName = user.profile?.familyName

        let profilePicUrl = user.profile?.imageURL(withDimension: 320)
        
       let userX = User(firstname: givenName, lastname: familyName, email: emailAddress, pictureId: "\(profilePicUrl!)", isVerified: true)
        
        
        UserViewModel().GoogleSignIn(user: userX, completed: {
            (succes) in
            if succes {
                     
                     let alert = UIAlertController(title: "Success", message: "Login Succeded.", preferredStyle: .alert)
                     let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                         self.performSegue(withIdentifier: "connectSegue", sender: nil)
                     }
                     alert.addAction(action)
                     self.present(alert, animated: true)
                 } else {
                     self.present(Alert.makeAlert(titre: "Error", message: "Something went wrong."), animated: true)
                 }
        })
            
        
        
        print("minouuuuuuuuuuuuuuuuuuuuuuuuuuuuuu")
        print(emailAddress)
        print(fullName)
        print(givenName)
        print(familyName)
        print(profilePicUrl)
    }
    }

}
