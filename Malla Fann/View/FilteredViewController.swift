//
//  FilteredViewController.swift
//  Malla Fann
//
//  Created by dorra on 12/4/2022.
//

import UIKit

class FilteredViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var filtersCell: UICollectionView!
    
    @IBOutlet weak var filteredCollectionView: UICollectionView!
    
    
    //var
    var categories = ["painterIcon","literateIcon","musiqueIcon","photographIcon","plasticartIcon","dancerIcon","painterIcon","literateIcon","musiqueIcon"]
    var ncreations = ["img1","img2","img3","img4","img5","img6","img7","img8","img9"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filtersCell {
            return categories.count
            
        }else {
            return ncreations.count
            
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == filtersCell) {
        let fCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "fCell",
            for: indexPath)
        let new = fCell.contentView
        let imageview26 = new.viewWithTag(26) as! UIImageView

        
        imageview26.image =  UIImage(named: categories[indexPath.row])


        
        
            return fCell
            
        } else{
          let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "filteredCell", for: indexPath)
            let filterd = cells.contentView
            let imageview24 = filterd.viewWithTag(24) as! UIImageView
            let imageview25 = filterd.viewWithTag(25) as! UIImageView
            
            imageview24.image =  UIImage(named: ncreations[indexPath.row])
            imageview25.image =  UIImage(named: ncreations[indexPath.row])


            
            
                return cells
            
            
            
        }
            
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
