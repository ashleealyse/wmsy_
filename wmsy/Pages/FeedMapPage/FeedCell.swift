//
//  FeedCell.swift
//  wmsy
//
//  Created by Ashlee Krammer on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit


class FeedCell: UITableViewCell {

    var isExpanded = false {
        didSet {
            expandedConstraints.forEach{$0.isActive = isExpanded}
            collapsedConstraints.forEach{$0.isActive = !isExpanded}
            expandedView.isHidden = !isExpanded
            collapsedView.isHidden = isExpanded
        }
    }
    var collapsedView = CollapsedFeedCellView()
    var expandedView = ExpandedFeedCellView()
    var collapsedConstraints = [NSLayoutConstraint]()
    var expandedConstraints = [NSLayoutConstraint]()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setUpCollapsedView()
        setUpExpandedView()
        collapsedConstraints.forEach{$0.isActive = true}
        expandedView.isHidden = true
        selectionStyle = .none
    }
    
    private func setUpCollapsedView() {
        contentView.addSubview(collapsedView)
        collapsedView.translatesAutoresizingMaskIntoConstraints = false
        collapsedConstraints = [collapsedView.topAnchor.constraint(equalTo: contentView.topAnchor),
                                collapsedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                collapsedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                collapsedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
         ]
        
    }
    
    private func setUpExpandedView() {
        contentView.addSubview(expandedView)
        expandedView.translatesAutoresizingMaskIntoConstraints = false
        expandedConstraints = [expandedView.topAnchor.constraint(equalTo: contentView.topAnchor),
                               expandedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                               expandedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                               expandedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
    }
    
}
