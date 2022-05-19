//
//  ModifierProfilViewController.swift
//  Malla Fann
//
//  Created by dorra on 12/5/2022.
//

import UIKit

class ModifierProfilViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // VAR
    var utilisateur: User?
    var currentPhoto : UIImage?
    
    // WIDGET
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var prenomTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var dateNaissancePicker: UIDatePicker!
    @IBOutlet weak var sexeChooser: UISegmentedControl!
    
    @IBOutlet weak var addPictureBtn: UIButton!
    // PROTOCOLS
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializePage()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
    }
    
    // METHODS
    func initializePage() {
        UserViewModel().recupererUtilisateurParToken(_id: UserDefaults.standard.string(forKey: "_id")!) { [self] success, result in
            self.utilisateur = result
            
            nomTextField.text = result?.firstname
            prenomTextField.text = result?.lastname

            self.profileImage.loadFrom(URLAddress: Constant.host+(result?.pictureId)!)
            if((result?.pictureId?.contains("https")) != nil) {
                                self.profileImage.loadFrom(URLAddress: result?.pictureId ?? "")
                            }
      //      ImageLoader.shared.loadImage(identifier: (utilisateur?.idPhoto)!, url: IMAGE_URL + (utilisateur?.idPhoto)!) { imageResp in
                
             //   profileImage.image = imageResp
            }
        
    }
    
    // ACTIONS
    @IBAction func modifierProfil(_ sender: Any) {
        print("Edited profile")
        
        if (nomTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your firstname"), animated: true)
            return
        }
        
        if (prenomTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your lastname"), animated: true)
            return
        }
        
        
        //utilisateur?.idPhoto = ""

        utilisateur?.firstname = nomTextField.text
        utilisateur?.lastname = prenomTextField.text

        
        
        UserViewModel().manipulerUtilisateur(utilisateur: utilisateur!,methode: .put, completed: { (success) in
            print(success)
            if success {
            } else {

            }
        })
        self.present(Alert.makeAlert(titre: "Success", message: "Profile edited successfully!"), animated: true)
      // self.dismiss(animated: true, completion: nil)
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
        UserViewModel().ChangeProfilePic(id:  UserDefaults.standard.string(forKey: "_id")!, uiImage: selectedImage,completed: { [self] success in
            if success {
                profileImage.image = selectedImage
                self.present(Alert.makeAlert(titre: "Succes", message: "Photo modifié avec succés"),animated: true)
                
            } else {
                self.present(Alert.makeServerErrorAlert(),animated: true)
            }
        })
        
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
    
    // ACTIONS
    @IBAction func changeProfilePic(_ sender: Any) {
        showActionSheet()
    }
    
    
    
}
