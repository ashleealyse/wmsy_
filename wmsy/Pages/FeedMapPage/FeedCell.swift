//
//  FeedCell.swift
//  wmsy
//
//  Created by Ashlee Krammer on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

protocol FeedCellViewDelegate: class {
    
    func showOnMapButtonPressed(whim: Whim)
    
    func interestButtonClicked(whim: Whim)
    
    func userProfileButtonPressed(whim: Whim)
}

class FeedCell2: UITableViewCell {
    
    let marginsContainerView = UIView()
    let collapsedView = CollapsedFeedCellView()
    let expandedView = ExpandedFeedCellView()
    
    var contentViewBottomPin: Constraint?
    var isExpanded: Bool = false {
        didSet {
            resize(isExpanded)
        }
    }
    
    var whim: Whim? {
        didSet {
            self.loadContent()
        }
    }
//    private var invalidatePreviousAsyncCalls: Bool = false
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
        self.backgroundColor = Stylesheet.Colors.WMSYGray
        self.clipsToBounds = true
        
        self.setupSubviews()
        
    }
    private func setupSubviews() {
        self.addSubviews()
        self.customizeSubviews()
        self.constrainSubviews()
    }
    private func addSubviews(){
        self.contentView.addSubview(marginsContainerView)
        self.marginsContainerView.addSubview(collapsedView)
        self.marginsContainerView.addSubview(expandedView)
    }
    private func customizeSubviews() {
        self.customizeMarginsContainerView()
        self.customizeCollapsedView()
        self.customizeExpandedView()
    }
    private func constrainSubviews() {
        self.constrainMarginsContainerView()
        self.constrainCollapsedView()
        self.constrainExpandedView()
    }
    
    // MARK: - MarginsContainerView
    private func customizeMarginsContainerView() {
        marginsContainerView.clipsToBounds = true
    }
    private func constrainMarginsContainerView() {
        marginsContainerView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView).inset(8).priority(ConstraintPriority.init(999))
        }
    }
    
    // MARK: - CollapsedView
    private func customizeCollapsedView(){
        self.collapsedView.backgroundColor = .white
    }
    private func constrainCollapsedView() {
        collapsedView.snp.makeConstraints { (make) in
            make.height.equalTo(70).priority(ConstraintPriority.high)
            make.top.leading.trailing.equalTo(marginsContainerView)
            contentViewBottomPin = make.bottom.equalTo(marginsContainerView).constraint
        }
    }
    
    // MARK: - ExpandedView
    private func customizeExpandedView() {
        expandedView.backgroundColor = .white
    }
    private func constrainExpandedView() {
        expandedView.snp.makeConstraints { (make) in
            make.top.equalTo(collapsedView.snp.bottom)
            make.leading.trailing.equalTo(marginsContainerView)
            make.height.equalTo(100)
        }
    }
    
    // MARK: - Expansion Animation
    private func resize(_ expanded: Bool){
        contentViewBottomPin?.deactivate()
        if expanded {
            expandedView.snp.makeConstraints { (make) in
                contentViewBottomPin = make.bottom.equalTo(marginsContainerView).constraint
            }
        } else {
            collapsedView.snp.makeConstraints { (make) in
                contentViewBottomPin = make.bottom.equalTo(marginsContainerView).constraint
            }
        }
    }
    
    // MARK: - Load Data
    private func loadContent() {
        guard let whim = whim else { return }
        let time = whim.getTimeRemaining()
        let titleCount = whim.title.count
        
        let customString = NSMutableAttributedString.init(string: "\(whim.title) \(time)", attributes: [NSAttributedStringKey.font:UIFont(name: "Helvetica", size: 16.0)!])
        customString.addAttributes([NSAttributedStringKey.font:UIFont(name: "Helvetica", size: 14.0)!,NSAttributedStringKey.foregroundColor:UIColor.lightGray], range: NSRange(location:titleCount,length: time.count + 1))
        
        
        self.collapsedView.postTitleLabel.attributedText = customString
        self.collapsedView.categoryIcon.image = UIImage(named: "\(whim.category.rawValue.lowercased())CategoryIcon")
        
        DBService.manager.getUserImageURL(userID: whim.hostID) { [whim] (url) in
            guard self.whim == whim else { return }
            self.collapsedView.userImageButton.imageView?.kf.setImage(with: URL(string: url), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
                self.collapsedView.userImageButton.setImage(image, for: .normal)
            })
        }
        
        self.expandedView.postDescriptionTF.text = whim.description
        let interests = AppUser.currentAppUser?.getInterestKeys() ?? []
        if interests.contains(whim.id){
            self.expandedView.interestedButton.titleLabel?.textColor = .white
            self.expandedView.interestedButton.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.5)
            self.expandedView.interestedButton.setTitle("Remove Interest", for: .normal)
        }else{
            self.expandedView.interestedButton.titleLabel?.textColor = .white
            self.expandedView.interestedButton.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.8)
            self.expandedView.interestedButton.setTitle("Show Interest", for: .normal)
        }
        
        if whim.hostID == AppUser.currentAppUser?.userID{
            self.expandedView.interestedButton.isHidden = true
            self.expandedView.showOnMapButton.isHidden = true
            return
        }
        self.expandedView.interestedButton.isHidden = false
        self.expandedView.showOnMapButton.isHidden = false
    }
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.invalidatePreviousAsyncCalls = true
//    }
    
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
        self.backgroundColor = Stylesheet.Colors.WMSYGray
       self.selectionStyle = .none
        
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
        [collapsedView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
         collapsedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,  constant: 8),
         collapsedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
         collapsedView.heightAnchor.constraint(equalToConstant: 70)]
            .forEach{$0.isActive = true}
        collapsedConstraint = contentView.bottomAnchor.constraint(equalTo: collapsedView.topAnchor, constant: 8)//collapsedView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        collapsedConstraint.isActive = true
        
    }
    
    private func setUpExpandedView() {
        contentView.addSubview(expandedView)
        expandedView.translatesAutoresizingMaskIntoConstraints = false
        [expandedView.topAnchor.constraint(equalTo: collapsedView.bottomAnchor),
         expandedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
         expandedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
         expandedView.heightAnchor.constraint(equalToConstant: 100)]
            .forEach{$0.isActive = true}
        expandedConstraint = expandedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 22)
    }
    
    
}

