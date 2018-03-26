//
//  FloatingPopsicleView.swift
//  wmsy
//
//  Created by Ashlee Krammer on 3/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class FloatingPopsicleView: UIView {

    lazy var imageViewOne: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "wmsyCategoryIcon").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Stylesheet.Colors.WMSYKSUPurple
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewTwo: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "wmsyCategoryIcon").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Stylesheet.Colors.WMSYKSUPurple
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewThree: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "wmsyCategoryIcon").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Stylesheet.Colors.WMSYKSUPurple
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewFour: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "wmsyCategoryIcon").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Stylesheet.Colors.WMSYKSUPurple
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewFive: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "wmsyCategoryIcon").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Stylesheet.Colors.WMSYKSUPurple
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewSix: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "wmsyCategoryIcon").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Stylesheet.Colors.WMSYKSUPurple
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewSeven: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "wmsyCategoryIcon").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Stylesheet.Colors.WMSYKSUPurple
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewEight: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "wmsyCategoryIcon").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Stylesheet.Colors.WMSYKSUPurple
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewNine: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "wmsyCategoryIcon").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = Stylesheet.Colors.WMSYKSUPurple
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewTen: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "wmsyCategoryIcon")
        imageView.tintColor = Stylesheet.Colors.WMSYKSUPurple
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewEleven: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "wmsyCategoryIcon")
        imageView.tintColor = Stylesheet.Colors.WMSYKSUPurple
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewTwelve: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "wmsyCategoryIcon")
        imageView.tintColor = Stylesheet.Colors.WMSYKSUPurple
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewThirteen: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "wmsyCategoryIcon")
        imageView.tintColor = Stylesheet.Colors.WMSYKSUPurple
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewFourteen: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "wmsyCategoryIcon")
        imageView.tintColor = Stylesheet.Colors.WMSYKSUPurple
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageViewFifteen: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  #imageLiteral(resourceName: "wmsyCategoryIcon")
        imageView.tintColor = Stylesheet.Colors.WMSYKSUPurple
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Inititalizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Functions
    private func commonInit() {
        backgroundColor = UIColor.white
        addSubviews()
        setupViews()
        animateView()
    }
    
    private func addSubviews() {
        addSubview(imageViewOne)
        addSubview(imageViewTwo)
        addSubview(imageViewThree)
        addSubview(imageViewFour)
        addSubview(imageViewFive)
        addSubview(imageViewSix)
        addSubview(imageViewSeven)
        
    }
    
    private func setupViews() {
        setupImageViewOne()
        setupImageViewTWo()
        setupImageViewThree()
        setupImageViewFour()
        setupImageViewFive()
        setupImageViewSix()
        setupImageViewSeven()
    }
    
    func animateTranslation(with valueOne: CGFloat, with valueTwo: CGFloat, with valueThree: CGFloat, for image: UIImageView) {
        let toValue = CATransform3DMakeTranslation(valueOne, valueTwo, valueThree)
        let animation = CABasicAnimation(keyPath: "transform")
        animation.toValue = toValue
        animation.duration = 50
        let image = image
        image.layer.add(animation, forKey: nil)
    }
    
    private func animations() {
        animateTranslation(with: 200, with: 400, with: -100, for: self.imageViewOne)
        animateTranslation(with: -800, with: -100, with: -100, for: self.imageViewTwo)
        animateTranslation(with: -200, with: -400, with: -100, for: self.imageViewThree)
        animateTranslation(with: -200, with: -400, with: -100, for: self.imageViewFour)
        animateTranslation(with: -200, with: 400, with: 100, for: self.imageViewFive)
        animateTranslation(with: -200, with: 400, with: 100, for: self.imageViewSix)
        animateTranslation(with: -200, with: -400, with: -100, for: self.imageViewSeven)
    }
    
//    private func fadeView() {
//        self.imageViewOne.layer.opacity = 0
//        self.imageViewTwo.layer.opacity = 0
//        self.imageViewThree.layer.opacity = 0
//        self.imageViewFour.layer.opacity = 0
//        self.imageViewFive.layer.opacity = 0
//        self.imageViewSix.layer.opacity = 0
//        self.imageViewSeven.layer.opacity = 0
//    }
    
    private func animateView() {
        UIView.animate(withDuration: 10.0, animations: {
            self.animations()
        })
//        }) { (success:Bool) in
//            if success {
//                //Fade the entire view out
//                UIView.animate(withDuration: 20.0, animations: {
//                    self.fadeView()
//                }) {(success) in
//                }
//            }
//        }
    }
    
    // MARK: - SNP Constraints
    private func setupImageViewOne() {
        imageViewOne.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(snp.centerY)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(snp.height).multipliedBy(0.2)
            make.width.equalTo(snp.height)
        }
    }
    

    private func setupImageViewTWo() {
        imageViewTwo.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(snp.centerY).offset(-100)
            make.centerX.equalTo(snp.centerX).offset(200)
            make.height.equalTo(snp.height).multipliedBy(0.2)
            make.width.equalTo(snp.height)
        }
    }
    

    private func setupImageViewThree() {
        imageViewThree.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(snp.centerY).offset(-100)
            make.centerX.equalTo(snp.centerX).offset(-175)
            make.height.equalTo(snp.height).multipliedBy(0.2)
            make.width.equalTo(snp.height)
        }
    }
    

    private func setupImageViewFour() {
        imageViewFour.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(snp.centerY).offset(200)
            make.centerX.equalTo(snp.centerX).offset(-200)
            make.height.equalTo(snp.height).multipliedBy(0.2)
            make.width.equalTo(snp.height)
        }
    }
    
    private func setupImageViewFive() {
        imageViewFive.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(snp.centerY).offset(89)
            make.centerX.equalTo(snp.centerX).offset(100)
            make.height.equalTo(snp.height).multipliedBy(0.2)
            make.width.equalTo(snp.height)
        }
    }
    
    private func setupImageViewSix() {
        imageViewSix.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(snp.centerY).offset(-24)
            make.centerX.equalTo(snp.centerX).offset(-70)
            make.height.equalTo(snp.height).multipliedBy(0.2)
            make.width.equalTo(snp.height)
        }
    }
    
    private func setupImageViewSeven() {
        imageViewSeven.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(snp.centerY).offset(80)
            make.centerX.equalTo(snp.centerX).offset(-100)
            make.height.equalTo(snp.height).multipliedBy(0.2)
            make.width.equalTo(snp.height)
        }
    }
    


}
