//
//  AddWhimLocationView.swift
//  wmsy
//
//  Created by C4Q on 3/21/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMaps



class AddWhimLocationView: UIView {
    var locationManager = CLLocationManager()
    var addWhimMap: GMSMapView!

    
    // map object
//    lazy var addWhimMap: GMSMapView = {
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        var map = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        return map
//    }()
    
    // current pin location label
    lazy var locationLabel: UILabel = {
       let lb = UILabel()
        lb.text = " Pin Location: "
        lb.numberOfLines = 0
        lb.layer.borderWidth = 0.5
        lb.layer.borderColor = Stylesheet.Colors.WMSYDeepViolet.cgColor
        return lb
    }()
    
    // select location button
    lazy var selectButton: UIButton = {
       let button = UIButton()
        button.setTitle("Set Whim Location", for: .normal)
        button.layer.borderWidth = 0.5
        button.backgroundColor = Stylesheet.Colors.WMSYDeepViolet.withAlphaComponent(0.8)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    // setup custom view
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        addWhimMap = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        addWhimMap.isMyLocationEnabled = true
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        
        addSubview(addWhimMap)
        addSubview(locationLabel)
        addSubview(selectButton)
    }
    
    private func setupConstraints() {
        
        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalTo(addWhimMap)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.05)
        }
        
        addWhimMap.snp.makeConstraints { (make) in
            make.top.equalTo(locationLabel.snp.bottom).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.8)
        }
        
        selectButton.snp.makeConstraints { (make) in
            make.top.equalTo(addWhimMap.snp.bottom).offset(5)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        
        
    }
}
