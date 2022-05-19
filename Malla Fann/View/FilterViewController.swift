//
//  FilterViewController.swift
//  Malla Fann
//
//  Created by dorra on 12/4/2022.
//

import UIKit



class FilterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UISearchBarDelegate {
    
    let searchController = UISearchController()
    
    var events : [Event] = []
    var eventsAux : [Event] = []
    var event : Event?
    
    @IBOutlet weak var cvPosts: UICollectionView!
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == cvPosts) {
            return events.count
        }
        return 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableCell" {
            let destination = segue.destination as! LocationCellViewController
            
            destination.event = self.event!
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.event = events[indexPath.row]
        self.performSegue(withIdentifier: "tableCell", sender: event)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cvPosts {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postsCell", for: indexPath)
            let contentView = cell.contentView
            
            let imagePublication = contentView.viewWithTag(1) as! UIImageView
            let labeldescription = contentView.viewWithTag(2) as! UILabel
            
           // imagePublication.layer.cornerRadius = ROUNDED_RADIUS
            labeldescription.text = events[indexPath.row].name
            
            ImageLoader.shared.loadImage(
                identifier: events[indexPath.row].pictureId!,
                url: Constant.host + events[indexPath.row].pictureId!,
                completion: { [] image in
                    imagePublication.image = image
                })
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    

    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        eventsAux = events
       

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        events = []

        
        for event in eventsAux {
            if event.name!.lowercased().starts(with: searchText.lowercased()) {
                
                events.append(event)
            }
        }
        


        
        cvPosts.reloadData()
      
        
        if searchText == "" {
            events = eventsAux
          
            
        }
    }
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHistory()
        self.cvPosts.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initializeHistory()
    }

    
    func initializeHistory() {
        EventViewModel.sharedInstance.recupererToutEvent{success, publicationsfromRep in
            if success {
                self.events = publicationsfromRep!
                self.cvPosts.reloadData()
            }else {
            //    self.present(Alert.makeAlert(titre: "Error", message: "Could not load publications "),animated: true)
            }
        }
        

        

    }
    
    
    
    
    
    
    
    
    
    
    //IBOutlets
//    @IBOutlet weak var filterCollectionViewCell: UICollectionView!
//
//    @IBAction func filterButton(_ sender: UIButton) {
//        sender.backgroundColor = sender.backgroundColor == UIColor.yellowed ? UIColor.white : UIColor.yellowed
//    }
//
//    //var
//    var categories = ["painterIcon","literateIcon","musiqueIcon","photographIcon","plasticartIcon","dancerIcon"]
//    var catgNames = ["Painting","Literature","Musique","Photography","Plastic Art","Dancing"]
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return categories.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let filterCell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: "filterCell",
//            for: indexPath)
//        let filter = filterCell.contentView
//        let imageview22 = filter.viewWithTag(22) as! UIImageView
//
//        let categname = filter.viewWithTag(23) as! UILabel
//
//        imageview22.image =  UIImage(named: categories[indexPath.row])
//
//        categname.text = catgNames[indexPath.row]
//
//        return filterCell
//
//    }
    
    
    




}
