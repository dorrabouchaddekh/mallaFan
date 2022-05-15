//
//  FilterViewController.swift
//  Malla Fann
//
//  Created by dorra on 12/4/2022.
//

import UIKit



class FilterViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    
    //IBOutlets
    @IBOutlet weak var filterCollectionViewCell: UICollectionView!
    
    @IBAction func filterButton(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor == UIColor.yellowed ? UIColor.white : UIColor.yellowed
    }
    
    //var
    var categories = ["painterIcon","literateIcon","musiqueIcon","photographIcon","plasticartIcon","dancerIcon"]
    var catgNames = ["Painting","Literature","Musique","Photography","Plastic Art","Dancing"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filterCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "filterCell",
            for: indexPath)
        let filter = filterCell.contentView
        let imageview22 = filter.viewWithTag(22) as! UIImageView
        
        let categname = filter.viewWithTag(23) as! UILabel
        
        imageview22.image =  UIImage(named: categories[indexPath.row])
        
        categname.text = catgNames[indexPath.row]
        
        return filterCell
        
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



}
