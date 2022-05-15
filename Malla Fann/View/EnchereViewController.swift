//
//  EnchereViewController.swift
//  Malla Fann
//
//  Created by dorra on 12/4/2022.
//

import UIKit
import CoreData

class EnchereViewController: UIViewController {
    
    //var
    var publication: Publicationn?
    
    
    //iboutlets
    
    
    @IBOutlet weak var artImageView: UIImageView!
    
    @IBOutlet weak var artNameLabel: UILabel!
    
    //var
    var artName:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
      //  artImageView.loadFrom(URLAddress: Constant.host+publication?.pictureId)
        
       artImageView.image = UIImage(named: artName!)
        artNameLabel.text = artName!

        // Do any additional setup after loading the view.
    }
    



}
