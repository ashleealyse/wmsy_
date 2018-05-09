//
//  FeedMapParentViewController+MapViewControllerDelegate.swift
//  wmsy
//
//  Created by C4Q on 5/6/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import CoreLocation

extension FeedMapParentViewController: MapViewControllerDelegate {
    func mapView(_ mapView: MapViewController, didChangeLocation location: CLLocation) {
        self.currentLocation = location
        self.loadData()
    }
}
