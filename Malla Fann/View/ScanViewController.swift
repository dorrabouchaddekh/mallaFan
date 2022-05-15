//
//  ScanViewController.swift
//  Malla Fann
//
//  Created by dorra on 13/4/2022.
//

import UIKit
import SwiftUI

class ScanViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Show QrCode", for: .normal)
        button.backgroundColor = .systemYellow
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    @objc func didTapButton(){

        let vc = UIHostingController(rootView: ContentView(delegate: ContentViewDelegate()))
        present(vc, animated: true)
        
    }

}

