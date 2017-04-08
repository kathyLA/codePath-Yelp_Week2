//
//  BusinessCell.swift
//  Yelp
//
//  Created by kathy yin on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import AFNetworking
class BusinessCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var priceRankingLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var businessTitle: UILabel!
    @IBOutlet weak var ratingView: UIImageView!
    var business: Business! {
        
        didSet{
            thumbImageView.setImageWith(business.imageURL!)
            distanceLabel.text = business.distance
            businessTitle.text = business.name
            ratingView.setImageWith(business.ratingImageURL!)
            reviewsCountLabel.text = String(describing: business.reviewCount?.intValue ?? 0) + "reviews"
            addressLabel.text = business.address
            categoryLabel.text = business.categories
            
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
