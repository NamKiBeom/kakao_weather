//
//  EtcViewCell.swift
//  kakao_weather
//
//  Created by 남기범 on 02/08/2019.
//  Copyright © 2019 남기범. All rights reserved.
//

import UIKit

class EtcViewCell: UITableViewCell {
    @IBOutlet weak var smallLabel1: UILabel!
    @IBOutlet weak var smallLabel2: UILabel!
    @IBOutlet weak var bigLabel1: UILabel!
    @IBOutlet weak var bigLabel2: UILabel!
    @IBOutlet weak var bottom: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
