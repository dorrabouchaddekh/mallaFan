//
//  ChangerMdpViewController.swift
//  Malla Fann
//
//  Created by dorra on 11/5/2022.
//

import UIKit

class ChangerMdpViewController: UIViewController {

    // VAR
    var email: String?
    let spinner = SpinnerViewController()
    
    // WIDGET
    @IBOutlet weak var motDePasseTextField: UITextField!
    @IBOutlet weak var confirmationMotDePasseTextField: UITextField!
    
    
    // PROTOCOLS
    
    
    // LIFECYCLE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! LoginViewController
        destination.email = self.email
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // METHODS
    func startSpinner() {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
    
    func stopSpinner() {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
    
    
    // ACTIONS
    @IBAction func Terminer(_ sender: Any) {
        
        if (motDePasseTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your new password"), animated: true)
            return
        }
        
        if (confirmationMotDePasseTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type the confirmation of your new password"), animated: true)
            return
        }
        
        if (motDePasseTextField.text != confirmationMotDePasseTextField.text) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Passwords should match"), animated: true)
            return
        }
        
        startSpinner()
        
        UserViewModel().changerMotDePasse(email: email!, nouveauMotDePasse: confirmationMotDePasseTextField.text! , completed: { success in
            self.stopSpinner()
            if success {
                let action = UIAlertAction(title: "Retour", style: .default) { UIAlertAction in
                    self.performSegue(withIdentifier: "revenirConnexionSegue", sender: nil)
                }
                self.present(Alert.makeSingleActionAlert(titre: "Success", message: "Your password has been changed", action: action), animated: true)
            }else{
              //  self.present(Alert.makeAlert(titre: "Error", message: "Could not change your password"), animated: true)
            }
        })
    }

}
