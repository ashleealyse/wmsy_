//
//  TimeCell.swift
//  wmsy_
//
//  Created by Lynk on 12/9/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit

class TimeCell: UITableViewCell {

     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
          commonInit()
      }
      
      required init?(coder: NSCoder) {
          super.init(coder: coder)
          commonInit()
      }
      
      
      
      
      func commonInit() {
          selectionStyle = .none

      }

}
