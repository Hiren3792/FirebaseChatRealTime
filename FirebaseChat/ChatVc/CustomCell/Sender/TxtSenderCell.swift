//
//  TxtSenderCell.swift
//  TCHSApp
//
//  Created by Mac on 06/01/22.
//  Copyright © 2022 My Mac. All rights reserved.
//

import UIKit

class TxtSenderCell: UITableViewCell {

    @IBOutlet weak var lblTxt: PaddingLabel!
    
    @IBOutlet weak var lblTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupMessage(messageModel: Message) {
        lblTxt.text = messageModel.messageText as String
        lblTime.text = messageModel.messageTime as String
    }

}
