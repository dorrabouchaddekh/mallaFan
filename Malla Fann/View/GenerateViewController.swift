//
//  GenerateViewController.swift
//  Malla Fann
//
//  Created by dorra on 13/4/2022.
//

import UIKit

class GenerateViewController: UIViewController {


    @IBOutlet weak var qrImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func generateAction(_ sender: Any) {
        let myLink = UserDefaults.standard.string(forKey: "_id")
        print(myLink!)
        if let link = myLink{
            let combinedString = "\(link)"
            qrImageView.image = generateQRCode(Link:combinedString)
        }
    }
    
    func generateQRCode(Link:String) -> UIImage? {
        let link_data = Link.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator"){
            filter.setValue(link_data, forKey: "inputMessage")
            
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform){
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
}
