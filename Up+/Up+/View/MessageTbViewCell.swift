//
//  MessageTbViewCell.swift
//  Up+
//
//  Created by Dreamup on 2/10/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit

class MessageTbViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var messageLb: UILabel!
    @IBOutlet weak var timeLb: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
