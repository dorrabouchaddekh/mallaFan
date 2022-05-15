//
//  OthersLinkViewController.swift
//  Malla Fann
//
//  Created by dorra on 15/5/2022.
//

import UIKit
import SwiftUI
import Combine

class OthersLinkViewController: UIViewController {
    
    private var cancellable: AnyCancellable!

    var code: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let delegate = ContentViewDelegate()
        
        let controller = UIHostingController(rootView: ContentView(delegate: ContentViewDelegate()))
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(controller)
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
        
        self.cancellable = delegate.$codes.sink{ codes in
            print(codes)
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    


}
