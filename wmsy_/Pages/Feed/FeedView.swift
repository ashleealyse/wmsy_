//
//  FeedView.swift
//  wmsy_
//
//  Created by Lynk on 12/4/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit


class FeedView: UIView {
    
    lazy var header: WmsyHeader = {
        let h = WmsyHeader()
        h.backgroundColor = .purple
        return h
    }()
    
    
    
    lazy var feedTableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        addSubview(header)
        addSubview(feedTableView)
        header.translatesAutoresizingMaskIntoConstraints = false
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor),
            header.leadingAnchor.constraint(equalTo: leadingAnchor),
            header.trailingAnchor.constraint(equalTo: trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 125),
            feedTableView.topAnchor.constraint(equalTo: header.bottomAnchor),
            feedTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            feedTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            feedTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
