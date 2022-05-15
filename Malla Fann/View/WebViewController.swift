//
//  WebViewController.swift
//  Malla Fann
//
//  Created by dorra on 15/5/2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var url :String?
    @IBOutlet weak var webView: WKWebView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var myURL: URL!
        print(url!)
                        myURL = URL(string: url!)
                        let myRequest = URLRequest(url: myURL!)
                        webView.load(myRequest)
        // Do any additional setup after loading the view.
    }
    

}
