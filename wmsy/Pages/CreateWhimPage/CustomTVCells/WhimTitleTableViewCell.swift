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
        tf.backgroundColor = Stylesheet.Colors.WMSYSeaFoamGreen
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter a title for your Whim"
        return tf
    }()
    
    // Dynamic label with remaining characters out of 100
    lazy var charactersRemainingLabel: UILabel = {
        let lb = UILabel()
        lb.backgroundColor = Stylesheet.Colors.WMSYAshGrey
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
            make.top.equalTo(self.snp.top).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
        }
        
        addSubview(charactersRemainingLabel)
        charactersRemainingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleTextfield.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide).offset(5)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
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
