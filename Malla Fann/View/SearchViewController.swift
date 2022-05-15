//
//  SearchViewController.swift
//  Malla Fann
//
//  Created by dorra on 12/4/2022.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate, UISearchBarDelegate{

    var publications : [Publication] = []
    //IBoutlets
    @IBOutlet weak var searchCollectionView: UICollectionView!
    

    @IBOutlet weak var pubsCollectionView: UICollectionView!
    //var
    var ncreations = ["img1","img2","img3","img4","img5","img6","img7","img8","img9"]
    var categories = ["painterIcon","literateIcon","musiqueIcon","photographIcon","plasticartIcon","dancerIcon","painterIcon","literateIcon","musiqueIcon"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ncreations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let searchC = collectionView.dequeueReusableCell(
            withReuseIdentifier: "searchCell",
            for: indexPath)
        let new = searchC.contentView
        let imageview20 = new.viewWithTag(20) as! UIImageView
        let imageview21 = new.viewWithTag(21) as! UIImageView
      
        
        
        imageview20.image =  UIImage(named: ncreations[indexPath.row])
        imageview21.image =  UIImage(named: categories[indexPath.row])
               
        
        
            return searchC
    }
    
    
    
    
    

    

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.publications.removeAll()
        self.searchCollectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText=="") {
            self.publications.removeAll()
            self.searchCollectionView.reloadData()
        }
        print(searchText)
        searchFunction(text: searchText)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }

    func searchFunction(text: String){
        PubsViewModel().SearchPubs(text : text, completed: {
            (success,response) in
            self.publications.removeAll()
            if success {
                
                for singlePub in response! {
                    self.publications.append(singlePub)
                    print(singlePub.title!)
                    
                }
                self.searchCollectionView.reloadData()
                
                print("oh!")
            } else {
               // self.present(Alert.makeAlert(titre: "Error", message: "something wrong"), animated: true)
            }
            
        })
    }
    

}
