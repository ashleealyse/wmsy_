//
//  FooterTabDotsView.swift
//  wmsy
//
//  Created by C4Q on 3/22/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class FooterTabDotsView: UIView {
    
    var threeDotsConstraints: [NSLayoutConstraint] = []
    var twoDotsConstraints: [NSLayoutConstraint] = []
    var isChatRoomVisible: Bool = false {
        didSet {
            threeDotsConstraints.forEach{$0.isActive = isChatRoomVisible}
            twoDotsConstraints.forEach{$0.isActive = !isChatRoomVisible}
            dotThree.isHidden = !isChatRoomVisible
        }
    }
    
    let roundishContainerView = UIView()
    let dotOne = UIView()
    let dotTwo = UIView()
    let dotThree = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
//        backgroundColor = .white
        setupViews()
        threeDotsConstraints.forEach{$0.isActive = isChatRoomVisible}
        twoDotsConstraints.forEach{$0.isActive = !isChatRoomVisible}
        dotThree.isHidden = !isChatRoomVisible
    }
    
    private func setupViews() {
        setupRoundishContainerView()
        setupDotOne()
        setupDotTwo()
        setupDotThree()
    }
    private func setupRoundishContainerView() {
        roundishContainerView.backgroundColor = Stylesheet.Colors.WMSYShadowBlue
        addSubview(roundishContainerView)
        roundishContainerView.translatesAutoresizingMaskIntoConstraints = false
        [roundishContainerView.topAnchor.constraint(equalTo: self.topAnchor),
         roundishContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         roundishContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         roundishContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)]
            .forEach{$0.isActive = true}
        
        roundishContainerView.layer.cornerRadius = 10
    }
    private func setupDotOne() {
        dotOne.backgroundColor = Stylesheet.Colors.WMSYPastelBlue
        addSubview(dotOne)
        dotOne.translatesAutoresizingMaskIntoConstraints = false
        [dotOne.widthAnchor.constraint(equalToConstant: 9),
         dotOne.heightAnchor.constraint(equalTo: dotOne.widthAnchor),
         dotOne.leadingAnchor.constraint(equalTo: roundishContainerView.leadingAnchor, constant: 5),
         dotOne.topAnchor.constraint(equalTo: roundishContainerView.topAnchor, constant: 5),
         dotOne.bottomAnchor.constraint(equalTo: roundishContainerView.bottomAnchor, constant: -5),
         dotOne.centerYAnchor.constraint(equalTo: roundishContainerView.centerYAnchor)]
            .forEach{$0.isActive = true}
        
        dotOne.layer.cornerRadius = 5
    }
    private func setupDotTwo() {
        dotTwo.backgroundColor = Stylesheet.Colors.WMSYPastelBlue
        addSubview(dotTwo)
        dotTwo.translatesAutoresizingMaskIntoConstraints = false
        [dotTwo.widthAnchor.constraint(equalToConstant: 9),
         dotTwo.heightAnchor.constraint(equalTo: dotTwo.widthAnchor),
         dotTwo.leadingAnchor.constraint(equalTo: dotOne.trailingAnchor, constant: 5),
         dotTwo.centerYAnchor.constraint(equalTo: roundishContainerView.centerYAnchor)]
            .forEach{$0.isActive = true}
        let trailingConstraint = dotTwo.trailingAnchor.constraint(equalTo: roundishContainerView.trailingAnchor, constant: -5)
        twoDotsConstraints.append(trailingConstraint)
        
        dotTwo.layer.cornerRadius = 5
    }
    private func setupDotThree() {
        dotThree.backgroundColor = Stylesheet.Colors.WMSYPastelBlue
        addSubview(dotThree)
        dotThree.translatesAutoresizingMaskIntoConstraints = false
        [dotThree.widthAnchor.constraint(equalToConstant: 9),
         dotThree.heightAnchor.constraint(equalTo: dotThree.widthAnchor),
         dotThree.leadingAnchor.constraint(equalTo: dotTwo.trailingAnchor, constant: 5),
         dotThree.centerYAnchor.constraint(equalTo: roundishContainerView.centerYAnchor)]
            .forEach{$0.isActive = true}
        let trailingConstraint = dotThree.trailingAnchor.constraint(equalTo: roundishContainerView.trailingAnchor, constant: -5)
        threeDotsConstraints.append(trailingConstraint)
        
        dotThree.layer.cornerRadius = 5
    }
}
