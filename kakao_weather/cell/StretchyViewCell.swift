//
//  StretchyViewCell.swift
//  kakao_weather
//
//  Created by 남기범 on 02/08/2019.
//  Copyright © 2019 남기범. All rights reserved.
//

import UIKit

class StretchyViewCell: UITableViewCell {

    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var min: UILabel!    
    @IBOutlet weak var weather: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
