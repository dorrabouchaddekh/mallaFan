//
//  ViewController.swift
//  Malla Fann
//
//  Created by dorra on 7/4/2022.
//

import UIKit

extension UIColor{
    public static let yellowed = UIColor(red: 255/255, green: 209/255, blue: 80/255, alpha: 1.0)
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    

    
    @IBAction func todoBtn(_ sender: UIButton) {

        sender.backgroundColor = sender.backgroundColor == UIColor.yellowed ? UIColor.white : UIColor.yellowed
    }
    
    @IBAction func toseeVtn(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor == UIColor.yellowed ? UIColor.white : UIColor.yellowed
    }
    
    @IBOutlet weak var cvToDo: UICollectionView!
    
    @IBOutlet weak var cvToSee: UICollectionView!
    
    
    
    
    var categories = ["painterIcon","literateIcon","musiqueIcon","photographIcon","plasticartIcon","dancerIcon"]
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cvToDo {
            return categories.count
            
        }else {
            return categories.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == cvToDo) {
            let cell1 = collectionView.dequeueReusableCell(
                withReuseIdentifier: "todoCell",
                for: indexPath)
            let todo = cell1.contentView
            let imageview1 = todo.viewWithTag(1) as! UIImageView
            
            
            imageview1.image =  UIImage(named: categories[indexPath.row])
            
            return cell1
            
        }
        else {
            let cell2 = collectionView.dequeueReusableCell(
                withReuseIdentifier: "toseeCell",
                for: indexPath)
            let tosee = cell2.contentView
            let imageview2 = tosee.viewWithTag(2) as! UIImageView
            
            
            imageview2.image =  UIImage(named: categories[indexPath.row])
            
            
            return cell2
            
        }
        
    }
    
    
    

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
    }


    
    
}

