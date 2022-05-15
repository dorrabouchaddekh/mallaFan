//
//  MdpOublieViewController.swift
//  Malla Fann
//
//  Created by dorra on 11/5/2022.
//

import UIKit

class MdpOublieViewController: UIViewController {

    
    // VAR
    struct MotDePasseOublieData {
        var email: String?
        var code: String?
    }
    
    var data : MotDePasseOublieData?
    let spinner = SpinnerViewController()
    
    // WIDGET
    @IBOutlet weak var emailTextField: UITextField!
    
    
    // PROTOCOLS
    
    
     //LIFECYCLE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ConfirmationViewController
        destination.data = data
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
    @IBAction func suivant(_ sender: Any) {
        
        if (emailTextField.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your email"), animated: true)
            return
        }
        
        startSpinner()
        
        data = MotDePasseOublieData(email: emailTextField.text, code: String(Int.random(in: 10000..<90000)))
        
        UserViewModel().motDePasseOublie(email: (data?.email)!, codeDeReinit: (data?.code)! ) { success in
            self.stopSpinner()
            if success {
                self.performSegue(withIdentifier: "confirmationSegue", sender: self.data)
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Email does not exist"), animated: true)
            }
        }
    }
    

}
