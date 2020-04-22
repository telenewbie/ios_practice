//
//  RestaurantRoundCell.swift
//  FoodPin
//
//  Created by newbie on 2020/4/5.
//  Copyright © 2020 newbie. All rights reserved.
//

import UIKit

class RestaurantRoundCell: UITableViewCell {
    
    //界面上面有两个视图
    @IBOutlet  var thumbnailImageView: UIImageView!
    {
        didSet{
            thumbnailImageView.layer.cornerRadius=thumbnailImageView.frame.width/2
            thumbnailImageView.clipsToBounds = true
        }
    }
    @IBOutlet var nameLable :UILabel!
    
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var heartImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
