//
//  LocationCell.swift
//  wmsy_
//
//  Created by Lynk on 12/9/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit
import MapKit

class LocationCell: UITableViewCell {

    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        return map
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    
    
    func commonInit() {
        selectionStyle = .none
        backgroundColor = .systemGray6
        addSubviews(subviews: [mapView])
        constrainToAllSides(item: mapView, sides: ([],[mapView.topAnchor.constraint(equalTo: topAnchor, constant: 11),
        mapView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22),
        mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
        mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3)]))

    }
}
