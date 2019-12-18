//
//  UIViewExtention.swift
//  wmsy_
//
//  Created by Lynk on 12/8/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit


enum Side {
    case top, bottom, left, right
}

extension UITableView {
    func setBottomInset(to value: CGFloat) {
          let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)

          self.contentInset = edgeInset
          self.scrollIndicatorInsets = edgeInset
      }
}


extension UIView {
     func addSubviews(subviews:[UIView]) {
        subviews.forEach{
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
  
    
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
      let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: center.x - (self.frame.size.width * 0.95 / 2), y: self.frame.size.height - width, width: self.frame.size.width * 0.95, height: width)
      self.layer.addSublayer(border)
    }
    
    private func serveConstraint(item: UIView, side: Side) -> NSLayoutConstraint {
        switch side {
        case .top:
            return item.topAnchor.constraint(equalTo: topAnchor)
        case .bottom:
            return item.bottomAnchor.constraint(equalTo: bottomAnchor)
        case .left:
            return item.leadingAnchor.constraint(equalTo: leadingAnchor)
        case .right:
            return item.trailingAnchor.constraint(equalTo: trailingAnchor)
        }
    }
    
    
    func constrainToAllSides(item: UIView, sides: ([Side],[NSLayoutConstraint])) {
        var constraints: [NSLayoutConstraint] = []
        sides.0.forEach {
            constraints.append(serveConstraint(item: item, side: $0))
        }
        NSLayoutConstraint.activate(constraints+sides.1)
    }
}


extension UIImage {
    func darkened() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }

        guard let ctx = UIGraphicsGetCurrentContext(), let cgImage = cgImage else {
            return nil
        }

        // flip the image, or result appears flipped
        ctx.scaleBy(x: 1.0, y: -1.0)
        ctx.translateBy(x: 0, y: -size.height)

        let rect = CGRect(origin: .zero, size: size)
        ctx.draw(cgImage, in: rect)
        WmsyColors.darkPurple.withAlphaComponent(0.5).setFill()
        ctx.fill(rect)

        return UIGraphicsGetImageFromCurrentImageContext()
    }
    

}


extension UIColor {
    
    static let dynamicBorderColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return .systemGray5
        case .light, .unspecified:
            return .black
        @unknown default:
            return .black
        }
    }
    
}
