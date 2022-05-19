//
//  ContactsViewController.swift
//  Malla Fann
//
//  Created by dorra on 13/4/2022.
//

import UIKit
import SwiftUI

class ContactsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    
    
    //var
    var link = Link()
    var links : [Link] = []

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var linksTableView: UITableView!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toWebView", sender: links[indexPath.row].url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toWebView" {
            let destination = segue.destination as! WebViewController
            destination.url = sender as? String
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
            return links.count


    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == linksTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "linksCell", for: indexPath)
            let contentView = cell.contentView
            
            let linkTitle = contentView.viewWithTag(1) as! UILabel
         //   let linkUrl = contentView.viewWithTag(2) as! UITextField
            
           // imagePublication.layer.cornerRadius = ROUNDED_RADIUS
            linkTitle.text = links[indexPath.row].title
           // urlTextField.text = links[indexPath.row].url
            
            return cell
        }
        return UITableViewCell()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHistory()
        
    }
    
    func makeAlert(titre: String?, message: String?) {
        let alert = UIAlertController(title: titre, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        if (titleTextField.text == "") {
            makeAlert(titre: "Warning", message: "Please type your firstname")
            return
        }
        if (urlTextField.text == "") {
            makeAlert(titre: "Warning", message: "Please type your firstname")
            return
        }
        
        let link = Link( title: titleTextField.text, url: urlTextField.text)
        
        LinkViewModel().addLink(title: titleTextField.text!, _id: UserDefaults.standard.string(forKey: "_id")!, url: urlTextField.text! , completed: { [self] (success,response) in
    
                    self.present(Alert.makeAlert(titre: "Error", message: "Account may already exist."), animated: true)
        
        })

    }
    
    override func viewDidAppear(_ animated: Bool) {

        initializeHistory()
    }
    
    // METHODS
    func initializeHistory() {
        print("dadouuuuuuuuu--------------------------")
        print(UserDefaults.standard.string(forKey: "_id")!)
        LinkViewModel.sharedInstance.getLinksByUserId(_id: UserDefaults.standard.string(forKey: "_id")!, completed:{success, publicationsfromRep in
            if success {
                self.links = publicationsfromRep!
                self.linksTableView.reloadData()

            }else {
             //   self.present(Alert.makeAlert(titre: "Error", message: "Could not load publications "),animated: true)
            }
        })}
    

}
