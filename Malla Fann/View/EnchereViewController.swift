//
//  EnchereViewController.swift
//  Malla Fann
//
//  Created by dorra on 12/4/2022.
//

import UIKit
import CoreData
extension UIColor{
    public static let redd = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
}

class EnchereViewController: UIViewController {
    
    //var
    var publication: Publicationn?
    var _id: String?
    
    //iboutlets
    
    
    @IBOutlet weak var lovedIt: UIButton!
    
    @IBOutlet weak var artImageView: UIImageView!
    
    @IBOutlet weak var artNameLabel: UILabel!
    
    //var
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializePage()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "commentairesSegue" {
//            let destination = segue.destination as! CommentairesView
//            destination.publication = currentPublication
//        }
//    }
//    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
    }
    
    // METHODS
    func initializePage() {
        PublicationViewModel().recupererPublicationParId(_id: _id!) { [self] success, result in
            self.publication = result
         
            artNameLabel.text = result?.description
          
            self.artImageView.loadFrom(URLAddress: Constant.host+(result?.pictureId)!)
            if((result?.pictureId?.contains("https")) != nil) {
                                self.artImageView.loadFrom(URLAddress: result?.pictureId ?? "")
                            }
  
            }
        
    }
    
//    @IBAction func sendComments(_ sender: Any) {
//        performSegue(withIdentifier: "commentairesSegue", sender: currentPublication)
//    }
//

//    @IBAction func lovedIt(_ sender: UIButton) {
//        sender.backgroundImage(for: <#T##UIControl.State#>) = sender.backgroundColor == UIColor.redd ? UIColor.white : UIColor.redd
//    }
}
