//
//  CustomCell.swift
//  To Do List
//
//  Created by Ben Wong on 2016-09-25.
//  Copyright © 2016 Ben Wong. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var noteText: UILabel!
    
    @IBOutlet weak var dateText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
