//
//  MapViewController.swift
//  wmsy
//
//  Created by C4Q on 5/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

protocol MapViewControllerDelegate: class {
    
}

class MapViewController: UIViewController {
    
    var delegate: MapViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = . blue
    }
}
