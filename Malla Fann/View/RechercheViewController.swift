//
//  RechercheViewController.swift
//  Malla Fann
//
//  Created by dorra on 11/5/2022.
//

import UIKit

class RechercheViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource,UISearchBarDelegate {
    
    
    // VARS
    let searchController = UISearchController()
    
    var utilisateursAux : [User] = []
    var publicationsAux : [Publicationn] = []

    
    var publications : [Publicationn] = []
    var utilisateurs : [User] = []
   
    
    var selectedPublication : Publicationn?
    var selectedUtilisateur : User?

    
    // WIDGETS
    @IBOutlet weak var cvPosts: UICollectionView!
    @IBOutlet weak var cvPeople: UICollectionView!
    @IBOutlet weak var cvMusique: UICollectionView!
    
    // PROTOCOLS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == cvPosts) {
            return publications.count
        } else if (collectionView == cvPeople) {
            return utilisateurs.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == cvPeople {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "peopleCell", for: indexPath)
            let contentView = cell.contentView
            
            let imageUtilisateur = contentView.viewWithTag(1) as! UIImageView
            let labelname = contentView.viewWithTag(2) as! UILabel
            
//            imageUtilisateur.layer.cornerRadius = ROUNDED_RADIUS
            labelname.text = utilisateurs[indexPath.row].firstname
            
            ImageLoader.shared.loadImage(
                identifier: utilisateurs[indexPath.row].pictureId!,
                url: Constant.host + utilisateurs[indexPath.row].pictureId!,
                completion: { [] image in
                    imageUtilisateur.image = image
                })
            
            return cell
        } else if collectionView == cvPosts {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postsCell", for: indexPath)
            let contentView = cell.contentView
            
            let imagePublication = contentView.viewWithTag(1) as! UIImageView
            let labeldescription = contentView.viewWithTag(2) as! UILabel
            
           // imagePublication.layer.cornerRadius = ROUNDED_RADIUS
            labeldescription.text = publications[indexPath.row].description
            
            ImageLoader.shared.loadImage(
                identifier: publications[indexPath.row].pictureId!,
                url: Constant.host + publications[indexPath.row].pictureId!,
                completion: { [] image in
                    imagePublication.image = image
                })
            
            return cell
        }
        return UICollectionViewCell()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "musicPlayerSegue" {
//            let destination = segue.destination as! MusiqueView
//            destination.currentMusic = selectedMusic
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cvPosts {
            selectedPublication = publications[indexPath.row]
            self.performSegue(withIdentifier: "displayPublicationSegue", sender: selectedPublication)
        } else if collectionView == cvPeople {
            selectedUtilisateur = utilisateurs[indexPath.row]
            let viewController: ProfileViewController = self.storyboard!.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
            viewController.profileOfSomeoneElse = selectedUtilisateur
            self.present(viewController, animated: true)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        publicationsAux = publications
        utilisateursAux = utilisateurs

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        utilisateurs = []
        publications = []

        
        for publication in publicationsAux {
            if publication.description!.lowercased().starts(with: searchText.lowercased()) {
                
                publications.append(publication)
            }
        }
        
        for user in utilisateursAux {
            if user.firstname!.lowercased().starts(with: searchText.lowercased()) {
                utilisateurs.append(user)
            }
        }
        

        
        cvPosts.reloadData()
        cvPeople.reloadData()
        
        
        if searchText == "" {
            publications = publicationsAux
            utilisateurs = utilisateursAux
            
        }
    }
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initializeHistory()
    }
    
    // METHODS
    func initializeHistory() {
        PublicationViewModel.sharedInstance.recupererToutPublication{success, publicationsfromRep in
            if success {
                self.publications = publicationsfromRep!
                self.cvPosts.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load publications "),animated: true)
            }
        }
        
        UserViewModel.sharedInstance.recupererToutUtilisateur {success, utilisateursFromRep in
            if success {
                self.utilisateurs = utilisateursFromRep!
                self.cvPeople.reloadData()
            } else {
             //   self.present(Alert.makeAlert(titre: "Error", message: "Could not load users "),animated: true)
            }
        }
        

    }
    
    // ACTIONS
    
}
