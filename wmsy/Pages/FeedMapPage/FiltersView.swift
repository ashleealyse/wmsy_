//
//  FiltersView.swift
//  wmsy
//
//  Created by C4Q on 3/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class FiltersView: UIView {

    // collection view for filtering categories
    
    
    // button to show full map view, to the left of the categories CV
    
    
    // segmented control for distances 0.5 mile, 1.0 miles, 5 miles, 10 miles
    
    
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
    }
    
    private func setupViews() {
        
    }

}
