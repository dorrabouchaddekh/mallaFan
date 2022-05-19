//
//  ArtViewController.swift
//  Malla Fann
//
//  Created by dorra on 11/4/2022.
//

import UIKit

class ArtViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate ,PinterestLayoutDelegate{

    @IBOutlet weak var pCollectionView: UICollectionView!
    
    var allcreations = ["img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return allcreations.count
            
        
        
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if  let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "profilecustomCell", for: indexPath) as? CustomCollectionViewCell {
             cells.cImageView.image = UIImage(named: "\(allcreations[indexPath.row] ).png")
                cells.clipsToBounds = true
                cells.layer.cornerRadius = 15
             cells.cImageView.contentMode = .scaleAspectFill
                
                return cells
            }
            return UICollectionViewCell()
            
        
            
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = UIImage(named: "\(allcreations[indexPath.row] ).png")
        if let height = image?.size.height {
            return height
        }
        return 0.0
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pCollectionView.showsVerticalScrollIndicator = false
        
        if let layout = pCollectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }

        // Do any additional setup after loading the view.
    }
    

 
}
