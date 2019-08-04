//
//  DescriptionCell.swift
//  kakao_weather
//
//  Created by 남기범 on 04/08/2019.
//  Copyright © 2019 남기범. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {

    @IBOutlet weak var DescriptionText: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
