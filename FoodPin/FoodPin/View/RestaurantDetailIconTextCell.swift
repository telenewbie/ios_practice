//
//  RestaurantDetailIconTextCellTableViewCell.swift
//  FoodPin
//
//  Created by newbie on 2020/4/6.
//  Copyright © 2020 newbie. All rights reserved.
//

import UIKit

class RestaurantDetailIconTextCell: UITableViewCell {
    
    @IBOutlet var iconImageView:UIImageView!
    @IBOutlet var shortTextLabel:UILabel!{
        didSet{
            shortTextLabel.numberOfLines = 0
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
