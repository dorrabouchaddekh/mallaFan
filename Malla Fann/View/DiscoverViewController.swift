//
//  DiscoverViewController.swift
//  Malla Fann
//
//  Created by dorra on 8/4/2022.
//

import UIKit



class DiscoverViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate ,PinterestLayoutDelegate{
    

    //var
    var publications: [Publicationn] = []
    var firstFive: [Publicationn] = []
    
    
    @IBOutlet weak var scoller: UIScrollView!
    @IBOutlet weak var newCollectionView: UICollectionView!
    
    @IBOutlet weak var cCollectionView: UICollectionView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    // @IBOutlet weak var newCollectionView: UICollectionView!
   // @IBOutlet weak var cCollectionView: UICollectionView!
    
   // @IBOutlet weak var cCollectionView: UICollectionView!
    var ncreations = ["img1","img2","img3","img4","img5","img6","img7","img8","img9"]
    var allcreations = ["img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9","img1","img10","img3","img11","img5","img6","img12","img8","img16","img2","img14","img7","img4","img9","img9","img9"]
    
    var categories = ["painterIcon","literateIcon","musiqueIcon","photographIcon","plasticartIcon","dancerIcon","painterIcon","literateIcon","musiqueIcon"]
    var artistnames = ["painterIcon","literateIcon","musiqueIcon","photographIcon","plasticartIcon","dancerIcon","painterIcon","literateIcon","musiqueIcon"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == newCollectionView {
            return firstFive.count
            
        }else {
//            return allcreations.count
            return publications.count
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == newCollectionView) {
        let newcell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "newcCell",
            for: indexPath)
        let new = newcell.contentView
        let imageview5 = new.viewWithTag(5) as! UIImageView
        let imageview6 = new.viewWithTag(6) as! UIImageView
        let imageview7 = new.viewWithTag(7) as! UIImageView
        
        let artists = new.viewWithTag(8) as! UILabel
        let arts = new.viewWithTag(9) as! UILabel
        
        imageview5.loadFrom(URLAddress: Constant.host+firstFive[indexPath.row].pictureId!)
        imageview6.image =  UIImage(named: categories[indexPath.row])
        imageview7.image =  UIImage(named: ncreations[indexPath.row])
        
        artists.text = artistnames[indexPath.row]
        arts.text = categories[indexPath.row]
        
        
        
            return newcell
            
        } else{
         if  let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as? CustomCollectionViewCell {
             //cells.cImageView.image = UIImage(named: "\(allcreations[indexPath.row] ).png")
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

        let image = UIImage(named: "\(allcreations[indexPath.row]).jpeg")
        if let height = image?.size.height {
            return height
        }
        return 0.0
    }
    
   
    
    

    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
        cCollectionView.showsVerticalScrollIndicator = false
        newCollectionView.showsHorizontalScrollIndicator = false
        
        
        initializeHistory()
        
        if let layout = cCollectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        
        
        
        scrollView.contentSize = CGSize(width : self.view.frame.width,height:  self.view.frame.height+100)
        
        //scoller.contentSize = CGSize(width: 414, height: 2000)
        
      //  cCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
    

        initializeHistory()
    }
    
    // METHODS
    func initializeHistory() {
        print("dadouuuuuuuuu--------------------------")
        print(UserDefaults.standard.string(forKey: "_id")!)
        PublicationViewModel.sharedInstance.recupererToutPublication(completed:{success, publicationsfromRep in
            if success {
                self.publications = publicationsfromRep!
                self.cCollectionView.reloadData()
           //    self.pdpCollectionViewCell.reloadData()
            }else {
             //   self.present(Alert.makeAlert(titre: "Error", message: "Could not load publications "),animated: true)
            }
        })
        
        PublicationViewModel.sharedInstance.recupererCinqPublication(completed:{success, publicationsfromRep in
            if success {
                self.firstFive = publicationsfromRep!
                self.newCollectionView.reloadData()
           //    self.pdpCollectionViewCell.reloadData()
            }else {
           //     self.present(Alert.makeAlert(titre: "Error", message: "Could not load publications "),animated: true)
            }
        })
        
        
        
        
    }

    
    
    
    
    
    
/*    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let scrollView = UIScrollView(frame: view.bounds)
        view.addSubview(scrollView)
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        
        
    }*/
    


}
