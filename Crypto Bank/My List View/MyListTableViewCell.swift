//
//  MyListTableViewCell.swift
//  Crypto Bank
//
//  Created by Yujia on 2022/4/24.
//

import UIKit

class MyListTableViewCell: UITableViewCell {

    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var cryptoImage: UIImageView!
    @IBOutlet weak var cryptoName: UILabel!
    
    @IBOutlet weak var dateSt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
