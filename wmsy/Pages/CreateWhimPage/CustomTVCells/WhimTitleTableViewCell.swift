//
//  TitleTableViewCell.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class WhimTitleTableViewCell: UITableViewCell {

    // Title Textfield with max 100 characters
    lazy var titleTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter a title for your Whim"
        return tf
    }()
    
    // Dynamic label with remaining characters out of 100
    lazy var charactersRemainingLabel: UILabel = {
        let lb = UILabel()
        lb.text = "100 Characters Remaining"
        return lb
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpView() {
        setUpConstraints()
    }
    
    func setUpConstraints() {
        addSubview(titleTextfield)
        titleTextfield.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.5)
        }
        
        addSubview(charactersRemainingLabel)
        charactersRemainingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleTextfield.snp.bottom)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.5)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
