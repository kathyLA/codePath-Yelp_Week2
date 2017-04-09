//
//  ButtonCell.swift
//  Yelp
//
//  Created by kathy yin on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class CheckButtonCell: UITableViewCell {

    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var buttonLabel: UILabel!
    var checkCircleImg: UIImage = (UIImage.init(named: "ic_check_circle")?.withRenderingMode(.alwaysTemplate))!
    var isChecked: Bool = false {
        didSet {
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    @IBAction func onCheck(_ sender: Any) {
       
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
