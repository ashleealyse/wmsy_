//
//  LocationDetailsTableViewCell.swift
//  wmsy
//
//  Created by C4Q on 3/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class LocationDetailsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "LocationDetailsTableViewCell"
    
    public var locationDetailsButton = UIButton()
    
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
        // Initialization code
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = .clear
        setupViews()
        placeholderTesting()
    }
    private func setupViews() {
        setupLocationDetailsButton()
    }
    private func setupLocationDetailsButton() {
        contentView.addSubview(locationDetailsButton)
        locationDetailsButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(contentView).inset(16)
            make.leading.trailing.equalTo(contentView).inset(40)
        }
    }
    private func placeholderTesting() {
        selectionStyle = .none
        locationDetailsButton.titleLabel?.numberOfLines = 0
        locationDetailsButton.setTitle("This is where the location stuff would be at for you to press", for: .normal)
        locationDetailsButton.setTitleColor(Stylesheet.Colors.WMSYPastelBlue, for: .normal)
        locationDetailsButton.backgroundColor = Stylesheet.Colors.WMSYSeaFoamGreen
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
