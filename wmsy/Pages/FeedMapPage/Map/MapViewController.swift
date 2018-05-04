//
//  MapViewController.swift
//  wmsy
//
//  Created by C4Q on 5/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

protocol MapViewControllerDelegate: class {
    
}

class MapViewController: UIViewController {
    
    var delegate: MapViewControllerDelegate?
    let mapView = MapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(mapView)
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = . blue
        
        mapView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
}
