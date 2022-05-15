//
//  AddViewController.swift
//  Malla Fann
//
//  Created by dorra on 19/4/2022.
//

import UIKit

class AddViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    //iboutlets
    @IBOutlet weak var imgPhoto: UIImageView!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var imageView: UIView!
    
    //var
    var videoUrl : UIImage?
    var publication = Publicationn()

    override func viewDidLoad() {
        super.viewDidLoad()
        //imageView.layer.cornerRadius = ROUNDED_RADIUS
        self.imgPhoto.layer.masksToBounds = true

    }
    
    
    @IBAction func btnTakePhoto(_ sender: Any) {
        showPhotoAlert()
    }
    
    
    func makeAlert(titre: String?, message: String?) {
        let alert = UIAlertController(title: titre, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
    
    
    //Add
    @IBAction func ajouterPublication(_ sender: Any) {
        if (descriptionTextField.text == "") {
            makeAlert(titre: "Warning", message: "Please type your firstname")
            return
        }
//        PublicationViewModel().modifierPublication(publication: publication, completed: { [self] (success,response) in
//
//
//            if success {
//                print(response)
//                let alert = UIAlertController(title: "Success", message: "Your account has been created.", preferredStyle: .alert)
        
   //     publication.description = descriptionTextField.text
        
//        PublicationViewModel().modifierPublication(publication: publication, completed: { [self] (success,response) in
//
        if (videoUrl == nil){
            self.present(Alert.makeAlert(titre: "Warning", message: "Choose a video"), animated: true)
            return
        }
        
        let publication = Publicationn( description: descriptionTextField.text, date: Date())
        
        PublicationViewModel().ajouterPublication(publication: publication, videoUrl: videoUrl! , completed: { [self] (success,response) in
            
            if success {
                print(response)
                let pubId = response!._id;
                let alert = UIAlertController(title: "Success", message: "Your account has been created.", preferredStyle: .alert)
                PublicationViewModel().modifierPublication(description: descriptionTextField.text!, _id: UserDefaults.standard.string(forKey: "_id")!,pubId: pubId!,completed: { [self] (success,response) in
                    if success {
                        self.present(Alert.makeAlert(titre: "Succes", message: "Photo modifié avec succés"),animated: true)
                    } else {
                        self.present(Alert.makeServerErrorAlert(),animated: true)
                    }
                    
                })
                    
                    
                    
                }else {
                    self.present(Alert.makeAlert(titre: "Error", message: "Account may already exist."), animated: true)
                 }
        })
                
                
}
        
        
        
        
//                PublicationViewModel().ajouterPublication(publication: publication, videoUrl: videoUrl! , completed: { [self] (success,response) in
//            if success {
//                PublicationViewModel().modifierPublication(publication: publication, completed: { [self] success in
//
//
//                    if success {
//                        print(response)
//                        let alert = UIAlertController(title: "Success", message: "Your account has been created.", preferredStyle: .alert)})
//                self.present(Alert.makeAlert(titre: "Success", message: "Post added"),animated: true)
//                self.present(Alert.makeSingleActionAlert(titre: "Success", message: "Post added", action: UIAlertAction(title: "Ok", style: .default, handler: { [self] UIAlertAction in
//
//                    imageView.layer.sublayers?.removeAll()
//                    videoUrl = nil
//                    descriptionTextField.text = ""
//                    //self.tabBarController!.selectedIndex = 0
//                })), animated: true)
//                    })
//                })
//            }
//    }})
//
//    }
    
    
    
    
    
    
    
    
    
    //func
    func showPhotoAlert(){
        let alert = UIAlertController(title: "Take Photo From:", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {action in
            self.getPhoto(type: .camera)

        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {action in
            self.getPhoto(type: .photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true , completion: nil )
    }
    
    
    func getPhoto( type : UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = type
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        guard  let image = info[.editedImage] as? UIImage else {
            print("image not found")
            return
        }
        imgPhoto.image = image
        self.videoUrl=image
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
            
            func prompt(title: String, message: String) {
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
                
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
            }
           
}
