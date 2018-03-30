//
//  FeedCell.swift
//  wmsy
//
//  Created by Ashlee Krammer on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

protocol FeedCellViewDelegate: class {
    
    func showOnMapButtonPressed(whim: Whim)
    
    func interestButtonClicked(whim: Whim)
    
    func userProfileButtonPressed(whim: Whim)
}

class FeedCell: UITableViewCell {
    
    var collapsedView = CollapsedFeedCellView()
    var expandedView = ExpandedFeedCellView()
    var collapsedConstraint: NSLayoutConstraint!
    var expandedConstraint: NSLayoutConstraint!
    var whim: Whim?
    
    weak var delegate: FeedCellViewDelegate?
    
    var isExpanded: Bool = false {
        didSet {
            collapsedConstraint.constant = isExpanded ? 170 : 70
            //            collapsedConstraint.isActive = !isExpanded
            //            expandedConstraint.isActive = isExpanded
        }
    }
    
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
        selectionStyle = .none
        setUpCollapsedView()
        setUpExpandedView()
        
       
        
        //        collapsedConstraint.isActive = !isExpanded
        collapsedConstraint.constant = isExpanded ? 170 : 70
        //        expandedConstraint.isActive = isExpanded
        self.clipsToBounds = true
        
        expandedView.showOnMapButton.addTarget(self, action: #selector(showOnMap), for: .touchUpInside)
        
        expandedView.interestedButton.addTarget(self, action: #selector(showInterest), for: .touchUpInside)
        
        collapsedView.userImageButton.addTarget(self, action: #selector(userProfileImageClicked), for: .touchUpInside)
    }
    
    @objc func showOnMap() {
        self.delegate?.showOnMapButtonPressed(whim: whim!)
    }
    
    @objc func showInterest() {
        self.delegate?.interestButtonClicked(whim: whim!)
    }
    
    @objc func userProfileImageClicked(){
        self.delegate?.userProfileButtonPressed(whim: whim!)
    }
    
    private func setUpCollapsedView() {
        contentView.addSubview(collapsedView)
        //        collapsedView.snp.makeConstraints { (make) in
        //            make.top.equalTo(safeAreaLayoutGuide)
        //            make.trailing.leading.equalTo(safeAreaLayoutGuide)
        //            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
        //        }
        collapsedView.translatesAutoresizingMaskIntoConstraints = false
        [collapsedView.topAnchor.constraint(equalTo: contentView.topAnchor),
         collapsedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         collapsedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         collapsedView.heightAnchor.constraint(equalToConstant: 70)]
            .forEach{$0.isActive = true}
        collapsedConstraint = contentView.bottomAnchor.constraint(equalTo: collapsedView.topAnchor, constant: 0)//collapsedView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        collapsedConstraint.isActive = true
        
    }
    
    private func setUpExpandedView() {
        contentView.addSubview(expandedView)
        expandedView.translatesAutoresizingMaskIntoConstraints = false
        [expandedView.topAnchor.constraint(equalTo: collapsedView.bottomAnchor),
         expandedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         expandedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         expandedView.heightAnchor.constraint(equalToConstant: 100)]
            .forEach{$0.isActive = true}
        expandedConstraint = expandedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    }
    
}

