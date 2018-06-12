//
//  MenuChatView.swift
//  wmsy
//
//  Created by C4Q on 3/22/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class MenuChatView: UICollectionViewCell {
    
    let chatViewVC = ChatRoomVCTest()
    var chatView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        
        setupViews()
    }
    private func setupViews() {
        chatView = chatViewVC.view
        contentView.addSubview(chatView)
        chatView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
}
