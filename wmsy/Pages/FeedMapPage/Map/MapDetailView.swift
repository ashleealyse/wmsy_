//
//  MapDetailView.swift
//  wmsy
//
//  Created by C4Q on 3/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

protocol mapDetailViewDelegate: class{
    func userPicturePressed()
    func interestPressed()
}

class MapDetailView: UIView {
    weak var delegate: mapDetailViewDelegate?

    lazy var userPicture: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleToFill
        button.imageView?.clipsToBounds = true
        button.addTarget(self, action: #selector(userPicturePressed), for: .touchUpInside)
        return button
    }()
    
    lazy var whimTitle: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var whimDescription: UILabel = {
        let label = UILabel()
        label.text = "description"
        label.font = UIFont(name: "Helvetica", size: 14)
        label.numberOfLines = 0
        return label
    }()

    lazy var interestedButton: UIButton = {
        let interestButton = UIButton()
        interestButton.addTarget(self, action: #selector(interestButtonPressed), for: .touchUpInside)
        interestButton.titleLabel?.textColor = .white
        interestButton.setTitle("Show Interest", for: .normal)
        return interestButton
    }()
    
    lazy var interestLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Show Interest"
        return lb
    }()
    
    
    @objc func userPicturePressed(){
        self.delegate?.userPicturePressed()
    }
    
    @objc func interestButtonPressed(){
        self.delegate?.interestPressed()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = UIColor.white
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(){
        setUpInterestButton()
        setUpUserPicture()
        setUpTitle()
        setUpDescription()
//        setUpInterestLabel()
    }
    
    private func setUpUserPicture(){
        addSubview(userPicture)
        userPicture.snp.makeConstraints { (make) in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.top.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(self.snp.height).multipliedBy(0.8)
            make.bottom.equalTo(interestedButton.snp.top)
        }
        
    }
    
    private func setUpTitle(){
        addSubview(whimTitle)
        whimTitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(5)
//            make.centerY.equalTo(userPicture.snp.centerY)
            make.leading.equalTo(userPicture.snp.trailing).offset(5)
            make.trailing.equalTo(self.snp.trailing)
        }
        
    }
    
    private func setUpDescription(){
        addSubview(whimDescription)
        whimDescription.snp.makeConstraints { (make) in
            make.top.equalTo(whimTitle.snp.bottom).offset(5)
            make.leading.equalTo(userPicture.snp.trailing).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }
        
    }
    
    
    private func setUpInterestButton() {
        addSubview(interestedButton)
        interestedButton.snp.makeConstraints { (make) in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setUpInterestLabel() {
        addSubview(interestLabel)
        interestLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(interestedButton.snp.leading).offset(-2)
            make.centerY.equalTo(interestedButton.snp.centerY)
        }
    }
    
    public func configureWith(_ whim: Whim, completion: @escaping () -> Void = {}) {
        let whimTitle = whim.title
        let expiration = whim.expiration
        let titleCount  = whim.title.count
        let customString = NSMutableAttributedString.init(string: "\(whimTitle) \(expiration)", attributes: [NSAttributedStringKey.font:UIFont(name: "Helvetica", size: 18.0)!])
        customString.addAttributes([NSAttributedStringKey.font:UIFont(name: "Helvetica", size: 14.0)!,NSAttributedStringKey.foregroundColor:UIColor.lightGray], range: NSRange(location:titleCount,length: expiration.count + 1))
        
        
        
        self.whimTitle.attributedText = customString
        self.whimDescription.text = whim.description
        DBService.manager.getUserImageURL(userID: whim.hostID) { (url) in
            self.userPicture.kf.setImage(with: URL(string: url), for: .normal, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cache, url) in
                self.userPicture.imageView?.setNeedsDisplay()
                //                let interests = AppUser.currentAppUser!.getInterestKeys()
                
                
                self.interestLabel.isHidden = (whim.hostID == AppUser.currentAppUser?.userID)
                self.interestedButton.isHidden = (whim.hostID == AppUser.currentAppUser?.userID)
                
                completion()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       self.userPicture.layer.cornerRadius = userPicture.frame.size.height / 2.0
    }
}
