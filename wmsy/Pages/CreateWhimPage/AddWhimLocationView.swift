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

    // map object
    lazy var addWhimMap: GMSMapView = {
        
       let map = GMSMapView.map(withFrame: <#T##CGRect#>, camera: <#T##GMSCameraPosition#>)
        imageview.backgroundColor = .yellow
        return imageview
    }()
    
    // current pin location label
    lazy var locationLabel: UILabel = {
       let lb = UILabel()
        lb.text = "Selected Address: "
        lb.numberOfLines = 0
        lb.layer.borderWidth = 0.5
        lb.backgroundColor = .red
        return lb
    }()
    
    // select location button
    lazy var selectButton: UIButton = {
       let button = UIButton()
        button.setTitle("Select Location", for: .normal)
        button.layer.borderWidth = 0.5
        button.backgroundColor = .green
        button.setTitleColor(.black, for: .normal)
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
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        
        addSubview(addWhimMap)
        addSubview(locationLabel)
        addSubview(selectButton)
    }
    
    private func setupConstraints() {
        
        addWhimMap.snp.makeConstraints { (make) in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.5)
        }
        
        locationLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(addWhimMap)
            make.top.equalTo(addWhimMap.snp.bottom).offset(10)
        }
        
        selectButton.snp.makeConstraints { (make) in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.1)
        }
        
        
    }
}
