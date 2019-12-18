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
        h.backgroundColor = WmsyColors.headerPurple
        h.delegate = self
        return h
    }()
    
    
    
    lazy var feedTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemGray6
        tv.register(CardCell.self, forCellReuseIdentifier: "CardCell")
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    
    lazy var filterBar: FilterBar = {
        let fb = FilterBar(frame: .zero, withClear: true)
        return fb
    }()
    
    var filterOpened = false {
        didSet{
            UIView.animate(withDuration: 0.5) {
                self.filterBarHeightConstraint?.constant = self.filterOpened ? 55 : 0
                self.layoutIfNeeded()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        addSubviews()
        constrainHeader()
        constrainFilterBar()
        constrainFeed()
        
    }
    
    func addSubviews() {
        addSubview(header)
        addSubview(feedTableView)
        addSubview(filterBar)
    }
    
    func constrainHeader() {
        header.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        header.topAnchor.constraint(equalTo: topAnchor),
        header.leadingAnchor.constraint(equalTo: leadingAnchor),
        header.trailingAnchor.constraint(equalTo: trailingAnchor),
        header.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func constrainFeed() {
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feedTableView.topAnchor.constraint(equalTo: filterBar.bottomAnchor),
            feedTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            feedTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func bottomConstraint(bottom: NSLayoutYAxisAnchor) {
        feedTableView.bottomAnchor.constraint(equalTo: bottom).isActive = true
    }
    
    var filterBarHeightConstraint: NSLayoutConstraint?
    
    
    func constrainFilterBar() {
        filterBar.translatesAutoresizingMaskIntoConstraints = false
        filterBarHeightConstraint = filterBar.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
                   filterBar.topAnchor.constraint(equalTo: header.bottomAnchor),
                   filterBar.leadingAnchor.constraint(equalTo: leadingAnchor),
                   filterBar.trailingAnchor.constraint(equalTo: trailingAnchor),
                   filterBarHeightConstraint!
               ])
    }
    
}


extension FeedView: wmsyHeaderDelegate {
    func filterSelected() {
        filterOpened.toggle()
    }
}





