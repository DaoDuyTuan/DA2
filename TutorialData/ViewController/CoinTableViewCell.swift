//
//  CoinTableViewCell.swift
//  TutorialData
//
//  Created by Duy Tuan on 12/22/17.
//  Copyright © 2017 Duy Tuan. All rights reserved.
//

import UIKit

class CoinTableViewCell: UITableViewCell {
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var priceUsd: UILabel!
    @IBOutlet weak var coinNumber: UILabel!
    
    override func awakeFromNib() {
        self.priceUsd.textColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
    }
}
