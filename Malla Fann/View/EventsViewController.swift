//
//  EventsViewController.swift
//  Malla Fann
//
//  Created by dorra on 18/5/2022.
//

import UIKit
import Foundation

class EventsViewController: UIViewController , UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate{
  
    var events : [Event] = []
    var event : Event?
    var eventImg = Event()
    
    
    var latitude: Double?
    var longitude: Double?
    var videoUrl : UIImage?
    
    @IBOutlet weak var eventDate: UIDatePicker!
    
    
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var imageView: UIView!
    
    
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgPhoto.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnTakePhoto(_ sender: Any) {
        showPhotoAlert()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell")
        
                let contentView = cell?.contentView
        
                let labelName = contentView?.viewWithTag(1) as! UILabel
                let labelCategorie = contentView?.viewWithTag(2) as! UILabel
                let labelCap = contentView?.viewWithTag(3) as! UILabel
        
//                var location = events[indexPath.row]
//                    labelName.text = location.name
//                    labelCategorie.text = location.categorie
//                    labelCap.text = String(location.capacity ?? 2)
        
        
        
                return cell!
    }
    func makeAlert(titre: String?, message: String?) {
        let alert = UIAlertController(title: titre, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }

    @IBAction func addLocation(_ sender: Any) {
        self.performSegue(withIdentifier: "openmap", sender: nil)
        
    }

    
    
    @IBAction func ajouterEvent(_ sender: Any) {
        if (name.text == "") {
            makeAlert(titre: "Warning", message: "Please type your firstname")
            return
        }
        
        let eventt = Event( name: name.text, date: Date())
        EventViewModel().ajouterEvent(eventt: eventt, videoUrl: videoUrl! ,completed:  { [self] (success,response) in
            
            if success {
                let eventId = response!._id;
                
                EventViewModel().addEvent(name: name.text!, date: date.date,startDate: "", longitude: (event?.longitude)!, latitude: (event?.latitude)!, _id: UserDefaults.standard.string(forKey: "_id")!,eventId: eventId!, completed: { [self] (success,response) in
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
////        EventViewModel().addEvent(event: event, completed: { [self] (success,response) in
//
//            if success {
//                print(response)
//                let pubId = response!._id;
//                let alert = UIAlertController(title: "Success", message: "Your account has been created.", preferredStyle: .alert)
//                PublicationViewModel().modifierPublication(description: descriptionTextField.text!, _id: UserDefaults.standard.string(forKey: "_id")!,pubId: pubId!,completed: { [self] (success,response) in
//                    if success {
//                        self.present(Alert.makeAlert(titre: "Succes", message: "Photo modifié avec succés"),animated: true)
//                    } else {
//                        self.present(Alert.makeServerErrorAlert(),animated: true)
//                    }
//
//                })
//
//
//
//                }else {
//                    self.present(Alert.makeAlert(titre: "Error", message: "Account may already exist."), animated: true)
//                 }
//        })
//
                
}
    
    
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
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
