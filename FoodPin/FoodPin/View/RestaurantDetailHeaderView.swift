//
//  RestaurantDetailHeaderView.swift
//  FoodPin
//
//  Created by newbie on 2020/4/6.
//  Copyright © 2020 newbie. All rights reserved.
//

import UIKit

class RestaurantDetailHeaderView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet var headerImageView:UIImageView!
    @IBOutlet var nameLabel:UILabel!
    {
        didSet{
            nameLabel.numberOfLines=0
        }
    }
    @IBOutlet var typeLabel:UILabel!
    {
        didSet{
            // MARK: 设置圆角
            typeLabel.layer.cornerRadius=10.0
            typeLabel.layer.masksToBounds=true
            
        }
    }
    @IBOutlet var heartImageView:UIImageView!
        {
        didSet{
            heartImageView.image = UIImage(named: "heart-tick")?.withRenderingMode(.alwaysTemplate)
            heartImageView.tintColor = .white
        }
    }

}
