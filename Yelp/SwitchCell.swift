//
//  SwitchCell.swift
//  Yelp
//
//  Created by kathy yin on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate{
  @objc optional func SwitchCell(switchCell: SwitchCell, didChangeValue: Bool)
}

class SwitchCell: UITableViewCell {
    
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    weak var delegate: SwitchCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onSwitchValueChange(_ sender: Any) {
        delegate?.SwitchCell?(switchCell: self, didChangeValue: settingSwitch.isOn)
        
    }
}
