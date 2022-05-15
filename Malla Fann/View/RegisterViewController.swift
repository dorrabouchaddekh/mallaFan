//
//  RegisterViewController.swift
//  Malla Fann
//
//  Created by dorra on 20/4/2022.
//
//
import UIKit

class RegisterViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    var pseudo: String?
    var motDePasse: String?
    var currentUser: Bool?
    var utilisateurViewModel = UserViewModel()
    var user = User()
    var utilisateur : User?
    var currentPhoto : UIImage?
    
    
        @IBOutlet weak var nom: UITextField!
    
        @IBOutlet weak var prenom: UITextField!
    
        @IBOutlet weak var email: UITextField!
    
        @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var profileImage: UIImageView!
    

        @IBOutlet weak var addPictureBtn: UIButton!
    
    func goToLogin(email: String?) {
        self.performSegue(withIdentifier: "connexionSegue", sender: email)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! LoginViewController
        destination.email = sender as? String
    }
        
    override func viewDidLoad() {
       
        super.viewDidLoad()
        password.isSecureTextEntry = true
        
    }
    
    // METHODS
    func makeAlert(titre: String?, message: String?) {
        let alert = UIAlertController(title: titre, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
   @IBAction func inscriptionButton(_ sender: Any) {
       if (nom.text == "") {
           makeAlert(titre: "Warning", message: "Please type your firstname")
           return
       }
       if (prenom.text == "") {
           makeAlert(titre: "Warning", message: "Please type your lastname")
           return
       }
       if (email.text == "") {
           makeAlert(titre: "Warning", message: "Please type your email")
           return
       }else if (email.text?.contains("@") == false){
           makeAlert(titre: "Warning", message: "Please type your email correctly")
           return
       }
       
       if (password.text == "") {
           makeAlert(titre: "Warning", message: "Please type your password")
           return
       }
       
              
       user.firstname = nom.text
       user.lastname = prenom.text
       user.email = email.text
       user.password = password.text
       user.pictureId = ""
       
       UserViewModel().inscription(user: user, completed: { [self] (success,response) in

           
           if success {
               print(response)
               let alert = UIAlertController(title: "Success", message: "Your account has been created.", preferredStyle: .alert)
               UserViewModel().ChangeProfilePic(id: (response?._id!)!, uiImage: self.currentPhoto!, completed: { [self] success in
                           if success {
                               self.present(Alert.makeAlert(titre: "Succes", message: "Photo modifié avec succés"),animated: true)
                           } else {
                               self.present(Alert.makeServerErrorAlert(),animated: true)
                           }
                       })
               let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                   self.goToLogin(email: self.user.email)
               }
               alert.addAction(action)
               self.present(alert, animated: true)
          } else {
              self.present(Alert.makeAlert(titre: "Error", message: "Account may already exist."), animated: true)
           }
           

       })
       
       
   }
  
      func gallery()
      {
          let myPickerControllerGallery = UIImagePickerController()
          myPickerControllerGallery.delegate = self
          myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
          myPickerControllerGallery.allowsEditing = true
          self.present(myPickerControllerGallery, animated: true, completion: nil)

      }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        
        currentPhoto = selectedImage
        self.profileImage.image = self.currentPhoto!

       /* UserViewModel().changerPhotoDeProfil( uiImage: selectedImage,completed: { [self] success in
            if success {
                profileImage.image = selectedImage
                self.present(Alert.makeAlert(titre: "Succes", message: "Photo modifié avec succés"),animated: true)
            } else {
                self.present(Alert.makeServerErrorAlert(),animated: true)
            }
        })*/
        
        self.dismiss(animated: true, completion: nil)
    }
    

      func showActionSheet(){

          let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Upload Image", comment: ""), message: nil, preferredStyle: .actionSheet)
          actionSheetController.view.tintColor = UIColor.black
          let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
              print("Cancel")
          }
          actionSheetController.addAction(cancelActionButton)


          let deleteActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Choose From Gallery", comment: ""), style: .default)
          { action -> Void in
              self.gallery()
          }

          actionSheetController.addAction(deleteActionButton)
          self.present(actionSheetController, animated: true, completion: nil)
      }




      @IBAction func changeProfilePic(_ sender: Any) {
          showActionSheet()
      }

       
           // performSegue(withIdentifier: "inscriptionSuivantSegue", sender: user)
       
       
       
       
       //        if (nom.text!.isEmpty) {
//            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your firstname"), animated: true)
//            return
//        }
//
//        if (prenom.text!.isEmpty) {
//            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your lastname"), animated: true)
//            return
//        }
//
//        if (email.text == "") {
//            makeAlert(titre: "Warning", message: "Please type your email")
//            return
//        }else if (email.text?.contains("@") == false){
//            makeAlert(titre: "Warning", message: "Please type your email correctly")
//            return
//        }
//
//        if (password.text == "") {
//            makeAlert(titre: "Warning", message: "Please type your password")
//            return
//        }
//
//        utilisateur?.idPhoto = ""
//        utilisateur?.nom = nom.text
//        utilisateur?.prenom = prenom.text
//        utilisateur?.email = email.text
//        utilisateur?.password = password.text
//
//
//        UserViewModel().register(nom: nom.text!, prenom: prenom.text!, email: email.text!, password: password.text!, idPhoto:  .image!, completed: { (success, response)  in
//
//            // STOP Spinner
////            child.willMove(toParent: nil)
////            child.view.removeFromSuperview()
////            child.removeFromParent()
//
//            if success {
//
//                let alert = UIAlertController(title: "Success", message: "Your account has been created.", preferredStyle: .alert)
//                let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
//                    self.goToLogin(email: self.utilisateur?.email)
//                }
//                alert.addAction(action)
//                self.present(alert, animated: true)
//            } else {
//                self.present(Alert.makeAlert(titre: "Error", message: "Account may already exist."), animated: true)
//            }
//
//            // STOP Spinner
////            child.willMove(toParent: nil)
////            child.view.removeFromSuperview()
////            child.removeFromParent()
//        })
//    }



//
//
//}
////
////    var registerViewModel = RegisterViewModel()
////
////    @IBOutlet weak var nom: UITextField!
////
////    @IBOutlet weak var prenom: UITextField!
////
////    @IBOutlet weak var email: UITextField!
////
////    @IBOutlet weak var password: UITextField!
////
////
////    @IBOutlet weak var photo: UIImageView!
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////
////       // let apimanager = APIManager()
////
////    }
////
////
//    @IBAction func nextBtn(_ sender: Any) {
//
//
//        utilisateurViewModel.inscription(nom: nom.text!, prenom: prenom.text!, email: email.text!,password: password.text!,completed: { (success, reponse) in
//
//                    if success {
//                        let user = reponse as! User
//
//                        print (user)
//                        self.performSegue(withIdentifier: "nextSegue", sender: nil)
//
//                    } else {
//
//                    }
//                })
//    }
//
//
//
//
//
//
//
}
