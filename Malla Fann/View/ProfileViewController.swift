//
//  ProfileViewController.swift
//  Malla Fann
//
//  Created by dorra on 8/4/2022.
//

import UIKit

class ProfileViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate ,PinterestLayoutDelegate, ModalTransitionListener  {
    
    
    // VAR
    var profileOfSomeoneElse: User?
    var publications: [Publicationn] = []
    var utilisateurViewModel = UserViewModel()

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nomPrenomTF: UILabel!
    
    
    func popoverDismissed() {
        initializeProfileMy()
        
    }
    
    
    @IBOutlet weak var pdpCollectionViewCell: UICollectionView!
    
    @IBOutlet weak var pCollectionView: UICollectionView!
    
    
    
    var nbrPublications = ["125 piblications"]
    
    var allcreations = ["img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == pdpCollectionViewCell {
            return 1
            
        }else {
            return publications.count
            
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == pdpCollectionViewCell) {
        let newcell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "pdpCell",
            for: indexPath)
        let new = newcell.contentView
      //  let imageview1 = new.viewWithTag(10) as! UIImageView
      //  let name = new.viewWithTag(12) as! UILabel
      //  let arts = new.viewWithTag(13) as! UILabel
        
           // imageview1.image =  UIImage(named: nom[indexPath.row])

        
           // name.text = nom[indexPath.row]
    //    arts.text = nbrPublications[indexPath.row]
        
        
        
            return newcell
            
        } else{
         if  let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "profilecustomCell", for: indexPath) as? CustomCollectionViewCell {
             cells.cImageView.loadFrom(URLAddress: Constant.host+publications[indexPath.row].pictureId!)
                cells.clipsToBounds = true
                cells.layer.cornerRadius = 15
             cells.cImageView.contentMode = .scaleAspectFill
                
                return cells
            }
            return UICollectionViewCell()
            
        }
            
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        //let image = UIImage(named: "\(allcreations[indexPath.row] ).jpeg")
        let url = URL(string: Constant.host+publications[indexPath.row].pictureId!)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        let image = UIImage(data: data!)
            print("*******************")
        print(image!.size.height)
        
        if let height = image?.size.height {
           return height
     }
        return 0.0
    }
    
    
    //Delegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toEnchereSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toEnchereSegue" {
            let index = sender as! IndexPath
            let destination = segue.destination as! EnchereViewController
            destination.artName = allcreations[index.row]
        }
    }
    
    func initializeProfileMy(){
        UserViewModel().recupererUtilisateurParToken(_id: UserDefaults.standard.string(forKey: "_id")!) { [self] success, result in
            if success {
                //let user = result
                
                //darkThemeIcon.isHidden = false
               // darkThemeSwitch.isHidden = false
                
                
                
                nomPrenomTF.text = (result?.firstname)! + " " + (result?.lastname)!
                
                self.profileImage.loadFrom(URLAddress: Constant.host+(result?.pictureId)!)
//                ImageLoader.shared.loadImage(identifier: (user?.pictureId)!, url: "uploads/users" + (user?.pictureId)!) { imageResp in
//
//                    profileImage.image = imageResp
//                }
                
            } else {
                
            }
            
        }
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        ModalTransitionMediator.instance.setListener(listener: self)
        
//        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
//        profileImage.clipsToBounds = true
//        profileImage.layer.borderColor = UIColor.white.cgColor
//        profileImage.layer.borderWidth = 5.0
        
        initializeProfileMy()
        initializeHistory()

        
        
        self.navigationItem.hidesBackButton = true;
        pCollectionView.showsVerticalScrollIndicator = false
       // newCollectionView.showsVerticalScrollIndicator = false
        
        if let layout = pCollectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
/*
        imgProfil.layer.borderWidth = 1
        imgProfil.layer.masksToBounds = false
        imgProfil.layer.borderColor = UIColor.black.cgColor
        imgProfil.layer.cornerRadius = imgProfil.frame.height/2
        imgProfil.clipsToBounds = true */
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initializeProfileMy()

        initializeHistory()
    }
    
    // METHODS
    func initializeHistory() {
        print("dadouuuuuuuuu--------------------------")
        print(UserDefaults.standard.string(forKey: "_id")!)
        PublicationViewModel.sharedInstance.GetVideosByUser(_id: UserDefaults.standard.string(forKey: "_id")!, completed:{success, publicationsfromRep in
            if success {
                self.publications = publicationsfromRep!
                self.pCollectionView.reloadData()
               self.pdpCollectionViewCell.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load publications "),animated: true)
            }
        })}


}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
