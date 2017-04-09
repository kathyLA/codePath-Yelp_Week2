//
//  ButtonCell.swift
//  Yelp
//
//  Created by kathy yin on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit


class CheckCircleCell: UITableViewCell {
    
    @IBOutlet weak var checkCircleImageView: UIImageView!
    @IBOutlet weak var checkCircleLabel: UILabel!
    var checkCircleImg: UIImage = (UIImage.init(named: "ic_check_circle")?.withRenderingMode(.alwaysTemplate))!
    var isCheck: Bool = false {
        didSet {
            self.checkCircleImageView.tintColor = isCheck ? UIColor.red : UIColor.lightGray
        }
    }
  
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.checkCircleImageView.image = checkCircleImg
        self.checkCircleImageView?.tintColor = UIColor.lightGray
        
    }
    
    //
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
